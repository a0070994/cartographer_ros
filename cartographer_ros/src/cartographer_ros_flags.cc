#include <gflags/gflags.h>

// Common flags
DEFINE_string(configuration_directory, "",
              "First directory in which configuration files are searched, "
              "second is always the Cartographer installation to allow "
              "including files from there.");
DEFINE_string(configuration_basename, "",
              "Basename, i.e. not containing any directory prefix, of the "
              "configuration file.");
DEFINE_string(load_state_filename, "",
              "If non-empty, filename of a .pbstream file to load, containing "
              "a saved SLAM state.");
DEFINE_bool(load_frozen_state, true,
            "Load the saved state as frozen (non-optimized) trajectories.");
DEFINE_string(save_state_filename, "",
              "If non-empty, serialize state and write it to disk before shutting down.");
DEFINE_bool(collect_metrics, false, "Enable metric collection.");

// node_main specific
DEFINE_bool(start_trajectory_with_default_topics, true,
            "Enable to immediately start the first trajectory with default topics.");

// offline_node specific
DEFINE_string(configuration_basenames, "",
              "Comma-separated list of basenames, i.e. not containing any "
              "directory prefix, of the configuration files for each trajectory. "
              "The first configuration file will be used for node options. "
              "If less configuration files are specified than trajectories, the "
              "first file will be used for the remaining trajectories.");
DEFINE_string(bag_filenames, "",
              "Comma-separated list of bags to process. One bag per trajectory. "
              "Any combination of simultaneous and sequential bags is supported.");
DEFINE_string(urdf_filenames, "",
              "Comma-separated list of one or more URDF files that contain "
              "static links for the sensor configuration(s).");
DEFINE_bool(use_bag_transforms, true,
            "Whether to read, use and republish transforms from bags.");
DEFINE_bool(keep_running, false,
            "Keep running the offline node after all messages from the bag "
            "have been processed.");
DEFINE_double(skip_seconds, 0,
              "Optional amount of seconds to skip from the beginning "
              "(i.e. when the earliest bag starts.). ");
