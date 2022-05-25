#!bin/bash

echo starting postgres container...

# start container in attached mode and parse the log to determine if the database started correctly
docker run \
    --rm \
    -p 5432:5432 \
    -e POSTGRES_USER=test \
    -e POSTGRES_PASSWORD=test \
    -e POSTGRES_DB=test_db \
    postgres:14 \
