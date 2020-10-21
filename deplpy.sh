#!/bin/sh

# If a command fails then the deploy stops
set -e

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

# Build the project.
hugo -t educenter-hugo # if using a theme, replace with `hugo -t <YOURTHEME>`

# Go To Public folder
cd ../mariepense.github.io

# Add changes to git.
git add .

# Commit changes.
msg="rebuilding site mpcny.org $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master

cd -
hugo -t educenter-hugo --config config_mariepensecenter
cd ../mariepensecenter.github.io
git add .

# Commit changes.
msg="rebuilding site mariepensecenter.com $(date)"
if [ -n "$*" ]; then
	  msg="$*"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master
