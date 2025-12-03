# Basis-Image von osrf mit ROS2 Foxy und ROS1 Bridge
FROM osrf/ros:foxy-ros1-bridge

ARG BRIDGE_WS="/bridge_ws"

# Arbeitsverzeichnisse erstellen
RUN mkdir -p ${BRIDGE_WS}/src
WORKDIR ${BRIDGE_WS}

# Setup Configs und Skripte
COPY docker/ros1-ros2-bridge-image/bridge.yaml ${BRIDGE_WS}/bridge.yaml
COPY docker/ros1-ros2-bridge-image/CMakeLists.txt ${BRIDGE_WS}/src/CMakeLists.txt
COPY docker/ros1-ros2-bridge-image/package.xml ${BRIDGE_WS}/src/package.xml
COPY docker/ros1-ros2-bridge-image/start_bridge.sh ${BRIDGE_WS}/start_bridge.sh

# Creates catkin workspace and compiles
RUN cd ${BRIDGE_WS} && /bin/bash -c "source /opt/ros/noetic/setup.bash;catkin_make"

# Mach das Skript ausführbar
RUN chmod +x ${BRIDGE_WS}/start_bridge.sh

CMD ["/bridge_ws/start_bridge.sh"]