---
layout: post
title: Title
categories: ROS
tags: [ros, lecture, mooc]
---
## ROS basics

- [Axis Orientation](<https://www.ros.org/reps/rep-0103.html#coordinate-frame-conventions>){:target="_blank"}

    ![Coordinate]({{ "/assets/images/posts/2020-12-17/coordinate.png" | relative_url }})
    - x: forward
    - y: left
    - z: upward

- [SI Unit](<https://www.ros.org/reps/rep-0103.html>){:target="_blank"}
  
  | Quantity    | Unit 
  | ----------- | ----
  | angle       | radian
  | length      | meter
  | mass        | kilogram
  | frequency   | hertz
  | force       | newton
  | power       | watt
  | voltage     | volt
  | current     | ampere
  | time        | second
  | temperature | celsius

- [Coding Style](<http://wiki.ros.org/CppStyleGuide>){:target="_blank"}

  | Object         | Naming Rule  | Example
  | -------------- | ------------ | -------
  | Package        | under_scored | first_ros_package
  | Topic, Service | under_scored | raw_image
  | File           | under_scored | turtlebot3_fake.cpp
  | Namespace      | under_scored | ros_awesome_package
  | Variable       | under_scored | string_table_name
  | Type           | CamelCased   | typedef int32_t PropertiesNumber
  | Class          | CamelCased   | class UrlTable
  | Structure      | CamelCased   | struct UrlTableProperties
  | Enumeration    | CamelCased   | enum ChoiceNumber
  | Function       | camelCased   | addTableEntry()
  | Method         | camelCased   | void setNumEntries(int32_t num_entries)
  | Constant       | ALL_CAPITALS | const uint8_t DAYS_IN_A_WEEK = 7;
  | Macro          | ALL_CAPITALS | #define PI_ROUNDED 3.0

- ROS Package Creation

  ```terminal
  cw
  cd src
  catkin_create_pkg ros_tutorials_topic_josh message_generation std_msgs roscpp
  ```

  ```package.xml
  <?xml version="1.0"?>
    <package format="2">
      <name>ros_tutorials_topic_josh</name>
      <version>0.1.0</version>
      <description>The ros_tutorials_topic_josh package</description>

      <maintainer email="coolwind@hotmail.co.kr">Jo, SeungHyeon</maintainer>

      <license>Apache 2.0</license>

      <author email="coolwind@hotmail.co.kr">Jo, SeungHyeon</author>

      <url type="website">http://www.robotis.com</url>
      <url type="repository">https://github.com/ROBOTIS-GIT/ros_tutorials.git</url>
      <url type="bugtracker">https://github.com/ROBOTIS-GIT/ros_tutorials/issues</url>

      <buildtool_depend>catkin</buildtool_depend>
      <depend>message_generation</depend>
      <depend>roscpp</depend>
      <depend>std_msgs</depend>

      <export>
      </export>
      </package>
  ```

  ```CMakeList.txt
  cmake_minimum_required(VERSION 2.8.3)
  project(ros_tutorials_topic_josh)

  find_package(catkin REQUIRED COMPONENTS
  message_generation
  roscpp
  std_msgs
  )

  add_message_files(
  FILES
  MsgTutorial.msg
  #  Message1.msg
  #  Message2.msg
  )

  generate_messages(
  DEPENDENCIES
  std_msgs
  )

  catkin_package(
  LIBRARIES ros_tutorials_topic_josh
  CATKIN_DEPENDS message_generation roscpp std_msgs
  )

  ###########
  ## Build ##
  ###########

  include_directories(
  ${catkin_INCLUDE_DIRS}
  )

  add_executable(topic_publisher src/topic_publisher.cpp)
  add_executable(topic_subscriber src/topic_subscriber.cpp)

  add_dependencies(topic_publisher ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})
  add_dependencies(topic_subscriber ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})

  target_link_libraries(topic_publisher
  ${catkin_LIBRARIES}
  )
  target_link_libraries(topic_subscriber
  ${catkin_LIBRARIES}
  )
  ```

- Message File Creation

  ```terminal
  roscd ros_tutorials_topic_josh
  mkdir msg
  cd msg
  vim MsgTutorial.msg
  ```

  ```MsgTutorial.msg
  time stamp
  int32 data
  ```
  - Message type can be not only time and int32, but also
    - built-in types: bool, int8, int16, float32, string, time, duration, etc.
    - common_msgs: common messages being used in ROS
    - [Message reference](<http://wiki.ros.org/msg>){:target="_blank"}

- Publisher Node Creation

  ```terminal
  roscd ros_tutorials_topic_josh/src
  vim topic_publisher.cpp
  ```

  ```topic_publisher.cpp
  #include "ros/ros.h" // ROS 기본 헤더파일
  #include "ros_tutorials_topic_josh/MsgTutorial.h"// MsgTutorial 메시지 파일 헤더(빌드 후 자동 생성됨)

  int main(int argc, char **argv) // 노드 메인 함수
  {
    ros::init(argc, argv, "topic_publisher"); // 노드명 초기화
    ros::NodeHandle nh; // ROS 시스템과 통신을 위한 노드 핸들 선언

    // 퍼블리셔 선언, ros_tutorials_topic_josh 패키지의 MsgTutorial 메시지 파일을 이용한
    // 퍼블리셔 ros_tutorial_pub 를 작성한다. 토픽명은 "ros_tutorial_msg" 이며,
    // 퍼블리셔 큐(queue) 사이즈를 100개로 설정한다는 것이다
    ros::Publisher ros_tutorial_pub = nh.advertise<ros_tutorials_topic_josh::MsgTutorial>("ros_tutorial_msg", 100);

    // 루프 주기를 설정한다. "10" 이라는 것은 10Hz를 말하는 것으로 0.1초 간격으로 반복된다
    ros::Rate loop_rate(10);

    // MsgTutorial 메시지 파일 형식으로 msg 라는 메시지를 선언
    ros_tutorials_topic_josh::MsgTutorial msg;

    // 메시지에 사용될 변수 선언
    int count = 0;
    while (ros::ok())
    {
      msg.stamp = ros::Time::now(); // 현재 시간을 msg의 하위 stamp 메시지에 담는다
      msg.data = count; // count라는 변수 값을 msg의 하위 data 메시지에 담는다
      ROS_INFO("send msg = %d", msg.stamp.sec); // stamp.sec 메시지를 표시한다
      ROS_INFO("send msg = %d", msg.stamp.nsec); // stamp.nsec 메시지를 표시한다
      ROS_INFO("send msg = %d", msg.data); // data 메시지를 표시한다
      ros_tutorial_pub.publish(msg); // 메시지를 발행한다
      loop_rate.sleep(); // 위에서 정한 루프 주기에 따라 슬립에 들어간다
      ++count; // count 변수 1씩 증가
    }
    return 0;
  }
  ```

- Subscriber Node Creation

  ```terminal
  roscd ros_tutorials_topic_josh/src
  vim topic_subscriber.cpp
  ```

  ```topic_subscriber.cpp
  #include "ros/ros.h" // ROS 기본 헤더파일
  #include "ros_tutorials_topic_josh/MsgTutorial.h"// MsgTutorial 메시지 파일 헤더(빌드 후 자동 생성됨)

  // 메시지 콜백 함수로써, 밑에서 설정한 ros_tutorial_msg라는 이름의 토픽
  // 메시지를 수신하였을 때 동작하는 함수이다
  // 입력 메시지로는 ros_tutorials_topic_josh 패키지의 MsgTutorial 메시지를 받도록 되어있다
  void msgCallback(const ros_tutorials_topic_josh::MsgTutorial::ConstPtr& msg)
  {
      ROS_INFO("recieve msg = %d", msg->stamp.sec); // stamp.sec 메시지를 표시한다
      ROS_INFO("recieve msg = %d", msg->stamp.nsec); // stamp.nsec 메시지를 표시한다
      ROS_INFO("recieve msg = %d", msg->data); // data 메시지를 표시한다
  }

  int main(int argc, char **argv) // 노드 메인 함수
  {
      ros::init(argc, argv, "topic_subscriber"); // 노드명 초기화
      ros::NodeHandle nh; // ROS 시스템과 통신을 위한 노드 핸들 선언

      // 서브스크라이버 선언, ros_tutorials_topic_josh 패키지의 MsgTutorial 메시지 파일을 이용한
      // 서브스크라이버 ros_tutorial_sub 를 작성한다. 토픽명은 "ros_tutorial_msg" 이며,
      // 서브스크라이버 큐(queue) 사이즈를 100개로 설정한다는 것이다
      ros::Subscriber ros_tutorial_sub = nh.subscribe("ros_tutorial_msg", 100, msgCallback);

      // 콜백함수 호출을 위한 함수로써, 메시지가 수신되기를 대기,
      // 수신되었을 경우 콜백함수를 실행한다
      ros::spin();
      return 0;
  }
  ```

- Build the Sample Package

  ```terminal
  cm
  rosrun ros_tutorials_topic_josh topic_publisher
  rosrun ros_tutorials_topic_josh topic_subscriber

  ```

- ROS Message Communication

    ![Message Communication]({{ "/assets/images/posts/2020-12-17/message_comm.png" | relative_url }})

    - Topic
    - Service
    - Action
    - Parameter