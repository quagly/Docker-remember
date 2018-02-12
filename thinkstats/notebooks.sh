#!/bin/bash

# start docker and make notebooks available via host browser
# trying to keep this simple by using the Continuum supplied images for now
# that means running as root
docker run -i -t -p 8888:8888 thinkstats /bin/bash -c "jupyter notebook --notebook-dir=/opt/notebooks --ip='*' --port=8888 --no-browser --allow-root"
