#!/bin/bash

set -e
call_cat="/bin/adb shell cat"
call_ls="/bin/adb shell ls"
name_base="/dev/block/bootdevice"
if [[ -n $1 ]]; then
  block_name=$(${call_ls} -la ${name_base}/by-name/$1 2>/dev/null | awk -F " -> /dev/block/" '{print $2}') # 将 分区可读名称 转换为 块设备名称
  if [[ -n ${block_name} ]]; then
    ${call_cat} /proc/partitions | grep ${block_name} | awk -F " " '{print $3 * 1024}' # 输出单位为 Byte
  else
    echo "Error: partition $1 not found"
  fi
else
  echo "Usage: $0 [partition name]"
fi
