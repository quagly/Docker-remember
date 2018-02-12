#!/bin/bash

# start notebook command for use inside container
# requires --allow-root because continuum built it that way
jupyter notebook --notebook-dir=/opt/notebooks --ip='*' --port=8888 --no-browser --allow-root
