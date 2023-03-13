---
layout: post
title: How to start the Sensor Fusion Project
categories: SensorFusionProject
tags: [getting-started, ros, docker, git]
---

## Generate your SSH key for your convenient git work

If you don't already have an SSH key, you must generate a new SSH key. If you're unsure whether you already have an SSH key, check for existing keys.

```terminal

$ cat ~/.ssh/id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDltFNAyuz2eRra1NIdYC9Nh/3e/OQh4JXXuvFTv/s
...
4WYyGjrFOrpLMhDvO9Zo8o2tChlv1GxYpBMMAOHS1DEHUeGp3nVWF12qAT5tntVc5THy7Xw== coolwind@hotmail.co.kr

```

If you don't want to reenter your passphrase every time you use your SSH key, you can add your key to the SSH agent, which manages your SSH keys and remembers your passphrase.

Paste the text below, substituting in your GitHub email address.

```terminal

ssh-keygen -t rsa -b 4096 -C "your_github_email@example.com"

```

This creates a new ssh key, using the provided email as a label.

Generating public/private rsa key pair.
When you're prompted to "Enter a file in which to save the key," press Enter. This accepts the default file location.

Enter a file in which to save the key (/c/Users/you/.ssh/id_rsa):[Press enter]
At the prompt, type a secure passphrase. For more information, see "Working with SSH key passphrases".
Enter passphrase (empty for no passphrase): [Type a passphrase]
Enter same passphrase again: [Type passphrase again]

Now, check for your new generated key.

```terminal

$ cat ~/.ssh/id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDltFNAyuz2eRra1NIdYC9Nh/3e/OQh4JXXuvFTv/s
...
4WYyGjrFOrpLMhDvO9Zo8o2tChlv1GxYpBMMAOHS1DEHUeGp3nVWF12qAT5tntVc5THy7Xw== coolwind@hotmail.co.kr

```

## Add the SSH key to your GitHub account

- Go to Settings on your GitHub Profile
![Add the SSH key to your GitHub account 1]({{ "/assets/images/posts/2020-11-26/github_page1.png" | relative_url }})

- Find the button saying New SSH key and Click it
![Add the SSH key to your GitHub account 2]({{ "/assets/images/posts/2020-11-26/github_page2.png" | relative_url }})

- Paste the string you've got from the terminal and set a nickname for the SSH key
![Add the SSH key to your GitHub account 3]({{ "/assets/images/posts/2020-11-26/github_page3.png" | relative_url }})

## Clone the SensorFusion Repository

- Clone the repository using your SSH key
![Clone with SSH key from your GitHub account]({{ "/assets/images/posts/2020-11-26/github_page4.png" | relative_url }})

```terminal

git clone --recursive git@github.com:SensorFusionProject/SensorFusion.git

```
- If you want to update submodule after cloning the repository

```terminal

git submodule update --init --recursive

```

## Install Docker on your linux (Ubuntu)

[Find the method from the official homepage](<https://docs.docker.com/engine/install/ubuntu/>){:target="_blank"}

[Manage Docker as a non-root user](<https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user>){:target="_blank"}

## Execute the script for running ROS docker

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

## Then execute "catkin_make" by typing "cm"

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

## Open another terminal and attach it to the running container

```terminal

$ cd ~/SensorFusion/ros/catkin_ws
$ ./run-docker.sh
./run-docker.sh
non-network local connections being added to access control list
root@650025ccb1f3:/#

```

It's done!
