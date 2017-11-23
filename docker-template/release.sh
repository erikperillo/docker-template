#!/bin/bash

set -ex

#docker cloud user
user="user"
#name of image
img_name="$(cat NAME)"
#type of version bump. can be major, minor, patch
bump_type=$1
#extension of git commit message
git_msg=$2

[[ -z $bump_type ]] && { echo "error: must specify version bump type"; exit 1; }

#bumping version
docker run --rm -v "$(pwd)":/app treeder/bump $bump_type
version=$(cat VERSION)
echo "version: $version"

#run build
./build.sh

#tag it
git add -A
git commit -m "[$img_name version $version] $git_msg"
git tag -a "$img_name-$version" -m "[$img_name version $version] $git_msg"
docker tag $user/$img_name:latest $user/$img_name:$version

#push it
git push
git push --tags
docker push $user/$img_name:latest
docker push $user/$img_name:$version
