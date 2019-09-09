#!/bin/bash

########################################################
## Test APP
##
## Usage:
##  * with arg: run one json file
##      i.e.: ./run_test.sh json/test_connectivity.json
##  * without arg: run all json files in json/ folder
##
## Log:
##  * Logs everything at ${LOG_RESULTS}
##  * Log failed test at ${LOG_FAILED}
##
########################################################

CONFIG_DIR="/home/${USER}/.polyswarm/config/polyswarm-phantom"

LOG_RESULTS="phantom_app_test_results.log"
LOG_FAILED="phantom_app_test_failed.log"

JSON="${1}"

run_json() {
    _JSON="${1}"
    ret=0

    printf "[+] Running test: %s\n" "${_JSON}"

    # set API KEY from config file
    sed -i "s/REPLACE_API_KEY/${POLYSWARM_API_KEY}/g" "${_JSON}"

    output=$(sudo phenv python2.7 ../app/polyswarm_connector.py -u "${PHANTOM_USER}" -p "${PHANTOM_PASS}" "${_JSON}")
    printf "%s\n" "${output}"

    if echo ${output} | grep -q '"status": "failed"';then
        printf "[!!][%s] Test Failed!\n" "${_JSON}"
	    printf "Failed test: %s output: %s" "${_JSON}" "${output}" >> "${LOG_FAILED}"
	    success=1
    else
        printf "[+][%s] Test Passed.\n" "${_JSON}"
	    success=0
    fi
    printf "\n\n"

    return "${ret}"
}

run_all() {
    failed=false

    find json/ -type f | while read -r; do
        run_json "${REPLY}"
	    ! [ "${?}" ] && failed=true
    done

    if ${failed}; then
	    printf "[-] Some test are failing. Check log: %s\n" "${LOG_FAILED}"
    else
	    printf "[+] ALL Test Passed Successfully!\n"
    fi

    return
}

main() {
    # first time execution
    if [ -d "${CONFIG_DIR}" ]; then
        source "${CONFIG_DIR}/config"
    else
        printf "Usage: create config file\n"
        printf "mkdir -p %s\n" "${CONFIG_DIR}"
        printf "cp ../config_template/config %s/\n" "${CONFIG_DIR}"
        printf "vim %s/config\n" "${CONFIG_DIR}"
        exit 1
    fi

    printf "[*] Log file: %s\n" "${LOG}"

    if [ -n "${JSON}" ]; then
        run_json "${JSON}" 2>&1 | tee -a "${LOG_RESULTS}"
    else
        run_all 2>&1 |tee -a "${LOG_RESULTS}"
    fi
}

main

#eof
