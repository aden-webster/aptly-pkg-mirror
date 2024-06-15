#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <distribution> <repository> <URL>"
    exit 1
fi

DISTRIBUTION=$1
REPOSITORY=$2
BASE_URL=$3 

# Define the mirror name (jammy-main)
MIRROR_NAME="${DISTRIBUTION}-${REPOSITORY}"

# Create the mirror
echo "Creating mirror: $MIRROR_NAME"
aptly mirror create -architectures=amd64 "$MIRROR_NAME" "$BASE_URL" "$DISTRIBUTION" "$REPOSITORY"
if [ $? -ne 0 ]; then
    echo "Failed to create mirror: $MIRROR_NAME"
    exit 1
fi

echo "Mirror $MIRROR_NAME created successfully."
