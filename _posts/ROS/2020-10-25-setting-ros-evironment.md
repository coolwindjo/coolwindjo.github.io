---
layout: post
title: Setting ROS Environment
categories: ROS
tags: [ros, official, tutorial]
---

## ROS Official Tutorial

1. [ROS + Docker](<http://wiki.ros.org/docker/Tutorials/Docker>){:target="_blank"}
    - [Getting started with ROS and Docker Compose](<http://wiki.ros.org/docker/Tutorials/Compose>){:target="_blank"}
    - [Using GUI's with Docker](<http://wiki.ros.org/docker/Tutorials/GUI>){:target="_blank"}
      - [x11docker](<https://github.com/mviereck/x11docker>){:target="_blank"}: A simple way to run GUI appas in Docker
2. [Ubuntu install of ROS Melodic](<http://wiki.ros.org/melodic/Installation/Ubuntu>){:target="_blank"}
3. [ROS Tutorials](<http://wiki.ros.org/ROS/Tutorials>){:target="_blank"}
    - [Installing from source](<http://wiki.ros.org/jade/Installation/Source>){:target="_blank"}

## Install Dependent Libraries

![Build error for a dependent library]({{ "/assets/images/posts/2020-10-25/error_ros_dependent_lib.png" | relative_url }})

![Two ways to install a dependent library]({{ "/assets/images/posts/2020-10-25/two_ways_to_install_library.png" | relative_url }})

```terminal

sudo apt-get install -y vim apt-utils \
ros-melodic-desktop-full \
libmuparser-dev \
ros-melodic-costmap-converter \
ros-melodic-costmap-2d
#cmake \
#pkg-config \
#python-rospkg \
#python-rosdep \
#python-rosinstall-generator \
#python-wstool \
#python-rosinstall build-essential \
#ros-melodic-cv-bridge \
#ros-melodic-controller-manager \
#ros-melodic-diagnostic-updater \
#ros-melodic-dynamic-reconfigure \
#ros-melodic-geometry-msgs \
#ros-melodic-message-generation \
#ros-melodic-message-runtime \
#ros-melodic-nav-msgs \
#ros-melodic-pluginlib \
#ros-melodic-roscpp \
#ros-melodic-roscpp-git \
#ros-melodic-std-msgs \
#ros-melodic-roslint \
#ros-melodic-filters \ 
#ros-melodic-joint-limits-interface \
#ros-melodic-catkin \
#ros-build-tools \
#ros-melodic-tf2-geometry-msgs \
#ros-melodic-rviz \

sudo apt-get install ros-$ROS_DISTRO-turtle-tf2 ros-$ROS_DISTRO-tf2-tools ros-$ROS_DISTRO-tf
roslaunch turtle_tf2 turtle_tf2_demo.launch


```
