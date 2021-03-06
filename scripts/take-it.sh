#!/bin/sh
INSIDE_GIT_REPO="$(git rev-parse --is-inside-work-tree 2>/dev/null)"

if [ -z "$INSIDE_GIT_REPO" ]; then
  echo "ARE YOU LOST?"
  echo "This is no a Git Repo"
  exit 1
fi

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

if [ "${CURRENT_BRANCH}" = "master" ]; then
  echo "YOU CAN NOT PASS!"
  echo "You are in master"
  exit 2
fi

CHANGES=$(git diff-index --quiet HEAD -- || echo "CHANGED")

if [ -z "$CHANGES" ]; then
  echo "ARE YOU SURE?"
  echo "I can't see the difference"
  exit 3
fi

LATEST_COMMIT_WITH_MASTER=$(git merge-base HEAD master)
LATEST_COMMIT=$(git rev-parse HEAD)

git add -A

if [ "$LATEST_COMMIT" != "$LATEST_COMMIT_WITH_MASTER"  ]; then
  git commit --amend --no-edit
else
  echo "There isn't a commit already on this branch"
  git commit
fi

git push -f origin HEAD
echo "I Know What You Did Last Summer !!!"
