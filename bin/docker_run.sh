#!bin/bash

echo 'stopping container named '$1' if exist'
docker stop $1

echo 'starting postgres container named: '$1' ...'
# start container in attached mode and parse the log to determine if the database started correctly
docker run \
    --name $1 \
    --rm \
    -p 5432:5432 \
    -e POSTGRES_USER=test \
    -e POSTGRES_PASSWORD=test \
    -e POSTGRES_DB=test_db \
    postgres:14 \
