#!/bin/bash

# Get the SSH directory path
ssh_dir="$HOME/.ssh"

# Create an array to store public keys
public_keys=()

# Process each file in the SSH directory
for file in "$ssh_dir"/*.pub; do
    if [ -f "$file" ]; then
        # Read the public key file
        filename=$(basename "$file")
        content=$(cat "$file")

        # Create a JSON object for the public key
        public_key="{\"filename\":\"$filename\", \"content\":\"$content\"}"

        # Append the public key object to the array
        public_keys+=("$public_key")
    fi
done

# Convert the public_keys array to a JSON array
json_data=$(printf "[%s]\n" "${public_keys[@]}")

# Print the JSON array to stdout
echo "$json_data"
