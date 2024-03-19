#!/bin/bash

# Initialization of variables
USER=""
DOMAIN="github.com" # Default value
REPOS_FILE="repos.txt" # The file from which to load the repository names

# Command line arguments processing
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --user) USER="$2"; shift ;;
        --domain) DOMAIN="$2"; shift ;;
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

# Read repository names from the file
REPOS=()
while IFS= read -r line; do
    REPOS+=("$line")
done < "$REPOS_FILE"

for repo in "${REPOS[@]}"; do
  dir=$repo
  repo_url="https://$DOMAIN/$USER/$repo.git"
  if [ -d "$dir" ]; then
    echo "Updating $dir..."
    cd "$dir"
    git pull
    cd ..
  else
    echo "Cloning $dir..."
    git clone "$repo_url"
  fi
done
