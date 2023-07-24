---
layout: post
title: Execute the script for running ROS docker
categories: SensorFusionProject
tags: [getting-started, ros, docker]
---

## Related Posts

- [How to start the Sensor Fusion Project]({% link _posts/SensorFusionProject/2020-11-26-how-to-start-the-sensor-fusion.md %}){:target="_blank"}

## Step by step guide

### Execute the script for running ROS docker

```terminal

$ cd ~/SensorFusion/ros/catkin_ws
$ chmod 755 run-docker.sh
$ ./run-docker.sh
./run-docker.sh
Error: No such object: ros-melodic-dev
non-network local connections being added to access control list
bash: /root/catkin_ws/devel/setup.bash: No such file or directory
root@650025ccb1f3:/#

```

### Then execute "catkin_make" by typing "cm"

```terminal

root@650025ccb1f3:/# cm
Base path: /root/catkin_ws
Source space: /root/catkin_ws/src
Build space: /root/catkin_ws/build
Devel space: /root/catkin_ws/devel
Install space: /root/catkin_ws/install
Creating symlink "/root/catkin_ws/src/CMakeLists.txt" pointing to "/opt/ros/melodic/share/catkin/cmake/toplevel.cmake"
...
...
...
[ 98%] Built target canopen_motor
Scanning dependencies of target canopen_motor_node
[ 98%] Building CXX object radar_package/ros_canopen/canopen_motor_node/CMakeFiles/canopen_motor_node.dir/src/canopen_motor_chain_node.cpp.o
[100%] Linking CXX executable /root/catkin_ws/devel/lib/canopen_motor_node/canopen_motor_node
[100%] Built target canopen_motor_node
root@9b7c0bfc6d18:~/catkin_ws#

```

### Open another terminal and attach it to the running container

```terminal

$ cd ~/SensorFusion/ros/catkin_ws
$ ./run-docker.sh
./run-docker.sh
non-network local connections being added to access control list
root@650025ccb1f3:/#

```

It's done!
