---
layout: post
title: Title
categories: Skill
tags: [gui, docker]
---
## 

```terminal
$ xhost +local:docker
non-network local connections being added to access control list
$ docker run -it \
        -e DISPLAY=$DISPLAY \
        -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
        IMAGE_NAME
$ xhost -local:docker
non-network local connections being removed from access control list
```