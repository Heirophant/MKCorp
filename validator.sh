#!/bin/bash

# List of files to validate (typically downloaded files)
files=("AD_new.ova" "Manager Final.ova" "Firewall Project.ova" "CTO Final.ova" "server.ova")

# Temporary hash file for validation
temp_hash_file="temp_download_hashes.sha256"

# Clear temp hash file
> "$temp_hash_file"

# Generate new hashes
for file in "${files[@]}"; do
    if [[ -f "$file" ]]; then
        sha256sum "$file" >> "$temp_hash_file"
        echo "Validated: $file"
    else
        echo "File not found: $file"
    fi
done

# Compare hashes
echo
echo "Comparing hashes..."
diff -u <(sort hashes.sha256) <(sort "$temp_hash_file")

if [[ $? -eq 0 ]]; then
    echo "All files are valid!"
else
    echo "Mismatch!"
fi

# Clean up
rm "$temp_hash_file"

