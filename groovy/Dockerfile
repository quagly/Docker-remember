FROM python 
MAINTAINER Michael West <Michael.West@cambiahealth.com>

USER developer
ENV HOME  /home/developer
WORKDIR $HOME

# install gvm
RUN curl -s "https://get.sdkman.io" | bash 
RUN	source "/home/developer/.sdkman/bin/sdkman-init.sh"

# need 'yes' because sdk is a shell function, not an executable
RUN yes | /bin/bash -l -c 'sdk install java'
RUN yes | /bin/bash -l -c 'sdk install groovy'
RUN yes | /bin/bash -l -c 'sdk install gradle'

# get my groovy project 
RUN echo '20170629' >/dev/null;\
    git clone https://github.com/quagly/neo4j-experiments-as-tests.git ~/groovy/neo4j
