#!/bin/bash
set -e

if [ -f "/bridge_ws/bridge.env" ]; then
    echo "Loading configuration from /bridge_ws/bridge.env"
    set -a
    source /bridge_ws/bridge.env
    set +a
else
    echo "Warning: /bridge_ws/bridge.env not found!"
fi

echo "ROS_MASTER_URI=$ROS_MASTER_URI"
echo "ROS_IP=$ROS_IP"

source /opt/ros/noetic/setup.bash
rosparam load /bridge_ws/bridge.yaml
source /opt/ros/foxy/setup.bash

ros2 run ros1_bridge dynamic_bridge --print-pairs
ros2 run ros1_bridge parameter_bridge > ${BRIDGE_WS}/start_bridge.sh
