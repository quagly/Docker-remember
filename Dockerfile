FROM centos:centos7
LABEL maintainer="Michael West <quagly@gmail.com>"

# note that this can be used as a mustache template
# intention is to set proxy and set epel repository to use http
# to support use as a Dockerfile mustache delimiter is hashtags instead of brackets
# because the delimiter is changed to get output that is not HTML escaped use
# delim, delim, ampersand, space, var, delim, delim
# as described in the docs
# https://mustache.github.io/mustache.5.html

# set up yum http proxy if needed for example
#RUN echo -e 'proxy=http://proxy.domain.com:8080' >> /etc/yum.conf
##& PROXY##

RUN yum -y update;

RUN yum -y install epel-release

# replace with sed command to change https to http for epel repo if needed
#RUN sed -i "s/mirrorlist=https/mirrorlist=http/" /etc/yum.repos.d/epel.repo
##& SED##

# development tools has more than I need
#RUN yum groups mark install "Development Tools";\
#	yum groups mark convert "Development Tools";\
#  yum -y groupinstall "Development Tools";

# install additional packages required to compile python
# patch is only required by python 3.3 to patch ssl
# tmux requires aclocal command from automake package.  Too bad as it only needs aclocal and automake has many depenencies.
# zip and unzip is required by sdkman for java/groovy
RUN yum -y install gcc git curl make patch zlib-devel bzip2-devel readline readline-devel sqllite sqlite-devel openssl openssl-devel libevent libevent-devel && \
	  yum -y install automake && \
		yum -y install zip unzip

WORKDIR /tmp
# install latest tmux.  Latest centos version is only 1.8 and is not compatible with my tmux.conf
# alternativly add yum repo with latest packages like this
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

# clean up yum cruft if any
RUN rm -rf /var/cache/yum



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


# test by cd to python dir and run tox

USER developer
ENV HOME  /home/developer
WORKDIR $HOME

# install python install manager
RUN echo '20170930' > /dev/null &&\
	 git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv

ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
# required compilation option for Gildas-Python binding
ENV PYTHON_CONFIGURE_OPTS="--enable-shared"

# install all supported versions of python
# and set default global python.
# Note that default version takes effect at login
# not in this file
RUN pyenv install 2.7.14 && \
  pyenv install 3.4.7 && \
  pyenv install 3.5.4 && \
  pyenv install 3.6.4 && \
  pyenv rehash && \
  pyenv global 3.6.4

# use this python version for the remaining python commands
# this works great for the docker build
# but breaks use of a container as .python-version files
# are ignored when this is set
# docker does not seem to support unseting environmnent variables in a build
ENV PYENV_VERSION=3.6.4

# install application demonstrating using tox to test multiple python versions
# and coverage report and api documentation
RUN pip --no-cache-dir install tox

# get my cfn-manage python project
RUN echo '20171230' >/dev/null && \
		git clone https://github.com/quagly/cfn-manage.git ~/python/cfn-manage

WORKDIR $HOME/python/cfn-manage

# get cfn-manage dependencies and link live cfn-manange repo to python environment
RUN python ./setup.py develop

# get my cfn-use python project
# and install dependencies into default python
RUN echo '20171227' >/dev/null && \
		git clone https://github.com/quagly/cfn-use.git ~/python/cfn-use && \
    pip --no-cache-dir install -r ~/python/cfn-use/requirements.txt

# set default AWS region
RUN mkdir ~/.aws && \
 	  echo -e "[default]\nregion = us-west-2" > ~/.aws/config

WORKDIR $HOME


# uses login shell but that doesn't work with install sdk
# it writes the files to $HOME/~/.sdkman instead of $HOME/.sdkman
# but be related to echo problem below

USER developer
ENV HOME  /home/developer
WORKDIR $HOME

# had trouble with sh and sdkman as noted below
# should I set the shell back after sdk is complete?
SHELL ["/bin/bash", "--login", "-c"]

# install sdk
RUN curl -s "https://get.sdkman.io" | bash

# use bash login shell
# use /home/developer for strange error where SDKMAN_DIR cannot use ~ for HOME
# symptom is file not found
# I think this is related to posix shell issue and existing .bash_profie settings
# RUN echo -e "export SDKMAN_DIR=/home/developer/.sdkman" >> $HOME/.bash_profile
# RUN	echo -e 'source "/home/developer/.sdkman/bin/sdkman-init.sh"' >> $HOME/.bash_profile

# need 'yes' because sdk is a shell function, not an executable, if using sh instead of bash
# must use login shell to pickup profile environment from above
RUN sdk install java && \
	  sdk install groovy && \
    sdk install gradle

# cleanup sdk
# sdk flush candidates removes candidates file and caused candidates not to be found
# could be fixed by touching file, and run sdk update and open a new shell
RUN sdk flush broadcast && \
  	sdk flush archives && \
	  sdk flush temp

# get my groovy project
 RUN echo '20170629' >/dev/null;\
    git clone https://github.com/quagly/neo4j-experiments-as-tests.git ~/groovy/neo4j



USER developer
ENV HOME  /home/developer

WORKDIR $HOME

# use bash login shell
SHELL ["/bin/bash", "--login", "-c"]

# note need to used login shell to pickup sdkman java install so that lein can find java
RUN curl -L -s http://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > \
 $HOME/bin/lein \
 && chmod 0755 $HOME/bin/lein \
 && lein upgrade

# get sample code from pragmatic programmer book and unpack into clojure dir
ADD shcloj3-code.tar.gz $HOME/clojure/
USER root
SHELL ["/bin/sh", "-c"]
RUN chown -R developer:developer $HOME/clojure

USER developer
SHELL ["/bin/bash", "--login", "-c"]

# get my clojure project
RUN echo '20170815' >/dev/null;\
    git clone https://github.com/quagly/learn-clojure.git ~/clojure/learn-clojure

# resolve dependencies for sample code
WORKDIR $HOME/clojure/code
RUN lein deps
WORKDIR $HOME/clojure/learn-clojure
RUN lein deps


WORKDIR /home/developer
# get test script and run it
COPY test.sh /home/developer
CMD /home/developer/test.sh
