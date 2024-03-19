#!/bin/bash

# Initialization of variables
USER=""
DOMAIN="github.com" # Default value
REPOS=()

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

# List of your repository names
REPOS=()

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
