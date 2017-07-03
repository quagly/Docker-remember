#!/usr/bin/env python

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
    missing_tags='strict' #,
    # escape='lambda u: u'
)

print (renderer.render_name('Dockerfile', data))
