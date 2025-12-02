#!/bin/bash
# Parameter prüfen
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <ROS_MASTER_URI_IP> <ROS_IP>"
    exit 1
fi

master_ip=$1
local_ip=$2
tag=ros1-ros2-bridge

#docker stop $tag
#docker rm $tag
docker run -it \
    --name=$tag \
    --net=host \
    --ipc=host \
    --pid=host \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --env="ROS_MASTER_URI=http://$master_ip:11311" \
    --env="ROS_IP=$local_ip" \
    -e TZ=Europe/Berlin \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --rm \
    solarswarm:$tag \
    bash