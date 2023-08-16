---
layout: post
categories: SensorFusionProject
tags: [ubuntu, docker, nvidia-driver, nvidia-container-toolkit]
---

## Related Posts

- [SensorFusionProject Category](<https://coolwindjo.github.io/categories.html#h-SensorFusionProject>){:target="_blank"} 
- [How to start the Sensor Fusion Project]({% link _posts/SensorFusionProject/2020-11-26-how-to-start-the-sensor-fusion.md %}){:target="_blank"}

## Step by step guide

### Install Git

```terminal
sudo apt-get update -y && sudo apt-get install -q -y git
```

### Generate your SSH key for your convenient git work

- Follow the post linked => [How to add a ssh-key to your github account]({% link _posts/SensorFusionProject/2020-11-26-how-to-add-a-ssh-key-to-your-github-account.md %}){:target="_blank"}


### Easier way to be ready for the SensorFusionProject

#### Clone the "Post format settings" git repository

```terminal

git clone https://github.com/coolwindjo/post-format-settings.git

# if you have a ssh-key
git clone git@github.com:coolwindjo/post-format-settings.git

```
#### Change the permission of the files for script execution

```terminal

sudo chmod 755 post-format-settings/*
cd post-format-settings

```

#### Change the Git Configurations Information

```terminal
gedit 01_set_git_config.sh
```

- Replace the followings with your information
  - user.email "mailID@address.com"
  - user.name "UserName"
  - core.editor "gedit"

#### Run each script one by one (reboot required for some scripts)

```terminal

# Update this 'post-format-settings' git first!
git fetch && git rebase

./00_initialize_linux.sh
./01_set_git_config.sh

# if you use Ubuntu 22.04, it is safe to continue.
./02-1_install_vscode_docker.sh
./02-2_add_docker-group.sh

# Check graphic card version =>  https://developer.nvidia.com/cuda-downloads
./04_install_nvidia-driver_reboot_rqrd.sh
# <<Reboot the Desktop!>>

./05_install_nvidia-container-toolkit_reboot_rqrd.sh
# <<Reboot the Desktop!>>

# Clone the 'carla-autoware' git on you system
# Copy the '06_apply_carla-autoware_modification.sh' and '0001-modify-to-use-CARLA-Autoware.patch' to your 'carla-autoware' directory
# Go to the 'carla-autoware' local repository on your system
./06_apply_carla-autoware_modification.sh
```

### It's done!

## Report any error message or inconvenient situation to JoSH
