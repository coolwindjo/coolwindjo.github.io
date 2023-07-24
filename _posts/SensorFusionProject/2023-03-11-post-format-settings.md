---
layout: post
categories: SensorFusionProject
tags: [ubuntu, docker, nvidia-driver, nvidia-container-toolkit]
---

## Related Posts

- [How to start the Sensor Fusion Project]({% link _posts/SensorFusionProject/2020-11-26-how-to-start-the-sensor-fusion.md %}){:target="_blank"}


## Step by step guide

### Install Git

```terminal
sudo apt-get update -y && sudo apt-get install -q -y git
```

### Generate your SSH key for your convenient git work

- Follow the post linked => [How to clone a git repository with ssh-key]({% link _posts/SensorFusionProject/2020-11-26-how-to-clone-git-repository-with-ssh.md %}){:target="_blank"}


### Easier way to be ready for the SensorFusionProject

#### Clone the "Post format settings" git repository

```terminal

git clone git@github.com:SensorFusionProject/post-format-settings.git

```
#### Change the permission of the files for script execution

```terminal

sudo chmod 755 post-format-settings/*

```

#### Change the Git Configurations Information

```terminal
vim 01_set_git_config.sh
```

- Replace the followings with your information
  - "mailID@address.com"
  - "UserName"

#### Run each script one by one (reboot required for some scripts)

```terminal

./00_initialize_linux.sh
./01_set_git_config.sh
./02-1_install_vscode_docker.sh
./02-2_add_docker-group.sh
./04_install_nvidia-driver_reboot_rqrd.sh
<<Reboot the Desktop!>>
./05_install_nvidia-container-toolkit_reboot_rqrd.sh
<<Reboot the Desktop!>>

```

### Execute the script for running ROS docker

- Follow the post linked => [Execute the script for running ROS docker]({% link _posts/SensorFusionProject/2020-11-26-execute-the-script-for-runnint-ros-docker.md %}){:target="_blank"}


### It's done!


## Report any error message or inconvinient situation to JoSH
