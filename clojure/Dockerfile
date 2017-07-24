FROM groovyenv 
LABEL maintainer="Michael West <Michael.West@cambiahealth.com>"

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
# resolve dependencies for sample code
# this currently fails with:
#  java.io.FileNotFoundException: /home/developer/clojure/code/target/stale/leiningen.core.classpath.extract-native-dependencies (No such file or directory)   
WORKDIR $HOME/clojure/code
RUN lein deps
