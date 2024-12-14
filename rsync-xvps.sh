#!/bin/bash

sync_sites () {
  rsync -ae \
    "ssh -i /volume1/akiya/ssh/${KEY} -o UserKnownHostsFile=/volume1/akiya/ssh/known_hosts" \
    akiya@${HOST}:/home/akiya/sites/${1} \
    /volume1/akiya_bk/sites
}

sync_sites "dump"
sync_sites "akkoma/uploads"
sync_sites "akkoma/static"
sync_sites "wordpress/html/wp-content/uploads"
