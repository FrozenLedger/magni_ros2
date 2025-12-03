import os
from launch import LaunchDescription
from launch_ros.actions import Node
from ament_index_python.packages import get_package_share_directory
import xacro

def generate_launch_description():
    # Pfad zur XACRO-Datei
    pkg_share = get_package_share_directory('magni_description')
    xacro_file = os.path.join(pkg_share, 'urdf', 'magni.urdf.xacro')

    # XACRO parsen und URDF erzeugen
    robot_description_config = xacro.process_file(xacro_file).toxml()

    # Node: robot_state_publisher
    robot_state_publisher_node = Node(
        package='robot_state_publisher',
        executable='robot_state_publisher',
        name='robot_state_publisher',
        output='screen',
        parameters=[{'robot_description': robot_description_config}]
    )

    # Optional: joint_state_publisher_gui für Visualisierung in RViz2
    joint_state_publisher_node = Node(
        package='joint_state_publisher_gui',
        executable='joint_state_publisher_gui',
        name='joint_state_publisher_gui'
    )

    return LaunchDescription([
        robot_state_publisher_node,
        joint_state_publisher_node
    ])