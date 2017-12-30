FROM home
LABEL maintainer="Michael West <Michael.West@cambiahealth.com>"
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
RUN echo '20171227' >/dev/null && \
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
