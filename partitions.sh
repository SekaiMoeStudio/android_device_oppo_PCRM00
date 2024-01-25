#!/bin/bash

set -e

if uname -a | grep Android >/dev/null; then
    if [[ $EUID -ne 0 ]]; then
        echo "Please use root user to execute this script"
        exit 1
    fi
    export call_cat="/bin/cat"
    export call_ls="/bin/ls"
else
    export call_cat="/bin/adb shell su -c cat"
    export call_ls="/bin/adb shell su -c ls"
fi

export name_base="/dev/block/bootdevice"

if [[ -n $1 ]]; then
    block_name=$(${call_ls} -la ${name_base}/by-name/$1 2>/dev/null | awk -F " -> /dev/block/" '{print $2}')
    if [[ -n ${block_name} ]]; then
        ${call_cat} /proc/partitions | grep ${block_name} | awk -F " " '{print $3 * 1024}'
    else
        echo "Error: partition $1 not found"
    fi
else
    echo "Usage: $0 [partition name]"
    exit 127
fi
