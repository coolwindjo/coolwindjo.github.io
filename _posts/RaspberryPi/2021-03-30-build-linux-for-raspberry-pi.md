---
layout: post
title: Linux Kernel Building for Raspberry Pi 4
categories: RaspberryPi
tags: [kernel, raspberrypi]
---

### Preparations

- [Raspberry Pi Development Setting](<https://itlearningcenter.tistory.com/entry/%EA%B0%9C%EB%B0%9C-%ED%99%98%EA%B2%BD-%EA%B5%AC%EC%84%B1%E2%91%A1?category=844869>){:target="_blank"} Get some snippets from the manual!


#### Repositories

```terminal

git clone https://github.com/kimdukyu/rpi4-uboot.git
git clone https://bitbucket.org/jayleekr0125/rpi-5.4.y.git

```

### Build a kernel, dtb, rootfs, etc.

- [Kernel Building for Raspberry Pi (Official)](<https://www.raspberrypi.org/documentation/linux/kernel/building.md>){:target="_blank"} Get some snippets from the manual!
- [Build a kernel using Build root](<https://itlearningcenter.tistory.com/entry/%E3%80%90RPI4%E3%80%91Buildroot%EB%A5%BC-%EC%82%AC%EC%9A%A9%ED%95%9C-%EB%A6%AC%EB%88%85%EC%8A%A4-%EA%B0%9C%EB%B0%9C-%ED%99%98%EA%B2%BD-%EA%B5%AC%EC%84%B1-%E2%91%A0>){:target="_blank"} Get some snippets from the manual!

#### Related Repositories

```terminal

git clone git://git.buildroot.net/buildroot

```


### Write on SD Card

- [Write the image on a SD Card](<https://itlearningcenter.tistory.com/entry/%E3%80%90RPI4%E3%80%91Linux-BSP-%EA%B0%9C%EB%B0%9C-%ED%99%98%EA%B2%BD-%EA%B5%AC%EC%84%B1-%E2%91%A0>){:target="_blank"} Get some snippets from the manual!

### Update the Image and dtb files

- [Build a kernel using kimdukyu git repositories](<https://itlearningcenter.tistory.com/entry/【RPI4】Linux-BSP-개발-환경-구성-②>){:target="_blank"} Get some snippets from the manual!

#### Related Repositories

```terminal

git clone https://github.com/kimdukyu/rpi4-toolchain.git
git clone https://github.com/kimdukyu/rpi4-kernel.git
git clone --depth=1 --branch=rpi-5.12.y https://github.com/raspberrypi/linux    # replaceable wth the rpi4-kernel

```


### Settings

#### WLAN setting

![WLAN setting]({{ "/assets/images/posts/2021-03-30/WLAN_setting.png" | relative_url }})
