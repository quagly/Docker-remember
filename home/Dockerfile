FROM root
LABEL maintainer="Michael West <quagly@gmail.com>"

USER developer
ENV HOME /home/developer

# set up home dir
RUN echo '20171230' > /dev/null &&\
	 git clone https://github.com/quagly/dotfiles.git $HOME/.dotfiles

WORKDIR $HOME/.dotfiles

RUN stow bash;\
	stow vim;\
  stow tmux

WORKDIR $HOME

# configure vim
RUN git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
# command to install plugins, returns non-zero exit code but works.
# added true to the end until I can figure it out
# maybe still related to no interactivity despite -E?
RUN vim -E -u NONE -S $HOME/.vimrc +PluginInstall +qall || true

# add a bin directory for my executable that will be in $PATH
RUN mkdir $HOME/bin
ENV PATH $PATH:$HOME/bin
