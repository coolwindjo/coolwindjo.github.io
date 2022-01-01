---
layout: post
title: Docker in Docker and Docker out of Docker for Jenkins
categories: Scripts
tags: [dockerfile, jenkins, docker, dind, dood]
---


## Jenkins in Docker

### Reference Links

- Install Jenkins via Docker
  - [Official Manual - Jenkins via Docker](<https://www.jenkins.io/doc/book/installing/docker/#customizing-jenkins-with-plugins>){:target="_blank"} Useful guide for Downloading and running Jenkins in Docker
  - [Official GitHub Documentation for Jenkins Docker Image](<https://github.com/jenkinsci/docker/blob/master/README.md>){:target="_blank"} Not yet to be used but, useful someday...
  - [Official Docker Hub for Jenkins Docker Image](<https://hub.docker.com/r/jenkins/jenkins/tags>){:target="_blank"} Not yet to be used but, useful someday...
- Getting Started with Jenkins
  - [Official Manual - Create your first Pipeline](<https://www.jenkins.io/doc/pipeline/tour/hello-world/>){:target="_blank"} Useful step by step guide for pipelilne plugin
  - [Official Manaual - Creating Jenkins Pipeline with Blueocean](<https://www.jenkins.io/doc/book/blueocean/creating-pipelines/>){:target="_blank"} Useful guide for creating pipeline with blueocean plugin
  - [Official Manaual - Pipeline Syntax](<https://www.jenkins.io/doc/book/pipeline/syntax/>){:target="_blank"} Useful guide for writing pipeline syntax with blueocean plugin
    - [Blog - Description of Jenkins Blueocean (Korean)](<https://logical-code.tistory.com/179>){:target="_blank"} Good to understand the what the Blueocean plugin is...
    - [Blog - Guide for Jenkins Blueocean](<https://www.jenkins.io/doc/book/pipeline/getting-started/#built-in-documentation>){:target="_blank"} Useful guide for using blueocean plugin
- Groovy
  - [Official Manaual - Pipeline & Groovy Snippet Generator](<https://www.jenkins.io/doc/book/pipeline/getting-started/#built-in-documentation>){:target="_blank"} Useful guide for writing pipeline syntax and groovy
  - [Official Manual - Groovy](<https://groovy-lang.org/>){:target="_blank"} Useful guide for writing groovy file to be loaded by Jenkinsfile
  - [Blog - Groovy Working with Lines in Strings](<https://blog.mrhaki.com/2009/11/groovy-goodness-working-with-lines-in.html>){:target="_blank"} When you want to write multiple lines of strings
  - [Blog - Jenkins2 Pipeline jobs using Groovy code in Jenkinsfile](<https://wilsonmar.github.io/jenkins2-pipeline/#unicode-icons>){:target="_blank"} Miscellaneous knowledges about Jenkinsfile
  - [Blog - Guide for Jenkins Role-based Authorization Strategy](<https://www.guru99.com/create-users-manage-permissions.html>){:target="_blank"} Useful guide for access control on jenkins

## DinD and DooD for jenkins

### Reference Links

- Background knowledges
  - [Blog - Docker Client - Server Arhitecture](<https://aidanbae.github.io/code/docker/docker-overview/>){:target="_blank"} Docker Client - Server Arhitecture
  - [Official Docs - Runtime privilege and Linux capabilities](<https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities>){:target="_blank"} Explains several options for running docker container
  - [Github - NVIDIA DinD Container (not for jenkins)](<https://github.com/ehfd/nvidia-dind>){:target="_blank"} Simple dind container for general purposes
- Comparisons of DinD vs DooD
  - [Blog - DinD vs. DooD (Korean)](<https://mns010.tistory.com/25>){:target="_blank"} Simple descriptions of DinD and DooD with refer to the nastybox blog
  - [Blog - DinD vs DooD by NastyBox](<https://blog.nestybox.com/2019/09/14/dind.html>){:target="_blank"} Good explaination about DinD and DooD while introducing their own secure dind solution
- Which one should I use? DinD or DooD?
  - [Blog - DooD rather than DinD by jpetazzo](<https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/>){:target="_blank"} Most quoted blog that explains the drawbacks of Docker in Docker
  - [Blog - DinD rather than DooD on K8s by applatix](<https://applatix.com/case-docker-docker-kubernetes-part/>){:target="_blank"} DinD can be better structure when you use kubernetes


### Docker Client - Server Arhitecture

- Client (e.g. docker CLI) requests to the Docker Daemon (dockerd)
- Using belows for communication
  - RESTAPI
  - Unix Socket (in a local host)
  - TCP Socket (between remote machines)


### Docker in Docker

- Two docker daemons exist.
  - One on the host
  - The other on a container (e.g. dind) on a host
- Requires "--privieged" option
- System-level program does not run inside a regular Docker container because
  - Container does not expose sufficient kernel resources and appropriate permissions
  - Issues related to
    - Docker’s use of overlay filesystems,
    - security profiles,
    - etc.

#### Reference Links

- [Github - NVIDIA DinD (Docker in Docker) Container by ehfd](<https://github.com/ehfd/nvidia-dind>){:target="_blank"} GPU enabled DinD but not suitable for Jenkins (which create a separate DinD container apart from the jenkins container)

#### Sample Source Codes

- [Scripts for Jenkins in Docker](<https://github.com/coolwindjo/jenkins_scripts/tree/master_nvidia_dind>){:target="_blank"}

##### Dockerfiles

```Dockerfile
FROM jenkins/jenkins:2.303.2-jdk11

# if we want to install via apt
USER root

# install packages
RUN apt-get update && apt-get install -q -y --no-install-recommends \
	apt-transport-https \
	ca-certificates curl gnupg2 \
	software-properties-common \
	tar \
	xz-utils \
	bash-completion \
	vim \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian \
       $(lsb_release -cs) stable"
RUN apt-get update && apt-get install -y docker-ce-cli

# drop back to the regular jenkins user - good practice
USER jenkins
RUN jenkins-plugin-cli --plugins \
	"blueocean:1.25.1" \
	"docker-workflow:1.26" \
	"extended-choice-parameter" \
	"role-strategy" \
	"pipeline-model-definition"

COPY --chown=jenkins:jenkins executors.groovy /usr/share/jenkins/ref/init.groovy.d/executors.groovy
```

```Dockerfile
FROM nvidia/opengl:1.2-glvnd-runtime-ubuntu20.04

RUN apt-get update && apt-get install -y \
        apt-utils \
        ca-certificates \
        openssh-client \
        curl \
        iptables \
        git \
        gnupg \
        supervisor && \
    rm -rf /var/lib/apt/list/*

# NVIDIA Container Toolkit & Docker
RUN distribution=$(. /etc/os-release;echo $ID$VERSION_ID) && \
    curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | apt-key add - && \
    curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | tee /etc/apt/sources.list.d/nvidia-docker.list && \
    apt-get update && apt-get install -y nvidia-docker2 docker.io docker-compose && \
    rm -rf /var/lib/apt/list/*

COPY modprobe startup.sh /usr/local/bin/
COPY supervisor/ /etc/supervisor/conf.d/
COPY logger.sh /opt/bash-utils/logger.sh

RUN chmod +x /usr/local/bin/startup.sh /usr/local/bin/modprobe
VOLUME /var/lib/docker

ENTRYPOINT ["startup.sh"]
CMD ["sh"]
```

##### Run Jenkins Docker (for Docker in Docker)

```bash
JENKINS_DATA=${PWD}/../../workspace/jenkins_home/data

docker network create jenkins

cd ./nvidia-dind && \
docker build -t nvidia-dind-image . && \
docker run \
	--name nvidia-dind-container \
	--rm \
	--detach \
	--privileged \
	--gpus 1 \
	--network jenkins \
	--network-alias docker \	# Makes the Docker in Docker container available as the hostname docker within the jenkins network.
	--env DOCKER_TLS_CERTDIR=/certs \	# Enables the use of TLS in the Docker server. Due to the use of a privileged container, this is recommended, though it requires the use of the shared volume described below. This environment variable controls the root directory where Docker TLS certificates are managed.
	--volume jenkins-dind-certs:/certs/client \
	--volume ${JENKINS_DATA}:/var/jenkins_home \
	--volume /mnt/motional_database:/mnt/motional_database \
	--publish 2376:2376 \	# ( Optional ) Exposes the Docker daemon port on the host machine. This is useful for executing docker commands on the host machine to control this inner Docker daemon.
	nvidia-dind-image:latest \
	--storage-driver overlay2	# The storage driver for the Docker volume. See "Docker storage drivers" for supported options.
```

##### Stop Jenkins Docker (for Docker in Docker)

```bash
docker stop nvidia-dind-container

docker rmi nvidia-dind-image

docker network rm jenkins

docker volume rm jenkins-docker-certs
```


##### Run Jenkins (installed) Container

```bash
JENKINS_DATA=${PWD}/../../workspace/jenkins_home/data

sudo chown -R 1000.1000 ${JENKINS_DATA}
sudo chmod 777 ${JENKINS_DATA}/..

cd ./jenkins-dind && \
docker build -t jenkins-image . && \
docker run \
	--name jenkins-container \
	--rm \
	--detach \
	--network jenkins \
	--env DOCKER_HOST=tcp://docker:2376 \
	--env DOCKER_CERT_PATH=/certs/client \
	--env DOCKER_TLS_VERIFY=1 \
	--publish 8081:8080 \
	--publish 50000:50000 \
	--volume ${JENKINS_DATA}:/var/jenkins_home \
	--volume ${JENKINS_DATA}/..:/var/jenkins_out \
	--volume jenkins-docker-certs:/certs/client \
	--volume /mnt/motional_database:/mnt/motional_database \
	--workdir=/var/jenkins_home \
	jenkins-image
```

##### Stop Jenkins Container

```bash
docker stop jenkins-container

docker rmi jenkins-image
```

### Docker out of Docker

- Only docker daemon runs on the host.
  - Client (e.g. docker CLI) is on a container on a host
- The connection is done by mounting the host’s Docker’s socket into the container that runs the Docker CLI. For example:

```bash
  $ docker run -it -v /var/run/docker.sock:/var/run/docker.sock docker
```
- Benefits
  - One key benefit: it bypasses the complexities of running the Docker daemon inside a container and does not require an unsecure privileged container.
  - Avoids having multiple Docker image caches in the system
    - since there is only one Docker daemon on the host
    - if your system is constrained on storage space

- Drawbacks.
  - Main drawback: it results in poor context isolation because the Docker CLI runs within a different context than the Docker daemon.
    - While DinD runs within the container’s context; DooD runs within host’s context. This leads to problems such as:
      - Container naming collisions
      - Mount paths confusion:
        - Container running the Docker CLI creates a container with a bind mount, the mount path must be relative to the host (as otherwise the host Docker daemon on the host won’t be able to perform the mount correctly).
      - Port mappings:
        - Container running the Docker CLI creates a container with a port mapping, the port mapping occurs at the host level, potentially colliding with other port mappings.
  - Not good on Kubernetes
    - Any containers created by the containerized Docker CLI will not be encapsulated within the associated Kubernetes pod, and will thus be outside of Kubernetes’ visibility and control.
  - Finally, there are security concerns too:
    - Container running the Docker CLI can manipulate any containers running on the host.
      - It can remove containers created by other entities on the host, or
      - even create unsecure privileged containers putting the host at risk.

#### Reference Links

- Jekins using DooD
  - [Gitee - Jenkins with DooD (Docker outside of Docker) by onisuly](<https://gitee.com/onisuly/docker-jenkins-dood>){:target="_blank"} Simple Dockerfile being referred most
  - [Github - Jenkins + DOOD (Docker-Outside-Of-Docker) by psharkey](<https://github.com/psharkey/docker/tree/master/jenkins-dood>){:target="_blank"} refer it for adding jenkins to sudoers
  - [Github - Jenkins with DooD (Docker outside of Docker) by axltxl](<https://github.com/axltxl/docker-jenkins-dood>){:target="_blank"} Last commit is done in 2016 and it is using supervisor
  - [Github - Simple-Jenkins-DooD by toto1310](<https://github.com/toto1310/Simple-Jenkins-DooD>){:target="_blank"} Last commit is done in 2019 and refer it for making the Dockerfile to use latest jenkins docker image

#### Sample Source Codes

- [Scripts for Jenkins in Docker](<https://github.com/coolwindjo/jenkins_scripts/tree/master_nvidia_dood>){:target="_blank"}

##### Dockerfile

```Dockerfile
ARG tag=${DOCKER_TAG:-lts}
FROM jenkins/jenkins:${tag}

# if we want to install via apt
USER root

# Install packages
RUN apt-get update && apt-get install -q -y --no-install-recommends \
	libltdl7 \
	apt-transport-https \
	ca-certificates curl gnupg2 \
	software-properties-common \
	tar \
	xz-utils \
	bash-completion \
	vim \
	python3 \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

# Add jenkins user to docker group to make sure jenkins user has docker privileges
# getent group docker | awk -F: '{printf "%d\n", $3}'
ARG dockerGid=1013
RUN echo "${dockerGid}"
RUN echo "docker:x:${dockerGid}:jenkins" >> /etc/group

# drop back to the regular jenkins user - good practice
USER jenkins

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugins < /usr/share/jenkins/ref/plugins.txt
```

##### Run Jenkins Docker

```bash
JENKINS_DATA=/var/jenkins_home

cd jenkins-nvidia-dood

sudo mkdir -p ${JENKINS_DATA}
sudo mkdir -p ${JENKINS_DATA}/out
sudo chown -R 1000.1000 ${JENKINS_DATA}

docker build -t jenkins-dood-image . && \
docker run \
	--name jenkins-dood-container \
	--rm \
	--detach \
	--publish 8080:8080 \
	--publish 50000:50000 \
	--volume $(which docker):/usr/bin/docker \
	--volume /var/run/docker.sock:/var/run/docker.sock \
	--volume ${JENKINS_DATA}:/var/jenkins_home \
	--volume ${JENKINS_DATA}/out:/var/jenkins_home/out \
	--volume /mnt/motional_database:/mnt/motional_database \
	--workdir=/var/jenkins_home \
	jenkins-dood-image
```

##### Stop Jenkins Docker

```bash
docker stop jenkins-dood-container && \
docker rmi jenkins-dood-image
```