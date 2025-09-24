#!/bin/bash

docker stop magni-ros2
docker rm magni-ros2
docker run -it --net=host --ipc=host \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --volume="${XAUTHORITY}:/root/.Xauthority" \
    --name="magni-ros2" \
    solarswarm:magni-ros2 \
    bash

#bash -c "ros2 launch tb3_worlds tb3_demo_world.launch"