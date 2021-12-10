#!/bin/sh
set -x
# 删除端口转发
pgrep -lfa kubectl || exit
kill $(pgrep -lfa kubectl | awk '{print $1}')