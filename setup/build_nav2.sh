#!/bin/bash

cp docker/Dockerfile.nav2 docker/Dockerfile
docker build -f docker/Dockerfile \
    --build-arg="ROS_DISTRO=humble" \
    -t nav2:base .