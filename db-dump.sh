#!/bin/bash

TODAY=$(date "+%Y%m%d")

# akkoma
source /home/akiya/sites/akkoma/db.env
docker exec -u postgres akkoma-db pg_dump -U ${DB_USER} -d ${DB_NAME} --format=custom -f /tmp/akkoma.pgdump
docker cp akkoma-db:/tmp/akkoma.pgdump /home/akiya/sites/dump/akkoma_${TODAY}.pgdump
docker exec akkoma-db rm /tmp/akkoma.pgdump

# forgejo
source /home/akiya/sites/forgejo/.env
docker exec -u postgres forgejo-db pg_dump -U ${FORGEJO_DB_USER} -d ${FORGEJO_DB_NAME} --format=custom -f /tmp/forgejo.pgdump
docker cp forgejo-db:/tmp/forgejo.pgdump /home/akiya/sites/dump/forgejo_${TODAY}.pgdump
docker exec forgejo-db rm /tmp/forgejo.pgdump

# WordPress
source /home/akiya/sites/wordpress/.env
docker exec mariadb sh -c "mariadb-dump --single-transaction -u ${WP_DB_USER} -p${WP_DB_PASSWORD} ${WP_DB_NAME}" > /home/akiya/sites/dump/wp_dump_${TODAY}.sql
