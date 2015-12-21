#!/bin/bash

# Ensure unite is defined
if [ -z "$MOUNT_UNITE" ]; then
    echo "Need to set MOUNT_UNITE"
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
mkdir -p $MOUNT_TARGET

# Cleanup any existing mount
fusermount -u $MOUNT_TARGET

# Mount away!
exec unionfs-fuse -d -o cow,allow_other $MOUNT_UNITE $MOUNT_TARGET
