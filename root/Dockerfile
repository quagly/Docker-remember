FROM centos:centos7
MAINTAINER Michael West <Michael.West@cambiahealth.com>

# set up yum http proxy if needed for example
#RUN echo -e 'proxy=http://proxy.regence.com:8080' >> /etc/yum.conf
##PROXY##

RUN yum -y update;

RUN yum -y install epel-release

# replace with sed command to change https to http for epel repo if needed
#RUN sed -i "s/mirrorlist=https/mirrorlist=http/" /etc/yum.repos.d/epel.repo
##SED##

# install development tools.  Just for compiling python we need more than half of them.
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
