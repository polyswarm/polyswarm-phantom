#!/bin/bash

###############################
## Deploy configuration file
## to remote node
##

CONFIG_DIR="/home/${USER}/.polyswarm/config/polyswarm-phantom"

# first time execution
if [ -d "${CONFIG_DIR}" ]; then
    source "${CONFIG_DIR}/config"
else
    printf "Usage: create local config file first\n"
    printf "mkdir -p %s\n" "${CONFIG_DIR}"
    printf "cp ../config_template/config %s/\n" "${CONFIG_DIR}"
    printf "vim %s/config\n" "${CONFIG_DIR}"
    exit 1
fi

# create config dir
ssh -p "${REMOTE_PORT}" "${REMOTE_USER}@${REMOTE_IP}" "mkdir -p /home/${REMOTE_USER}/.polyswarm/config/polyswarm-phantom"

# upload config file
scp -P "${REMOTE_PORT}" "${CONFIG_DIR}/config" "${REMOTE_USER}@${REMOTE_IP}:/home/${REMOTE_USER}/.polyswarm/config/polyswarm-phantom/"

printf "[+] Phantom Configuration uploaded.\n"
