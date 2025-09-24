#!/bin/bash

cp docker/Dockerfile.base docker/Dockerfile
docker build -f docker/Dockerfile \
    --build-arg="ROS_DISTRO=humble" \
    --target base -t solarswarm:base .