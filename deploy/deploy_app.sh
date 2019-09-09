#!/bin/bash

CONFIG_DIR="/home/${USER}/.polyswarm/config/polyswarm-phantom"
PHANTOM_TAR='polyswarm-phantom.tar.gz'

# first time execution
if [ -d "${CONFIG_DIR}" ]; then
    source "${CONFIG_DIR}/config"
else
    printf "Usage: create local config file first\n"
    printf "mkdir -p %s\n" "${CONFIG_DIR}"
    printf "cp ../config_template/config %s/\n" "${CONFIG_DIR}"
    printf "vim %s/config\n" "${CONFIG_DIR}"
    printf "./deploy_config.sh\n"
    exit 1
fi

printf "[*] Deploying Phantom APP to node: %s\n" "${REMOTE_IP}"

printf "    [+] tar app...\n"
tar --exclude="${PHANTOM_TAR}" --exclude='.git' -zcvf "${PHANTOM_TAR}" ../../polyswarm-phantom &>/dev/null

printf "    [+] cleaning up old files...\n"
ssh -p "${REMOTE_PORT}" "${REMOTE_USER}@${REMOTE_IP}" "rm -rf polyswarm-phantom; rm ${PHANTOM_TAR}" &>/dev/null

printf "    [+] uploading app...\n"
scp -P "${REMOTE_PORT}" "${PHANTOM_TAR}" ${REMOTE_USER}@${REMOTE_IP}:~/

printf "    [+] untar app...\n"
ssh -p "${REMOTE_PORT}" ${REMOTE_USER}@${REMOTE_IP} tar -zxvf "${PHANTOM_TAR}" &>/dev/null

printf "    [+] compile and install app...\n"
ssh -t -p "${REMOTE_PORT}" ${REMOTE_USER}@${REMOTE_IP} "cd /home/${REMOTE_USER}/polyswarm-phantom/app; sudo bash compile.sh"

# clean up this dir
rm "${PHANTOM_TAR}"

printf "[*] Enjoy. :)\n"

#eof
