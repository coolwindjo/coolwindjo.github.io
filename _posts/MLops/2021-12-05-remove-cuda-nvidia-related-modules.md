---
layout: post
title: How to remove Nvidia related modules like CUDA toolkit and driver
categories: MLops
tags: [nvidia, uninstall, cuda]
---

## Reference Links

- [Blog - RTX3090 Deep learning 실험환경 구축하기 (Korean)](<https://uhou.tistory.com/207>){:target="_blank"} Offering commands to uninstall Nvidia related modules like CUDA toolkit and driver

```bash

sudo apt-get --purge -y remove 'cuda*' && \
sudo apt-get --purge -y remove 'nvidia*' && \
sudo apt-get --purge -y remove 'libnvidia-*' && \
sudo apt-get --purge -y remove 'nsight-compute-*'
ls -al /usr/local/ | grep cuda-
dpkg -l | grep -i nvidia

```
