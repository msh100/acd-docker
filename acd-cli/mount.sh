#!/bin/bash

# Ensure target is defined
if [ -z "$MOUNT_TARGET" ]; then
    echo "Need to set MOUNT_TARGET"
    exit 1
fi
# Make directories if required
mkdir -p $MOUNT_TARGET

# Update nodes
acd_cli sync

# Clean up any running mount
fusermount -u $MOUNT_TARGET

# Mount away!
exec acd_cli -d mount -i60 -fg $MOUNT_TARGET
