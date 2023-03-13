---
layout: post
title: How to add a new module in docker container
categories: SensorFusionProject
tags: [getting-started, docker]
---

## Modify Dockerfile

```terminal

cd ~/SensorFusion/ros
vim Dockerfile
# surely your can use gedit or vscode

```

- Add a new module to be installed in the docker container after the command "sudo apt-get install -y \"
- The back slash (\\) make the next line to be joined to previous one. So there is no need to put it on the last line.
- You can bring another RUN header for your own shell command.
![Modify Dockerfile]({{ "/assets/images/posts/2020-11-27/modify_dockerfile.png" | relative_url }})

## Temporally modify the run-docker.sh to use your own container to be built with the Dockerfile

```terminal

cd ~/SensorFusion/ros/catkin_ws
vim run-docker.sh
# surely your can use gedit or vscode

```

- Replace the "IMAGE='coolwindjo/ros-melodic:latest'" with "IMAGE='ros-melodic:latest'" by removing and adding sharps(#)
![Modify run-docker.sh]({{ "/assets/images/posts/2020-11-27/modify_rundocker.png" | relative_url }})

## Execute the script for building the Dockerfile and running the corresponding docker container

```terminal

$ cd ~/SensorFusion/ros
$ chmod 755 build_and_run.sh
$ ./build_and_run.sh
...
...

```

## Test your new module

- Now, you can test your new module in the new docker container.

## Push the Dockerfile only and reset the others

```terminal

git add ros/Dockerfile
git commit -m "update the Dockerfile by adding new module"
git push
git reset --hard HEAD

```
