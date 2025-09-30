from launch import LaunchDescription
from launch.actions import DeclareLaunchArgument
from launch.conditions import IfCondition
from launch.substitutions import LaunchConfiguration, PathJoinSubstitution
from launch_ros.actions import Node
from launch_ros.substitutions import FindPackageShare

def generate_launch_description():
    ## ***** Launch arguments *****
    use_sim_time_arg = DeclareLaunchArgument('use_sim_time', default_value='True')
    scan_topic_arg = DeclareLaunchArgument('scan_topic', default_value='scan')
    pcd_topic_arg = DeclareLaunchArgument('pcd_topic', default_value='points2')
    odom_topic_arg = DeclareLaunchArgument('odom_topic', default_value='odom')
    resoltion_arg = DeclareLaunchArgument('resolution', default_value='0.05')
    load_state_filename_arg = DeclareLaunchArgument('load_state_filename', default_value='')
    config_basename_arg = DeclareLaunchArgument('configuration_basename', default_value='backpack_2d_ngp.lua')
    config_directory_arg = DeclareLaunchArgument(
        'configuration_directory',
        default_value=FindPackageShare('cartographer_ros')
                     .find('cartographer_ros') + '/configuration_files'
    )

    ## ***** Launch configurations *****
    use_sim_time = LaunchConfiguration('use_sim_time')
    scan_topic = LaunchConfiguration('scan_topic')
    pcd_topic = LaunchConfiguration('pcd_topic')
    odom_topic = LaunchConfiguration('odom_topic')
    resolution = LaunchConfiguration('resolution')
    config_basename = LaunchConfiguration('configuration_basename')
    config_directory = LaunchConfiguration('configuration_directory')
    load_state_filename = LaunchConfiguration('load_state_filename')

    ## ***** Nodes *****
    cartographer_node = Node(
        package='cartographer_ros',
        executable='cartographer_node',
        parameters=[{'use_sim_time': use_sim_time}],
        arguments=[
            '-configuration_directory', config_directory,
            '-configuration_basename', config_basename,
            '--load_state_filename', load_state_filename
        ],
        remappings=[
            ('scan', scan_topic), 
            ('points2', pcd_topic),
            ('odom', odom_topic)
            ],
        output='screen'
    )

    cartographer_occupancy_grid_node = Node(
        package='cartographer_ros',
        executable='cartographer_occupancy_grid_node',
        parameters=[
            {'use_sim_time': use_sim_time},
            {'resolution': resolution}
        ],
        output='screen'
    )

    return LaunchDescription([
        use_sim_time_arg,
        scan_topic_arg,
        pcd_topic_arg,
        odom_topic_arg,
        resoltion_arg,
        load_state_filename_arg,
        config_basename_arg,
        config_directory_arg,
        cartographer_node,
        cartographer_occupancy_grid_node
    ])
