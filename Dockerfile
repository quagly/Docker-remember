FROM centos:centos7
MAINTAINER Michael West <Michael.West@cambiahealth.com>

# note that this can be used as a mustache template 
# intention is to set proxy and set epel repository to use http
# to support use as a Dockerfile mustache delimiter is hashtags instead of brackets 
# because the delimiter is changed to get output that is not HTML escaped use 
# delim, delim, ampersand, space, var, delim, delim
# as described in the docs
# https://mustache.github.io/mustache.5.html

# set up yum http proxy if needed for example
#RUN echo -e 'proxy=http://proxy.regence.com:8080' >> /etc/yum.conf
##& PROXY##

RUN yum -y update;

RUN yum -y install epel-release

# replace with sed command to change https to http for epel repo if needed
#RUN sed -i "s/mirrorlist=https/mirrorlist=http/" /etc/yum.repos.d/epel.repo
##& SED##

# install development tools.  Just for compiling python we need more than half of them.
# this was my first Dockerfile.  Now I understand taht installing a group like this is not best practice
# install only what you need.  I've lost track of exactly what I need now.  Try taking this out and see what 
# failed due to missing dependencies.  I think I will be missing some python compile dependencies.
RUN yum groups mark install "Development Tools";\
	yum groups mark convert "Development Tools";\
  yum -y groupinstall "Development Tools";

# install additional packages required to compile python, tmux
RUN yum -y install zlib-devel bzip2-devel readline-devel sqlite-devel openssl openssl-devel libevent libevent-devel

WORKDIR /tmp
# install latest tmux.  Latest centos version is only 1.8 and is not compatible with my tmux.conf
RUN git clone https://github.com/tmux/tmux.git &&\
	cd tmux && \
	sh autogen.sh && \
	./configure && \
	make && \
	make install && \
	rm -rf /tmp/tmux 
	

# setup user with no files in home directory
RUN mkdir /tmp/skel;\
	 useradd -m -k /tmp/skel developer

# install user packages
RUN yum -y install stow vim;\
	yum clean all



USER developer
ENV HOME /home/developer

# set up home dir
RUN echo '20170628' > /dev/null &&\
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


# test by cd to python dir and run tox

USER developer
ENV HOME  /home/developer
WORKDIR $HOME

# install all needed versions of python
RUN git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv

ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

RUN pyenv install 2.7.13
RUN pyenv install 3.3.6 
RUN pyenv install 3.4.6 
RUN pyenv install 3.5.3 
RUN pyenv install 3.6.1
RUN pyenv rehash

RUN pyenv global 2.7.13

# install application demonstrating using tox to test multiple python versions
# and coverage report and api documentation 
RUN pip --no-cache-dir install tox

# get my python project
RUN echo '20170625' >/dev/null;\
		git clone https://github.com/quagly/cfn-manage.git ~/python/cfn-manage

# set default AWS region
RUN mkdir ~/.aws &&\
 	  echo -e "[default]\nregion = us-west-2" > ~/.aws/config



USER developer
ENV HOME  /home/developer
WORKDIR $HOME

# install gvm
RUN curl -s "https://get.sdkman.io" | bash 
# use /home/developer for strange error where SDKMAN_DIR cannot use ~ for HOME
# symptom is file not found
RUN echo -e "export SDKMAN_DIR=/home/developer/.sdkman" >> $HOME/.bash_profile 
RUN	echo -e 'source "/home/developer/.sdkman/bin/sdkman-init.sh"' >> $HOME/.bash_profile

# need 'yes' because sdk is a shell function, not an executable
RUN yes | /bin/bash -l -c 'sdk install java' && \
RUN yes | /bin/bash -l -c 'sdk install groovy' && \
    yes | /bin/bash -l -c 'sdk install gradle'

# cleanup sdk
RUN yes | /bin/bash -l -c 'sdk flush candidates' && \
	  yes | /bin/bash -l -c 'sdk flush broadcast' && \
  	yes | /bin/bash -l -c 'sdk flush archives' && \
	  yes | /bin/bash -l -c 'sdk flush temp'

# get my groovy project 
 RUN echo '20170629' >/dev/null;\
    git clone https://github.com/quagly/neo4j-experiments-as-tests.git ~/groovy/neo4j