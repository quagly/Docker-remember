#!/usr/bin/env python

#proxy.py ###
#
# Purpose:
#   process Dockerfile as mustache template
#   and add http proxy and change epel repository to use http
#   so that it will run on desktop behind proxy
#
# Created by: Michael West
# Date 2017-Jul-03


from __future__ import absolute_import, division, print_function, unicode_literals
import pystache

data = {
    'PROXY': 'RUN echo -e "proxy=http://proxy.regence.com:8080" >> /etc/yum.conf',
    'SED': 'RUN sed -i "s/mirrorlist=https/mirrorlist=http/" /etc/yum.repos.d/epel.repo'
}

# note that this is not intended to be a configuration interface so look for
# DELIMITERS to be exposed as a Renderer _init_ parameter in future
pystache.defaults.DELIMITERS = ('##', '##')

renderer = pystache.Renderer(
    file_extension=False,
    missing_tags='strict'
)

with open('Dockerfile.proxy', 'w') as f:
    f.write(renderer.render_name('Dockerfile', data))
