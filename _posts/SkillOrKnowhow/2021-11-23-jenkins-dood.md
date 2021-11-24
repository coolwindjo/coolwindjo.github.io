---
layout: post
title: Jekins using Docker out of Docker
categories: SkillOrKnowhow
tags: [jenkins, docker, dood]
---

## Reference Links

- Jekins using DooD
  - [Gitee - Jenkins with DooD (Docker outside of Docker)](<https://gitee.com/onisuly/docker-jenkins-dood>){:target="_blank"} y

## Sample Source Codes

- [Scripts for Jenkins in Docker](<https://github.com/coolwindjo/jenkins_scripts/tree/main/.devcontainer>){:target="_blank"} 

### Dockerfile

```dockerfile
FROM jenkins/jenkins:lts
# FROM jenkins/jenkins:2.303.2-jdk11
MAINTAINER onisuly <onisuly@gmail.com>

# if we want to install via apt
USER root

# Add jenkins user to docker group
ARG dockerGid=999
RUN echo "docker:x:${dockerGid}:jenkins" >> /etc/group \ 
    && apt-get update && apt-get install -y libltdl7 \
    && rm -rf /var/lib/apt/list/*

# Install Jenkins plugins
USER jenkins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# # install packages
# RUN apt-get update && apt-get install -q -y --no-install-recommends \
# 	apt-transport-https \ 
# 	ca-certificates curl gnupg2 \ 
# 	software-properties-common \ 
# 	tar \ 
# 	xz-utils \ 
# 	bash-completion \
# 	vim \
# 	&& apt-get clean && rm -rf /var/lib/apt/lists/*

# RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
# RUN apt-key fingerprint 0EBFCD88
# RUN add-apt-repository \
#        "deb [arch=amd64] https://download.docker.com/linux/debian \
#        $(lsb_release -cs) stable"
# RUN apt-get update && apt-get install -y docker-ce-cli

# # drop back to the regular jenkins user - good practice
# USER jenkins
# RUN jenkins-plugin-cli --plugins \
# 	"blueocean:1.25.1" \
# 	"docker-workflow:1.26" \
# 	"extended-choice-parameter" \
# 	"role-strategy" \
# 	"pipeline-model-definition" 

# COPY --chown=jenkins:jenkins executors.groovy /usr/share/jenkins/ref/init.groovy.d/executors.groovy

```

### Run Jenkins Docker

```bash
JENKINS_DATA=${PWD}/../../../workspace/jenkins_home/data

sudo chown -R 1000.1000 ${JENKINS_DATA}

docker network create jenkins

docker build -t jenkins-dood-image . && \
docker run \
	--name jenkins-dood \
	--detach \
	--publish 8080:8080 \
	--publish 50000:50000 \
	--restart=always \
	--volume $(which docker):/usr/bin/docker \
	--volume /var/run/docker.sock:/var/run/docker.sock \
	--volume ${JENKINS_DATA}:/var/jenkins_home \	# --volume $HOME/jenkins:/var/jenkins_home would map the container’s /var/jenkins_home directory to the jenkins subdirectory within the $HOME directory on your local machine, which would typically be /Users/<your-username>/jenkins or /home/<your-username>/jenkins. Note that if you change the source volume or directory for this, the volume from the docker:dind container above needs to be updated to match this.
	--volume /mnt/motional_database:/mnt/motional_database \
	--workdir=/var/jenkins_home \
	jenkins-dood-image

	# --rm \
	# --privileged \
	# --network jenkins \
	# --network-alias docker \	# Makes the Docker in Docker container available as the hostname docker within the jenkins network.
	# --env DOCKER_TLS_CERTDIR=/certs \	# Enables the use of TLS in the Docker server. Due to the use of a privileged container, this is recommended, though it requires the use of the shared volume described below. This environment variable controls the root directory where Docker TLS certificates are managed.
	# --env DOCKER_CERT_PATH=/certs/client \
	# --env DOCKER_TLS_VERIFY=1 \
	# --env DOCKER_HOST=tcp://docker:2376 \	# 	Specifies the environment variables used by docker, docker-compose, and other Docker tools to connect to the Docker daemon from the previous step.
	# --volume jenkins-docker-certs:/certs/client \
	# --publish 2376:2376 \	# ( Optional ) Exposes the Docker daemon port on the host machine. This is useful for executing docker commands on the host machine to control this inner Docker daemon.
	docker:dind
```

### Stop Jenkins Docker

```bash
docker stop jenkins-dood

docker network rm jenkins

docker volume rm jenkins-docker-certs

docker rmi jenkins-dood-image
```

