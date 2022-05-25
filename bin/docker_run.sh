#!bin/bash

echo running docker...

# we need to start docker in detached mode (-d), 
# to run the process in the background, 
# and allow our program to continue it's execution, mainly runing tests 
    #--rm \
docker run \
    -d \
    -p 5432:5432 \
    -e POSTGRES_USER=test \
    -e POSTGRES_PASSWORD=test \
    -e POSTGRES_DB=test_db \
    postgres:14-alpine \
