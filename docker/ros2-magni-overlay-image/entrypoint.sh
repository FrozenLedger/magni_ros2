#!/bin/bash
# Basic entrypoint for ROS / Colcon Docker containers
 
# Source ROS 2
source /opt/ros/${ROS_DISTRO}/setup.bash
 
# Source the base workspace, if built
if [ -f /ros2_ws/install/setup.bash ]
then
  source /ros2_ws/install/setup.bash
  # export TURTLEBOT3_MODEL=waffle_pi
  # export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:$(ros2 pkg prefix turtlebot3_gazebo)/share/turtlebot3_gazebo/models
fi
 
# Source the overlay workspace, if built
if [ -f /magni_ros2_ws/install/setup.bash ]
then
  source /magni_ros2_ws/install/setup.bash
  echo "/magni_ros2_ws/install/setup.bash sourced"
  # export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:$(ros2 pkg prefix tb3_worlds)/share/tb3_worlds/models
else
  echo "Failed sourcing /magni_ros2_ws"
fi

# Setup
ros2 launch magni_description display.launch.py &
python3 /scripts/odom.py &
ros2 launch magni_description slam_nav2.launch.py &

# Execute the command passed into this entrypoint
exec "$@"