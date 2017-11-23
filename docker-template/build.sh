#!/bin/bash

set -ex

user="user"
img_name="$(cat NAME)"
tag="latest"

docker build -t $user/$img_name:$tag .
