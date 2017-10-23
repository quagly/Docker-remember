# set up postgres database
# this container is not included in the parent master container
# it is inteded to be linked to other containers if needed
# or just used for testing out postgres
# using the alpine version of postgres to keep the image small
# I don't expect to be logging into it much
# just connecting by port
