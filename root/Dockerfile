FROM centos:centos7
MAINTAINER Michael West <Michael.West@cambiahealth.com>

# set up yum http proxy, I haven't been able to get https proxy to work
RUN echo -e 'proxy=http://proxy.regence.com:8080' >> /etc/yum.conf

RUN yum -y update;

# get epel-release for additional packages and set to us http rather than https 
# certificate is untrusted by regence
# you can see this by trying https and then running
# URLGRABBER_DEBUG=1 yum check-update
RUN yum -y install epel-release;\
	# use http for epel-release 
	sed -i "s/mirrorlist=https/mirrorlist=http/" /etc/yum.repos.d/epel.repo 

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
