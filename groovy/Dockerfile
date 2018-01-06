FROM python
LABEL maintainer="Michael West <quagly@gmail.com>"
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
