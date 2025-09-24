###########################################
# Overlay Image for TurtleBot3 Simulation #
###########################################
FROM ros2:base AS overlay

# Update & Grundpakete
RUN apt-get update && apt-get install -y \
    ros-$ROS_DISTRO-rviz2 \
    ros-$ROS_DISTRO-joint-state-publisher \
    ros-$ROS_DISTRO-joint-state-publisher-gui \
    python3-colcon-common-extensions

# Create an overlay Colcon workspace
ENV ws=/magni_ros2_ws
RUN mkdir -p /${ws}/src
WORKDIR ${ws}

# Add the Magni ROS2 package
RUN source /opt/ros/${ROS_DISTRO}/setup.bash && \
    cd /magni_ros2_ws/src && \
    ros2 pkg create --build-type ament_cmake magni_ros2

RUN source /opt/ros/${ROS_DISTRO}/setup.bash \
 && rosdep install --from-paths src --ignore-src --rosdistro ${ROS_DISTRO} -y \
 && colcon build --symlink-install

# Set up the entrypoint
COPY ./docker/entrypoint.sh /
RUN chmod +x /entrypoint.sh

RUN rm -rf /var/lib/apt/lists/*
ENTRYPOINT [ "/entrypoint.sh" ]