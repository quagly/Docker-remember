FROM centos:centos7
LABEL maintainer="Michael West <Michael.West@cambiahealth.com>"

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
