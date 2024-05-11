#!/usr/bin/env bash

# Path to the source file
FILE_PATH="Sources/HomeTools/Migrations/CurrentVersion.swift"
# Default increment type is minor if no arguments are provided
INCREMENT_TYPE="minor"

# Function to display usage
usage() {
    echo "Usage: $0 [--major | --minor]"
    exit 1
}

# Parse command-line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --major) INCREMENT_TYPE="major" ;;
        --minor) INCREMENT_TYPE="minor" ;;
        *) usage ;;
    esac
    shift
done

# Read the current version from the file
if [ ! -f "$FILE_PATH" ]; then
    echo "Error: File does not exist"
    exit 1
fi
current_version=$(grep -o 'let currentVersion = "[^"]*"' "$FILE_PATH" | grep -o '"[^"]*"' | tr -d '"')

# Parse the version components
IFS='.' read -r -a version_parts <<< "$current_version"

# Increment the version
if [ "$INCREMENT_TYPE" == "major" ]; then
    # Increment the major version (index 2 in 0.0.3.2)
    ((version_parts[3]=0))
    ((version_parts[2]++))
else
    # Increment the minor version (index 3 in 0.0.3.2)
    ((version_parts[3]++))
fi

# Construct new version
new_version="${version_parts[0]}.${version_parts[1]}.${version_parts[2]}.${version_parts[3]}"

# Replace the old version in the file
sed -i '' "s/$current_version/$new_version/" "$FILE_PATH"
q
echo "Version updated from $current_version to $new_version in $FILE_PATH"

git add .
git commit -m "New release v${new_version}"

git tag "v${new_version}"
git push --tags