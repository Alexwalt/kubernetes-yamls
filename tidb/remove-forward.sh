#!/bin/sh
set -x
# 删除端口转发
pgrep -lfa kubectl
kill $(pgrep -lfa kubectl | awk '{print $1}')