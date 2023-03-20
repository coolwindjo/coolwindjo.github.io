---
layout: post
title: How to start the Sensor Fusion Project
categories: SensorFusionProject
tags: [getting-started, ros, docker]
---

## Easier way to do this post

- [Post Format Settings]({% link _posts/SensorFusionProject/2023-03-11-post-format-settings.md %}){:target="_blank"}


## Step by step guide
### Generate your SSH key for your convenient git work

- Follow the post linked => [How to clone a git repository with ssh-key]({% link _posts/SensorFusionProject/2020-11-26-how-to-clone-git-repository-with-ssh.md %}){:target="_blank"}

### Clone the SensorFusion Repository

- Clone the repository using your SSH key
![Clone with SSH key from your GitHub account]({{ "/assets/images/posts/2020-11-26/github_page4.png" | relative_url }})

```terminal

git clone --recursive git@github.com:SensorFusionProject/SensorFusion.git

```
- If you want to update submodule after cloning the repository

```terminal

git submodule update --init --recursive

```

### Install Docker on your linux (Ubuntu)

- [Find the method from the official homepage](<https://docs.docker.com/engine/install/ubuntu/>){:target="_blank"}

- [Manage Docker as a non-root user](<https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user>){:target="_blank"}

### Execute the script for running ROS docker

- Follow the post linked => [Execute the script for running ROS docker]({% link _posts/SensorFusionProject/2020-11-26-execute-the-script-for-runnint-ros-docker.md %}){:target="_blank"}


### It's done!
