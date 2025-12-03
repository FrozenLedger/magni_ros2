# Basis-Image von osrf mit ROS2 Foxy und ROS1 Bridge
FROM osrf/ros:foxy-ros1-bridge

ARG ROS1_WS="/ros1_ws"
ARG ROS2_WS="/ros2_ws"
ARG BRIDGE_WS="/bridge_ws"

# Arbeitsverzeichnisse erstellen
RUN mkdir -p ${ROS1_WS}/src
RUN mkdir -p ${ROS2_WS}/src
RUN mkdir -p ${BRIDGE_WS}/src
WORKDIR ${BRIDGE_WS}

COPY ./bridge.yaml ${BRIDGE_WS}/bridge.yaml
COPY ./CMakeLists.txt ${BRIDGE_WS}/src/CMakeLists.txt
COPY ./package.xml ${BRIDGE_WS}/src/package.xml

COPY ros2_tcp_twist_sender.py /ros2_tcp_twist_sender.py

# Creates catkin workspace and compiles
#RUN /bin/bash -c "cd /bridge_ws;source /opt/ros/noetic/setup.bash;catkin_make"
#RUN cd /bridge_ws; source /opt/ros/noetic/setup.bash; catkin_make
RUN cd ${ROS1_WS} && /bin/bash -c "source /opt/ros/noetic/setup.bash;catkin_make"
RUN cd ${ROS2_WS} && /bin/bash -c "source /opt/ros/foxy/setup.bash;colcon build --symlink-install"
RUN cd ${BRIDGE_WS} && /bin/bash -c "source /opt/ros/noetic/setup.bash;catkin_make"

# Setup Skript erstellen, um die Bridge zu starten
RUN echo "#!/bin/bash\n\
export ROS_MASTER_URI=http://192.168.0.103:11311\n\
export ROS_IP=192.168.0.106\n\
alias sr1='source /opt/ros/noetic/setup.bash'\n\
alias sr2='source /opt/ros/foxy/setup.bash'\n\
alias sr3='source /bridge_ws/devel/setup.bash'\n\
$sr1\n\
rosparam load /bridge_ws/bridge.yaml\n\
$sr2\n\
ros2 run ros1_bridge dynamic_bridge --print-pairs\n\
ros2 run ros1_bridge parameter_bridge" > ${BRIDGE_WS}/start_bridge.sh

RUN echo "#!/bin/bash\n\
export ROS_MASTER_URI=http://192.168.0.103:11311\n\
export ROS_IP=192.168.0.106" >> ~/.bashrc

# Mach das Skript ausführbar
RUN chmod +x /bridge_ws/start_bridge.sh

# Startbefehl für den Container
#CMD ["bash", "/workspace/start_bridge.sh"]
#CMD ["bash","/bridge_ws/start_bridge.sh"]
CMD ["bash"]