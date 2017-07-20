FROM home 
LABEL maintainer="Michael West <Michael.West@cambiahealth.com>"
# test by cd to python dir and run tox

USER developer
ENV HOME  /home/developer
WORKDIR $HOME

# install all needed versions of python
RUN echo '201707119' > /dev/null;\
	 git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv

ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
# required compilation option for Gildas-Python binding
ENV PYTHON_CONFIGURE_OPTS="--enable-shared"

RUN pyenv install 2.7.13
RUN pyenv install 3.3.6 
RUN pyenv install 3.4.6 
RUN pyenv install 3.5.3 
RUN pyenv install 3.6.2
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
