FROM centos:centos7
MAINTAINER Michael West <quagly@gmail.com>

RUN yum -y update; yum clean all
RUN yum -y install epel-release;\
	  yum clean all

# install development tools.  Just for compiling python we need more than half of them.
RUN yum groups mark install "Development Tools"
RUN yum groups mark convert "Development Tools"
RUN yum -y groupinstall "Development Tools";\
    yum clean all

# install additional packages required to compile python
RUN yum -y install zlib-devel bzip2-devel readline-devel sqlite-devel openssl openssl-devel;\
	  yum clean all

# setup user
RUN useradd -m python_user

WORKDIR /home/python_user
USER python_user

# install all needed versions of python
RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv

ENV HOME  /home/python_user
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
		git clone https://github.com/quagly/cfn-manage.git ~/python/projects

# set default AWS region
RUN mkdir ~/.aws &&\
 	  echo -e "[default]\nregion = us-west-2" > ~/.aws/config
