---
layout: post
title: Setting ROS Environment
categories: ROS
tags: [ros, official, tutorial, link]
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

sudo apt-get install python-rosdep python-rosinstall-generator python-wstool python-rosinstall build-essential
sudo apt-get install -y vim ros-melodic-costmap-converter
sudo apt-get install -y ros-melodic-diagnostic-updater
sudo apt-get install -y ros-melodic-controller-manager
sudo apt-get install -y ros-melodic-roslint
sudo apt-get install -y ros-melodic-filters
sudo apt-get install -y ros-melodic-joint-limits-interface
sudo apt-get install -y libmuparser-dev
sudo apt-get install -y ros-melodic-tf2-geometry-msgs
sudo apt-get install -y ros-melodic-rviz

sudo apt-get install ros-$ROS_DISTRO-turtle-tf2 ros-$ROS_DISTRO-tf2-tools ros-$ROS_DISTRO-tf
roslaunch turtle_tf2 turtle_tf2_demo.launch


```
