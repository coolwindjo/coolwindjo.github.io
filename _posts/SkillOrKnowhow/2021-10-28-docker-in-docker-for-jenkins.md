---
layout: post
categories: SkillOrKnowhow
tags: [jenkins, docker]
---

## Reference Links

- [Blog - Docker Client - Server Arhitecture](<https://aidanbae.github.io/code/docker/docker-overview/>){:target="_blank"} Docker Client - Server Arhitecture
- [Blog - DinD vs. DooD (Korean)](<https://mns010.tistory.com/25>){:target="_blank"} Simple descriptions of DinD and DooD with refer to the nastybox blog
- [Blog - DinD vs DooD by NastyBox](<https://blog.nestybox.com/2019/09/14/dind.html>){:target="_blank"} Good explaination about DinD and DooD while introducing their own secure dind solution
- [Blog - DooD rather than DinD by jpetazzo](<https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/>){:target="_blank"} Most quoted blog that explains the drawbacks of Docker in Docker
- [Blog - DinD rather than DooD on K8s by applatix](<https://applatix.com/case-docker-docker-kubernetes-part/>){:target="_blank"} DinD can be better structure when you use kubernetes
- [Official Docs - Runtime privilege and Linux capabilities](<https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities>){:target="_blank"} Explains several options for running docker container


## Docker Client - Server Arhitecture

- Client (e.g. docker CLI) requests to the Docker Daemon (dockerd)
- Using belows for communication
  - RESTAPI
  - Unix Socket (in a local host)
  - TCP Socket (between remote machines)


## Docker in Docker

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

## Docker out of Docker

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