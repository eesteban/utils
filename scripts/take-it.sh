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

git add -A && git commit --amend --no-edit && git push -f origin HEAD
echo "I Know What You Did Last Summer !!!"
