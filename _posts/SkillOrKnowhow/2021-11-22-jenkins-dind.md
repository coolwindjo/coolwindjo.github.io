---
layout: post
title: Jekins using Docker in Docker
categories: SkillOrKnowhow
tags: [jenkins, docker, dind]
---

## Reference Links

- Groovy
  - [Official Manaual - Pipeline & Groovy Snippet Generator](<https://www.jenkins.io/doc/book/pipeline/getting-started/#built-in-documentation>){:target="_blank"} Useful guide for writing pipeline syntax and groovy
  - [Official Manual - Groovy](<https://groovy-lang.org/>){:target="_blank"} Useful guide for writing groovy file to be loaded by Jenkinsfile
  - [Blog - Groovy Working with Lines in Strings](<https://blog.mrhaki.com/2009/11/groovy-goodness-working-with-lines-in.html>){:target="_blank"} When you want to write multiple lines of strings

## Sample Source Codes

- [Scripts for Jenkins in Docker](<https://github.com/coolwindjo/jenkins_scripts/tree/main/.devcontainer>){:target="_blank"} 

### Dockerfile

```dockerfile
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

### Run Jenkins Docker (for Docker in Docker)

```bash
JENKINS_DATA=${PWD}/../../../workspace/jenkins_home/data

docker network create jenkins

docker run \
	--name jenkins-dind \
	--rm \
	--detach \
	--privileged \
	--network jenkins \
	--network-alias docker \	# Makes the Docker in Docker container available as the hostname docker within the jenkins network.
	--env DOCKER_TLS_CERTDIR=/certs \	# Enables the use of TLS in the Docker server. Due to the use of a privileged container, this is recommended, though it requires the use of the shared volume described below. This environment variable controls the root directory where Docker TLS certificates are managed.
	--volume jenkins-dind-certs:/certs/client \
	--volume ${JENKINS_DATA}:/var/jenkins_home \
	--volume /mnt/motional_database:/mnt/motional_database \
	--publish 2376:2376 \	# ( Optional ) Exposes the Docker daemon port on the host machine. This is useful for executing docker commands on the host machine to control this inner Docker daemon.
	docker:dind \
	--storage-driver overlay2	# The storage driver for the Docker volume. See "Docker storage drivers" for supported options.
```

### Stop Jenkins Docker (for Docker in Docker)

```bash
docker stop jenkins-dind

docker network rm jenkins

docker volume rm jenkins-dind-certs
```


### Run Jenkins (installed) Container

```bash
JENKINS_DATA=${PWD}/../../../workspace/jenkins_home/data

sudo chown -R 1000.1000 ${JENKINS_DATA}

docker build -t jenkins-image . && \
docker run \
	--name jenkins-container \
	--rm \
	--detach \
	--network jenkins \		# Connects this container to the jenkins network defined in the earlier step. This makes the Docker daemon from the previous step available to this Jenkins container through the hostname docker.
	--env DOCKER_HOST=tcp://docker:2376 \	# 	Specifies the environment variables used by docker, docker-compose, and other Docker tools to connect to the Docker daemon from the previous step.
	--env DOCKER_CERT_PATH=/certs/client \
	--env DOCKER_TLS_VERIFY=1 \
	--publish 8081:8080 \
	--publish 50000:50000 \
	--volume ${JENKINS_DATA}:/var/jenkins_home \	# --volume $HOME/jenkins:/var/jenkins_home would map the container’s /var/jenkins_home directory to the jenkins subdirectory within the $HOME directory on your local machine, which would typically be /Users/<your-username>/jenkins or /home/<your-username>/jenkins. Note that if you change the source volume or directory for this, the volume from the docker:dind container above needs to be updated to match this.
	--volume jenkins-dind-certs:/certs/client \
	--volume /mnt/motional_database:/mnt/motional_database \
	--workdir=/var/jenkins_home \
	jenkins-image
```

### Stop Jenkins (installed) Container

```bash
docker stop jenkins-container

docker rmi jenkins-image
```

