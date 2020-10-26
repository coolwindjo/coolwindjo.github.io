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

## Install Dependent Libraries

![Build error for a dependent library]({{ "/assets/images/posts/2020-10-25/error_ros_dependent_lib.png" | relative_url }})

```terminal

sudo apt-get install -y vim ros-melodic-costmap-converter
sudo apt-get install -y ros-melodic-diagnostic-updater
sudo apt-get install -y ros-melodic-controller-manager
sudo apt-get install -y ros-melodic-roslint
sudo apt-get install -y ros-melodic-filters
sudo apt-get install -y ros-melodic-joint-limits-interface
sudo apt-get install -y libmuparser-dev



```
