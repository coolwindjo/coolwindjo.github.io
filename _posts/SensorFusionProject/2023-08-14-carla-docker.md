---
layout: post
categories: SensorFusionProject
tags: [ros, getting-started, ]
---

### Reference Links

- [CARLA-AUTOWARE](<https://github.com/carla-simulator/carla-autoware>){:target="_blank"} 

### Set up CARLA-DOCKER

- ROS1(Melodic) + Autoware.ai(1.14.0) + Carla(0.9.10.1)

#### Dockerfile for Carla-docker

- Set file name as a 'Dockerfile' and 'docker-compose.yml'
- Copy and paste the following contents into the each file.
- Replace the 'coolwind' with your 'user name' 

```Dockerfile

FROM carlasim/carla:0.9.10.1

USER root

ENV USER_NAME "coolwind"

RUN \
    apt-get update && \
    apt-get install -y -q --no-install-recommends \
        -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
        build-essential \
        chrpath \
        cpio \
        diffstat \
        file \
        g++-multilib \
        gawk \
        gcc-multilib \
        git-core \
        locales \
        openssh-client \
        python \
        python3 \
        socat \
        sudo \
        texinfo \
        tmux \
        unzip \
        wget \
        vim \
    && rm -rf /var/lib/apt/lists/* && \
    locale-gen en_US.UTF-8

    ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

RUN \
    apt-get update && \
    apt-get install -y -q --no-install-recommends \
        -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/* && \
    wget -O /usr/local/bin/repo https://storage.googleapis.com/git-repo-downloads/repo && \
    chmod a+x /usr/local/bin/repo

# Clean up APT when done and set shell and user options.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*          \
        && rm /bin/sh && ln -s /bin/bash /bin/sh                            \
        && groupadd -g 1000 ${USER_NAME}                                    \
        && useradd -u 1000 -g 1000 -ms /bin/bash ${USER_NAME}               \
        && usermod -a -G sudo ${USER_NAME}                                  \
        && usermod -a -G users ${USER_NAME}                                 \
        && usermod --password ${USER_NAME} ${USER_NAME}                     \
        && usermod --password toor root                                     \
        && passwd -d root                                                   \
        && passwd -d ${USER_NAME}


# Run as yocto user from the installation path
RUN install -o 1000 -g 1000 -m 2777  -d ${EXCH_PATH}                        \
        && install -o 1000 -g 1000 -m 2777 -d ${EXCH_PATH_INPUT}            \
        && install -o 1000 -g 1000 -m 2777 -d ${EXCH_PATH_OUTPUT}


USER ${USER_NAME}

```

#### Set up docker-compose.yml

```docker-compose.yml

version: '3.8'

services:
  carla:
    build:
      context: .
      dockerfile: Dockerfile
    command: ["bash", "./CarlaUE4.sh", "-vulkan"]
    runtime: nvidia
    environment:
      - DISPLAY=${DISPLAY}
      - NVIDIA_VISIBLE_DEVICES=all
      - NVIDIA_DRIVER_CAPABILITIES=all
      - QT_X11_NO_MITSHM=1 # Fix a bug with QT
      - SDL_VIDEODRIVER=x11
    user: ${UID}
    volumes:
      - ${HOME}/.Xauthority:/root/.Xauthority:rw
      - /tmp/.X11-unix:/tmp/.X11-unix
      - /etc/group:/etc/group:ro
      - /etc/passwd:/etc/passwd:ro
      - /etc/shadow:/etc/shadow:ro
      - /etc/sudoers:/etc/sudoers:ro
      - /etc/sudoers.d:/etc/sudoers.d:ro
      - /home/${USER}:/home/${USER}:rw #share your home with write permissions
    privileged: true
    network_mode: "host"
    stdin_open: true
    tty: true

```

### Run docker with docker-compose

```bash
$ docker compose up
$ sudo apt-get install docker-compose
```

### Set up carla-autoware

- [CARLA-AUTOWARE #Setup](<https://github.com/carla-simulator/carla-autoware#setup>){:target="_blank"} 
