#!/bin/bash

# Initialization of variables
USER=""
DOMAIN="github.com" # Default value
REPOS_FILE="repos.txt" # The file from which to load the repository names
OUTPUT_DIR="" # Output directory for the repositories

# Command line arguments processing
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --user) USER="$2"; shift ;;
        --domain) DOMAIN="$2"; shift ;;
        -o|--output) OUTPUT_DIR="$2"; shift ;;
        *) echo "Unknown option: $1"; exit 1 ;;
    esac
    shift
done

if [[ -z "$USER" ]]; then
    echo "You must specify a user with --user"
    exit 1
fi

if [ ! -f "$REPOS_FILE" ]; then
    echo "Repository list file $REPOS_FILE does not exist."
    exit 1
fi

# Use the directory of the repos file as the default output directory if none specified
if [[ -z "$OUTPUT_DIR" ]]; then
    OUTPUT_DIR=$(dirname "$REPOS_FILE")
fi

# Ensure the output directory exists
mkdir -p "$OUTPUT_DIR"

# Read repository names from the file
REPOS=()
while IFS= read -r line; do
    REPOS+=("$line")
done < "$REPOS_FILE"

for repo in "${REPOS[@]}"; do
  dir="${OUTPUT_DIR}/${repo}"
  repo_url="https://$DOMAIN/$USER/$repo.git"
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
