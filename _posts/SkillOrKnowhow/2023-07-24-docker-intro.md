---
layout: post
title: Understanding Docker Concepts
categories: SkillOrKnowhow
tags: [docker, getting-started,]
---

### Reference Links

- [Docker for Developers: Understanding the Core Concepts](<https://techcommunity.microsoft.com/t5/educator-developer-blog/docker-for-developers-understanding-the-core-concepts/ba-p/3872647>){:target="_blank"}
- [INTRODUCTION TO DOCKER FOR EMBEDDED SOFTWARE DEVELOPERS](<https://www.beningo.com/introduction-to-docker-for-embedded-software-developers/>){:target="_blank"}


### What Is Docker?

- The official definition: lightweight, open, and secure platform for shipping software.
- Simplifies the process of building applications, shipping them, and running them in various environments

#### Images and Containers

![Docker Image and Container](https://techcommunity.microsoft.com/t5/image/serverpage/image-id/488413iB8E4073C267649D6/image-size/large?v=v2&px=999)

- An image has the necessary files to run
  - operating system like Ubuntu or Windows
  - your application framework or
  - database, files that support the application,
  - environment variables,
  - security settings,
  - and more.

- CAD drawings or blueprints that dictate how the container’s contents will be organized.
  - These blueprints alone are not useful,
  - but they facilitate the creation of container instances and content organization.
  - This process is analogous to creating Docker images. you can build a container from it.

### Docker Containers versus Virtual Machines

![Docker Containers versus Virtual Machines](https://blog.codewithdan.com/wp-content/uploads/2022/03/image-3-1024x572.png)

- Each virtual machine contains a complete copy of the operating system, resulting in significant overhead in terms of storage and memory.
- Whether it’s Linux or Windows server. The host requires a container engine like Docker Engine to integrate the containers with the host OS

### Docker Benefits for Developers

- Expedite the setup of development environments.
- Eliminate application conflicts.
- Enables the seamless transfer of code and its entire environment across different environments, such as development, staging, and production.

#### Accelerating Developer Onboarding

- Setting up these components on individual developer machines, especially for remote team members, can be challenging.
  - It requires careful configuration, ensuring security, and managing version compatibility.
    - Docker simplifies this process by allowing the creation of one or more images that can be transformed into running containers.
    - These containers can then be deployed across different developer and designer machines.

#### Eliminating App Conflicts

- Each container can house a specific version of the framework, providing a conducive environment for multiple applications.
  - For instance, App 1, 2, and 3 can run smoothly in their respective containers, each targeting a different version of the framework.

#### Consistency Between Environments

- By ensuring that an application runs consistently across development, staging, and production, Docker eliminates many potential issues.

#### Shipping Software Faster

- As we transfer images between development, staging, and production environments and set up the corresponding containers, we can harness Docker’s advantages to expedite the software shipping process.

### Getting Started with Docker Commands

#### Using the docker Command

``` Terminal
docker
```

![Docker commands list](https://blog.codewithdan.com/wp-content/uploads/2023/06/image-1024x641.png)

##### Core Docker Commands

``` Terminal
# Pull the nginx:alpine image from Docker Hub
# (a place to store images) to your machine
docker pull nginx:alpine

# Build docker a docker image from a Dockerfile
docker build -t myImage:1.0 .

# List docker images on your machine
docker images

# Run a container on port 8080.
# Visit http://localhost:8080 to view it
docker run -d -p 8080:80 nginx:alpine

# List all running containers
docker ps

# List all containers
docker ps -a

# Stop a container
docker stop [containerId | containerName]

# Remove a container
docker rm [containerId | containerName]

# Remove an image
docker rmi [imageId]
```

##### Creating a Dockerfile

``` dockerfile
FROM        nginx:alpine
LABEL       author="Your Name"
WORKDIR     /usr/share/nginx/html
COPY        . /usr/share/nginx/html

# Could do "COPY . ." as well since working directory is set

EXPOSE      80
CMD         ["nginx", "-g", "daemon off;"]
```

- List of instructions that determines what goes into the container that will eventually run (code, security settings, configuration, framework, and more).


##### Building an Image

``` Terminal
docker build -t myCustomNginx:1.0 .
```

- -t is the tag to use which is myCustomNginx
- 1.0 represents the version of the image (it’s very important to version your images)
- . represents the path to the Dockerfile used to build the image. In this example it’s in the same directory where we’re running the “docker build” command.


##### Push a Custom Image to Docker Hub

``` Terminal
# Push the image to Docker Hub (the default registry)
docker push myCustomNginx:1.0
```

### DOCKERS USE IN EMBEDDED SOFTWARE DEVELOPMENT

- Portable container with their build environment
  - Ensures that every developer is working with the same tools and development environment
    - A new developer can come on board and be up and running nearly instantly by providing them access to the source code and the associated Docker file that is used to build the Docker image.
    - This can alleviate all those issues and discussions about software not building, having the right libraries, paths, and so forth.
- Build a DevOps pipeline that leverages their container to automate builds, testing, analytics, and deployment.
  - Automated DevOps is a very powerful concept and very valuable to any business that uses them successfully.
  - Most pipeline development requires some virtual machine or container that has the build and test environment installed.
  - Developers can leverage Docker to create this environment and use tools such as Jenkins and Gitlab to build out their DevOps system.


### Docker-in-docker and Docker-outof-docker

- Follow the post linked => [Docker in Docker and Docker out of Docker for Jenkins]({% link _posts/SkillOrKnowhow/2021-11-20-dind-and-dood-for-jenkins.md %}){:target="_blank"}
