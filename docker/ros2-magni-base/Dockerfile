FROM ros:humble

# Install dependencies (Nav2, Gazebo, whatever you need)
RUN apt update && apt install -y \
    ros-humble-navigation2 \
    ros-humble-nav2-bringup \
    python3-colcon-common-extensions \
    build-essential git

# Create workspace structure
RUN mkdir -p /ros_ws/src
WORKDIR /ros_ws
