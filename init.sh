#!/bin/bash

# Initialization of variables
USER=""
REPO_NAME=".bk"
FILE_NAME="repos.txt"
OUTPUT_DIR="" # Output directory for the repositories

# Command line arguments processing
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --user) USER="$2"; shift ;;
        -o|--output) OUTPUT_DIR="$2"; shift ;;
        *) echo "Unknown option: $1"; exit 1 ;;
    esac
    shift
done

if [[ -z "$USER" ]]; then
    echo "You must specify a user with --user"
    exit 1
fi

# Construct the URL to download the repos.txt file
REPOS_URL="https://raw.githubusercontent.com/${USER}/${REPO_NAME}/main/${FILE_NAME}"

# Use curl to download the list of repositories
echo "Downloading repository list from $REPOS_URL"
REPOS=$(curl -sS $REPOS_URL)
if [ $? -ne 0 ]; then
    echo "Failed to download the repository list."
    exit 1
fi

# Check if an output directory was specified, else use current directory
if [[ -z "$OUTPUT_DIR" ]]; then
    OUTPUT_DIR=$(pwd)
fi

# Ensure the output directory exists
mkdir -p "$OUTPUT_DIR"

# Process each repository name
echo "$REPOS" | while read repo; do
    if [[ -z "$repo" ]]; then continue; fi # Skip empty lines
    dir="${OUTPUT_DIR}/${repo}"
    repo_url="https://github.com/${USER}/${repo}.git"
    echo "Processing $repo_url in $dir"
    if [ -d "$dir" ]; then
        echo "Updating $dir..."
        cd "$dir"
        git pull
        cd -  # Returns to the previous directory
    else
        echo "Cloning into $dir..."
        git clone "$repo_url" "$dir"
    fi
done
