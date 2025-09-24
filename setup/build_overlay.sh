#!/bin/bash

cp docker/Dockerfile.overlay docker/Dockerfile
docker build \
    -f docker/Dockerfile --target overlay \
    -t solarswarm:magni-ros2  .