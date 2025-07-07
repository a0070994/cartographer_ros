#ifndef CARTOGRAPHER_ROS_FLAGS_H_
#define CARTOGRAPHER_ROS_FLAGS_H_

#include <gflags/gflags.h>

// Common flags
DECLARE_string(configuration_directory);
DECLARE_string(configuration_basename);
DECLARE_string(load_state_filename);
DECLARE_bool(load_frozen_state);
DECLARE_string(save_state_filename);
DECLARE_bool(collect_metrics);

// node_main specific
DECLARE_bool(start_trajectory_with_default_topics);

// offline_node specific
DECLARE_string(configuration_basenames);
DECLARE_string(bag_filenames);
DECLARE_string(urdf_filenames);
DECLARE_bool(use_bag_transforms);
DECLARE_bool(keep_running);
DECLARE_double(skip_seconds);


#endif  // CARTOGRAPHER_ROS_FLAGS_H_
