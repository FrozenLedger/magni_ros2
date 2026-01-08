from launch import LaunchDescription
from launch_ros.actions import Node
from launch.actions import IncludeLaunchDescription
from launch.launch_description_sources import PythonLaunchDescriptionSource
from ament_index_python.packages import get_package_share_directory
import os

def generate_launch_description():

    pkg_share = get_package_share_directory('magni_description')

    # Parameter-Dateien
    nav2_params = os.path.join(pkg_share, 'config', 'nav2_params.yaml')
    slam_params = os.path.join(pkg_share, 'config', 'slam_toolbox_params.yaml')

    return LaunchDescription([

        # SLAM Toolbox
        Node(
            package='slam_toolbox',
            executable='sync_slam_toolbox_node',
            name='slam_toolbox',
            parameters=[slam_params],
            output='screen'
        ),

        # Nav2 bringup
        IncludeLaunchDescription(
            PythonLaunchDescriptionSource(
                os.path.join(
                    get_package_share_directory('nav2_bringup'),
                    'launch',
                    'bringup_launch.py'
                )
            ),
            launch_arguments={
                'use_sim_time': 'False',
                'params_file': nav2_params,
                'autostart': 'True',
                'map':'map_yaml'
            }.items()
        )

    ])
