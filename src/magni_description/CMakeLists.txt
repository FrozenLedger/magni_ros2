cmake_minimum_required(VERSION 3.5)
project(magni_description)

# Abhängigkeiten von ament_cmake
find_package(ament_cmake REQUIRED)
find_package(rclcpp REQUIRED)
find_package(xacro REQUIRED)
find_package(robot_state_publisher REQUIRED)
find_package(urdf REQUIRED)

# Installationsregeln
install(DIRECTORY urdf launch meshes extrinsics
  DESTINATION share/${PROJECT_NAME}
)

# Für Python Launch-Files
ament_package()