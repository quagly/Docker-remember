FROM continuumio/anaconda3:latest
LABEL maintainer="Michael West <quagly@gmail.com>"

# update os
RUN apt-get install apt-utils -y && \
    apt-get update && \
    apt-get upgrade -y

# update anaconda
RUN conda update conda && \
    conda update --all -y && \
    conda install jupyter -y

# make notebook directory
RUN mkdir /opt/notebooks


