#!/bin/bash
#
# push all local branches to a remote
#
remote=$1
if [ -z "$remote" ]; then
  echo "Please provide a remote name"
  exit 1
fi
# Get the list of all local branches
branches=$(git branch --format='%(refname:short)')

# Iterate over each branch
for branch in $branches; do

upstream=$(git rev-parse --abbrev-ref "$branch@{upstream}" 2>/dev/null)

if git ls-remote --exit-code --heads "$remote_name" "$upstream" >/dev/null 2>&1; then
  echo "upstream present - pushing $branch to $remote"
  git push
else
    echo "no upstream - setting upstream for $branch in $remote"    
    echo "git push -u $remote \"$branch\""
    git push -u $remote "$branch"
fi
done