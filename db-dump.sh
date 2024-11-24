#!/bin/bash

TODAY=$(date "+%Y%m%d")

# akkoma
source /home/akiya/sites/akkoma/db.env
docker exec -u postgres akkoma-db pg_dump -U ${DB_USER} -d ${DB_NAME} --format=custom -f /tmp/akkoma.pgdump
docker cp akkoma-db:/tmp/akkoma.pgdump /home/akiya/sites/dump/akkoma_${TODAY}.pgdump
docker exec akkoma-db rm /tmp/akkoma.pgdump

# gitea
source /home/akiya/sites/gitea/.env
docker exec -u postgres gitea-db-1 pg_dump -U ${GITEA_DB_USER} -d ${GITEA_DB_NAME} --format=custom -f /tmp/gitea.pgdump
docker cp gitea-db-1:/tmp/gitea.pgdump /home/akiya/sites/dump/gitea_${TODAY}.pgdump
docker exec gitea-db-1 rm /tmp/gitea.pgdump

# WordPress
