FROM home
LABEL maintainer="Michael West <Michael.West@cambiahealth.com>"
# test by cd to python dir and run tox

USER developer
ENV HOME  /home/developer
WORKDIR $HOME

# install all needed versions of python
RUN echo '20170930' > /dev/null;\
	 git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv

ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
# required compilation option for Gildas-Python binding
ENV PYTHON_CONFIGURE_OPTS="--enable-shared"

RUN pyenv install 2.7.14
RUN pyenv install 3.3.7
RUN pyenv install 3.4.7
RUN pyenv install 3.5.4
RUN pyenv install 3.6.3
RUN pyenv rehash

RUN pyenv global 3.6.3

# install application demonstrating using tox to test multiple python versions
# and coverage report and api documentation
RUN pip --no-cache-dir install tox

# get my python project
RUN echo '20170625' >/dev/null;\
		git clone https://github.com/quagly/cfn-manage.git ~/python/cfn-manage

# set default AWS region
RUN mkdir ~/.aws &&\
 	  echo -e "[default]\nregion = us-west-2" > ~/.aws/config
