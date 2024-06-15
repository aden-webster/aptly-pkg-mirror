#!/bin/bash

# Check if at least one mirror is provided
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <mirror1> [<mirror2> ...]"
    exit 1
fi

# Update each mirror
for mirror in "$@"; do
    echo "Updating mirror: $mirror"
    aptly mirror update "$mirror"
    if [ $? -ne 0 ]; then
        echo "Failed to update mirror: $mirror"
        exit 1
    fi
done

### Publishing to come.