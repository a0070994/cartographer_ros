-- Copyright 2016 The Cartographer Authors
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

include "map_builder.lua"
include "trajectory_builder.lua"

options = {
  map_builder = MAP_BUILDER,
  trajectory_builder = TRAJECTORY_BUILDER,
  map_frame = "map",
  tracking_frame = "base_link",
  published_frame = "odom",
  odom_frame = "odom",
  provide_odom_frame = false,
  publish_frame_projected_to_2d = false,
  use_pose_extrapolator = true,
  use_odometry = true,
  use_nav_sat = false,
  use_landmarks = false,
  num_laser_scans = 0,
  num_multi_echo_laser_scans = 0,
  num_subdivisions_per_laser_scan = 1,
  num_point_clouds = 1,
  lookup_transform_timeout_sec = 0.2,
  submap_publish_period_sec = 0.3,
  pose_publish_period_sec = 5e-3,
  trajectory_publish_period_sec = 30e-3,
  rangefinder_sampling_ratio = 1.,
  odometry_sampling_ratio = 1.,
  fixed_frame_pose_sampling_ratio = 1.,
  imu_sampling_ratio = 1.,
  landmarks_sampling_ratio = 1.,
}

------------ Local SLAM ------------

MAP_BUILDER.use_trajectory_builder_2d = true
MAP_BUILDER.num_background_threads = 4                                                            -- default 4
TRAJECTORY_BUILDER_2D.use_imu_data = false
TRAJECTORY_BUILDER_2D.num_accumulated_range_data = 1
TRAJECTORY_BUILDER_2D.min_range = 1                                                               -- default 0.
TRAJECTORY_BUILDER_2D.max_range = 25                                                              -- default 30.   (maximum usable range for the lidar)
TRAJECTORY_BUILDER_2D.min_z = 0.0
TRAJECTORY_BUILDER_2D.max_z = 3.0
TRAJECTORY_BUILDER_2D.use_online_correlative_scan_matching = true                                 -- default false
TRAJECTORY_BUILDER_2D.adaptive_voxel_filter.min_num_points = 190                                  -- default 200
TRAJECTORY_BUILDER_2D.adaptive_voxel_filter.max_range = 40.                                       -- default 50.
TRAJECTORY_BUILDER_2D.adaptive_voxel_filter.max_length = 0.5                                      -- default 0.5
TRAJECTORY_BUILDER_2D.voxel_filter_size = 0.030                                                   -- default 0.025 (successfully tested with 0.025)
TRAJECTORY_BUILDER_2D.ceres_scan_matcher.translation_weight = 10.                                 -- default 10.
TRAJECTORY_BUILDER_2D.ceres_scan_matcher.rotation_weight = 20.                                    -- default 40.   (require a higher matching score to rotate (yet somewhat loose))
TRAJECTORY_BUILDER_2D.submaps.num_range_data = 90                                                 -- default 90    (number of range data before adding a new submap -> submap size)
TRAJECTORY_BUILDER_2D.submaps.grid_options_2d.resolution = 0.05                                   -- default 0.05  (will be overwritten by GridMapCartographer Module)
--TRAJECTORY_BUILDER_2D.imu_gravity_time_constant = 1                                             -- default 10.
--TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.linear_search_window = 0.15            -- default 0.1
--TRAJECTORY_BUILDER_2D.real_time_correlative_scan_matcher.angular_search_window = math.rad(35.)  -- default math.rad(20.)

------------ Global SLAM ------------

POSE_GRAPH.optimize_every_n_nodes = 40                                                            -- default 90    (really low to solve kidnapping at startup)
POSE_GRAPH.global_sampling_ratio = 0.002                                                          -- default 0.003
POSE_GRAPH.global_constraint_search_after_n_seconds = 10.                                         -- default 10.
POSE_GRAPH.constraint_builder.sampling_ratio = 0.18                                               -- default 0.3   (successfully tested with 0.02)
POSE_GRAPH.constraint_builder.min_score = 0.60                                                    -- default 0.55
POSE_GRAPH.constraint_builder.fast_correlative_scan_matcher.linear_search_window = 4.             -- default 7.
POSE_GRAPH.constraint_builder.fast_correlative_scan_matcher.angular_search_window = math.rad(30.) -- default 30.

-- Quality of Input Trajectory
POSE_GRAPH.optimization_problem.odometry_translation_weight = 100                                 -- default 1e5
POSE_GRAPH.optimization_problem.odometry_rotation_weight = 0.1                                    -- default 1e5
POSE_GRAPH.optimization_problem.fixed_frame_pose_translation_weight = 1e1                         -- default 1e1
POSE_GRAPH.optimization_problem.fixed_frame_pose_rotation_weight = 1e2                            -- default 1e2
POSE_GRAPH.max_num_final_iterations = 200                                                         -- default 200

-- Quality of Trajectory Estimate
POSE_GRAPH.optimization_problem.local_slam_pose_translation_weight = 1e5                          -- default 1e5
POSE_GRAPH.optimization_problem.local_slam_pose_rotation_weight = 1e5                             -- default 1e5
POSE_GRAPH.optimization_problem.log_solver_summary = false                                        -- default false
--POSE_GRAPH.optimization_problem.huber_scale = 1e2                                               -- default 1e1

------------ Logging ------------

POSE_GRAPH.constraint_builder.log_matches = false                                                 -- default true
POSE_GRAPH.log_residual_histograms = false                                                        -- default true
POSE_GRAPH.optimization_problem.log_solver_summary = false                                        -- default true

-------------------------------------------------------------------------------------
-- Cartographer Tuning Methodology (CTM)
-- https://google-cartographer-ros.readthedocs.io/en/latest/tuning.html
-- https://google-cartographer-ros.readthedocs.io/en/latest/algo_walkthrough.html

return options
