---
layout: post
title: ROS - ROBOTIS Lecture 1, 2, 4 (with Links)
categories: ROS
tags: [ros, lecture, mooc, robotis]
---

### ROS References

- [ROS Robotis Lecture](<https://www.youtube.com/playlist?list=PLRG6WP3c31_VIFtFAxSke2NG_DumVZPgw>){:target="_blank"} Youtube
  - [Material](<https://github.com/robotpilot/ros-seminar>){:target="_blank"} Github
- [ROS 한글책](<https://github.com/robotpilot/rosbook_kr>){:target="_blank"} Github
- [로열모](<https://www.facebook.com/groups/KoreanRobotics>){:target="_blank"} (로봇공학을 위한 열린모임) Facebook
- [ROS](<https://ros.org>){:target="_blank"} (Robot Operating System)
  - [ROS Wiki - Message](<https://wiki.ros.org/msg>){:target="_blank"}
  - [ROS Wiki - Common Messages](<https://wiki.ros.org/common_msgs>){:target="_blank"}
  - [ROS Wiki - Standard Messages](<https://wiki.ros.org/std_msgs>){:target="_blank"}
- [OPROS](<https://github.com/opros-wiki/OPRoS_v1.1_Components/wiki/Open-Platform-for-Robotic-Services>){:target="_blank"} (Open Platform for Robotic Services)
- [OpenRTM-aist](<https://www.openrtm.org/openrtm/>){:target="_blank"}
- [오로카](<https://cafe.naver.com/openrt/23862>){:target="_blank"} Naver Cafe

### Robotics OS 종류

![Image of Robotics OSes]({{ "/assets/images/posts/2020-10-08/robotis-lec-1_1.png" | relative_url }})

### Communication b/w Heterogeneous Multi-devices

![Image of communication b/w multi-devices]({{ "/assets/images/posts/2020-10-08/robotis-lec-1_3.png" | relative_url }})

### Structure of ROS

![Image of Structure of ROS]({{ "/assets/images/posts/2020-10-08/robotis-lec-1_4.png" | relative_url }})

### Features of ROS

1. Communication Function
    - Node 간 Data 통신을 제공
    - 통상적 Middleware로 지칭되는 Message 전달 Interface 지원
    - Message parsing
      - Robot 개발 시에 빈번히 사용되는 통신 System 제공
      - Capsulation 및 Code reuse 를 위한 Node 간 Message 전달 Interface
    - Message의 기록 및 재생
      - Node 간 송/수신되는 Data인 Message를 저장하고 필요시에 재사용가능
      - 저장된 Message를 기반으로 반복적인 실험 가능, Algorithm 개발에 용이함
    - Message 사용으로 인한 다양한 Programming 언어 사용 가능
      - Node 간의 Data 교환이 Message로 이루어지므로 각 Node는 서로 다른 언어로 작성 가능
    - 분산 매개 변수 System
      - System에서 사용되는 변수를 Global key value로 작성하여 공유 및 수정하여 실시간으로 반영 가능

2. Others for Robots

    - Standard Message Definition for Robot
      - Camera, IMU, Laser 등의 Sensor/Odometer, 경로 및 지도 등의 Navigation Data 등의 표준 Message를 정의 하여 Module화, 협업 작업을 유도, 효율성 향상
    - Robot Geometry library
      - Robot, Sensor 등의 상대적 좌표를 Tree화 하는 TF(TransForm) 제공
    - Robot Descriptive Language
      - Robot의 물리적 특성을 설명하느 XML 문서 기술
      - E.g. URDF
    - 진단 System
      - Robot의 Status를 한 눈에 파악할 수 있는 진단 System 제공
    - Sensing/Recognition
      - Sensor driver, Sensing/Recognition Level의 Library 제공
    - Navigation
      - Robot에서 많이 사용되는 Robot의 Pose(위치,자세) 추정, 지도상의 자기 위치 추정 Function 제ㅑ
      - 지도 작성에 필요한 SLAM, 작성된 지도 내에서 목적지를 찾아가는 Navigation Library를 제공
    - Manipulation
      - Robot Arm에 사용되는 IK, FK는 물론, 응용단의 Pick and Place를 지원하는 다양한 Manipulation Library 제공
      - GUI 형태의 Manipulation Tools 제공(MoveIt!)

3. Various development tools

    - Robot 개발에 필요한 다양한 개발 도구를 제공
    - Robot의 개발 효율성 향상
    - Command-Line Tools
      - GUI 없이 ROS에서 제공되는 명령어로만 로봇 Access 및 거의 모든 ROS 기능 소화
    - RViz
      - 강력한 3D 시각화 Tool 제공
      - Laser, Camera 등의 Sensor Data를 시각화
      - Robot 외형과  계획된 동작을 표현
    - RQT
      - Graphic Interface 개발을 위한 Qt 기반 Framework 제공
      - Node와 Node간 연결 정보 표시 (rqt_graph)
      - Encoder, 전압, 또는 시간이 지남에 따라  변화하는 숫자를 Plotting(rqt_plot)
      - Data를 Message 형태로 기록하고 재생(rqt_bag)
    - Gazebo
      - 3D Simulator
        - Physics Engine을 탑재, Robot, Sensor, 환경 Model 등을 지원
      - ROS와의 높은 호환성

### ROS Release Schedule과 Version 선택

- ROS Releases
  - 2020.05.23 - Noetic Ninjemys (LTS)
    - Noetic Ninjemys (EOL=May 2025)
  - 2018.05.23 - Melodic Morenia (LTS)
    - Melodic Morenia (EOL=May 2023)
  - 2017.05.23 - Lunar Loggerhead
    - Lunar Loggerhead (EOL=May, 2019)
  - 2016.05.23 - Kinetic Kame (LTS) 추천
    - Kinetic Kame (EOL=April, 2021)
  - 2015.05.23 - Jade Turtle
    - Jade Turtle (EOL=May, 2017)
  - 2014.07.22 - Indigo Igloo (LTS)
    - Indigo Igloo (EOL=April, 2019)
  - 2013.09.04 - Hydro Medusa
  - 2012.12.31 - Groovy Galapagos
  - 2012.04.23 - Fuerte Turtle
  - 2011.08.30 - Electric Emys
  - 2011.03.02 - Diamondback
  - 2010.08.02 - C Turtle
  - 2010.03.02 - Box Turtle
  - 2010.01.22 - ROS 1.0

- Version selection
  - Linux
    - 5년간 기술 지원되는 최신 LTS Version의 Ubuntu 선택
      - 2년마다 매년 4월 LTS Version Release, Release 3개월 이 후
        - 16.04, 18.04
  - ROS
    - 2년마다 매년 5월 LTS Version Release, Release 3개월 이 후
  - Gazebo
    - "gazebosim.org" 에서 ROS 호환성 정보 검토 후 사용
  - 2019년 상반기 시점 추천 버전
    - Ubuntu 16.04
    - ROS Kinetic Kame
    - Gazebo 7.x
