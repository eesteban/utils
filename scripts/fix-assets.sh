#!/bin/bash
function contains() {
  ARRAY=$1
  STRING=$2

  if [ "${ARRAY[@]/${STRING}/X}" = "${ARRAY[@]}" ]; then
    echo 1
  else
    echo 0
  fi

}

function truncate() {
  NEW_ARRAY=()
  ARRAY=$1
  ACCEPTED_ELEMENTS=$2

  for var in $ARRAY
  do
    if [ "$(contains "${ACCEPTED_ELEMENTS[@]}" "${var}")" = "0" ]; then
      NEW_ARRAY+=("${var}")
    else
      echo "${NEW_ARRAY[@]}"
      exit 0
    fi
  done

  exit 0
}

if [ $# -lt 1 ]; then
	echo usage: fix-assets.sh [relative_path]
	exit 1
fi

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

RELATIVE_PATH=$1
ASSETS="$(ls -d ${RELATIVE_PATH}/* -- | sed -e "s/${RELATIVE_PATH}\///g")"
COMMITS="$(git rev-list --oneline master..${CURRENT_BRANCH} | cut -d' ' -f2-)"

readarray -t COMMIT_MESSAGES <<<"$COMMITS"

UPDATED_ASSETS="$(git rev-list --oneline master..${CURRENT_BRANCH} | cut -d' ' -f2 | sed -E 's/([a-z]+\()([a-z]+)(\):)/\2/g')"
TRUNCATED="$(truncate "${UPDATED_ASSETS[@]}" "${ASSETS[@]}")"
EFFECTIVE_ASSET_UPDATES=( $TRUNCATED )

git reset HEAD~"${#EFFECTIVE_ASSET_UPDATES[@]}"

INDEXES=( ${TRUNCATED[@]} )
for ((i=${#INDEXES[@]} - 1; i >= 0; i--)) ; do
    git add ${RELATIVE_PATH}/${EFFECTIVE_ASSET_UPDATES[$i]}
    git commit -m"${COMMIT_MESSAGES[$i]}"
done
