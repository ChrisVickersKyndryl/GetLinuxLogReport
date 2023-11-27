#!/bin/bash

# Get daily value of logs created (uncompressed)
if grep -q -E '^\s*?weekly$' /etc/logrotate.conf; then
    FILESIZE=$(stat -c%s "{{ item }}")
    echo "$((FILESIZE/7))"
    exit
fi

# Get the daily amount of logs if set to monthly
if grep -q -E '^\s*?monthly$' /etc/logrotate.conf; then
    FILESIZE=$(stat -c%s "{{ item }}")
    echo "$((FILESIZE/30))"
    exit
fi

# Get the daily amount of logs if set to daily rotation
if grep -q -E '^\s*?daily$' /etc/logrotate.conf; then
    FILESIZE=$(stat -c%s "{{ item }}")
    echo "$((FILESIZE))"
    exit
fi

# Fail over value of zero
echo "0"
