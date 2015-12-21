#!/bin/bash

# Ensure source is defined
if [ -z "$MOUNT_SOURCE" ]; then
    echo "Need to set MOUNT_SOURCE"
    exit 1
fi

# Ensure target is defined
if [ -z "$MOUNT_TARGET" ]; then
    echo "Need to set MOUNT_TARGET"
    exit 1
fi

# Wait for any required mounts
if [ "$WAIT_FOR_MNT" ]; then
    while true ; do
        if mount | grep -q "$WAIT_FOR_MNT" ; then
            break
        fi

        echo "Waiting for mount $WAIT_FOR_MNT";
        sleep 5
    done
fi

# Make directories if required
mkdir -p $MOUNT_SOURCE
mkdir -p $MOUNT_TARGET

# Cleanup any existing mount
fusermount -u $MOUNT_TARGET

# Mount away!
if [ "$ENCFS_PASS" ]; then
    exec encfs -o allow_other -f --extpass='/bin/echo $ENCFS_PASS' $MOUNT_SOURCE $MOUNT_TARGET
else
    exec encfs -o allow_other -f $MOUNT_SOURCE $MOUNT_TARGET
fi
