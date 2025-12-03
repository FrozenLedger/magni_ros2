###########################################
# Overlay Image for TurtleBot3 Simulation #
###########################################
FROM ros2:base AS overlay

# Update & Grundpakete
RUN apt-get update && apt-get install -y \
    python3-colcon-common-extensions

# Create an overlay Colcon workspace
ENV ws=/magni_ros2_ws
#RUN mkdir -p /${ws}/src

# Add the Magni ROS2 package
RUN mkdir -p ${ws}/src
COPY ../../src ${ws}/src
WORKDIR ${ws}

# Install dependencies & build the workspace
RUN source /opt/ros/${ROS_DISTRO}/setup.bash \
 && rosdep install --from-paths src --ignore-src --rosdistro ${ROS_DISTRO} -y \
 && colcon build --symlink-install

# Set up the entrypoint
COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh

RUN rm -rf /var/lib/apt/lists/*
ENTRYPOINT [ "/entrypoint.sh" ]