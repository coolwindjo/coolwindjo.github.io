---
layout: post
title: ROS Basic Programming
categories: ROS
tags: [ros, lecture, mooc]
---

### ROS basics

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

### ROS Message Communications

- Overall Diagram

  ![Message Communication]({{ "/assets/images/posts/2020-12-17/message_comm.png" | relative_url }})

  - Topic
  - Service
  - Action
  - Parameter

#### ROS Package Creation

##### Create ROS Package for Topic Test

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
)

generate_messages(
DEPENDENCIES
std_msgs
)

catkin_package(
LIBRARIES ros_tutorials_topic_josh
CATKIN_DEPENDS roscpp std_msgs
)

###########
### Build ##
###########

include_directories(
${catkin_INCLUDE_DIRS}
)

add_executable(topic_publisher_josh src/topic_publisher.cpp)
add_executable(topic_subscriber_josh src/topic_subscriber.cpp)

add_dependencies(topic_publisher_josh ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})
add_dependencies(topic_subscriber_josh ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})

target_link_libraries(topic_publisher_josh
${catkin_LIBRARIES}
)
target_link_libraries(topic_subscriber_josh
${catkin_LIBRARIES}
)
```

##### Create ROS Package for Service Test

```terminal
cw
cd src
catkin_create_pkg ros_tutorials_service_josh message_generation std_msgs roscpp
```

```package.xml
<?xml version="1.0"?>
  <package format="2">
    <name>ros_tutorials_service_josh</name>
    <version>0.1.0</version>
    <description>The ros_tutorials_service_josh package</description>

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
project(ros_tutorials_service_josh)

find_package(catkin REQUIRED COMPONENTS
message_generation
roscpp
std_msgs
)

add_service_files(
FILES
SrvTutorial.srv
)

generate_messages(
DEPENDENCIES
std_msgs
)

catkin_package(
LIBRARIES ros_tutorials_topic_josh
CATKIN_DEPENDS roscpp std_msgs
)

###########
### Build ##
###########

include_directories(
${catkin_INCLUDE_DIRS}
)

add_executable(service_server_josh src/service_server.cpp)
add_executable(service_client_josh src/service_client.cpp)

add_dependencies(service_server_josh ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})
add_dependencies(service_client_josh ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})

target_link_libraries(service_server_josh
${catkin_LIBRARIES}
)
target_link_libraries(service_client_josh
${catkin_LIBRARIES}
)
```

#### Message File Creation

##### Create Message File for Topic Test

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

##### Create Launch File for Topic Test

```terminal
roscd ros_tutorials_topic_josh
mkdir launch
cd launch
vim union.launch
```

```union.launch
<launch>
  <group ns="ns1">
    <node pkg="ros_tutorials_topic_josh" type="topic_publisher_josh" name="topic_publisher"/>
    <node pkg="ros_tutorials_topic_josh" type="topic_subscriber_josh" name="topic_subscriber"/>
  </group>
  <group ns="ns2">
    <node pkg="ros_tutorials_topic_josh" type="topic_publisher_josh" name="topic_publisher"/>
    <node pkg="ros_tutorials_topic_josh" type="topic_subscriber_josh" name="topic_subscriber"/>
  </group>
</launch>
```

![roslaunch running diagram]({{ "/assets/images/posts/2020-12-17/roslaunch_group.png" | relative_url }})

| Launch Tag  | Description
| ----------- | -----------
| launch      | begin and end of the roslaunch statement
| node        | configure the node running specification, such as package, type, name
| machine     | configure the machine specification the node running on, such as machine name, address, ros-root, ros-package-path, etc.
| include     | include the other launch files from the same or different packages to be run as one launch file
| remap       | rename the ROS variables used in the running nodes, such as node's name, topic's name, etc.
| env         | set path and IP, etc. (hardly used)
| param       | set parameter's name, type, value, etc.
| rosparam    | check and modify parameters in the way how rosparam commands (load, dump, delete, etc.) do
| group       | make groups of nodes
| test        | test node running with additional specifications
| arg         | set or change the value of parameters

```example.launch
<launch>
  <arg name="update_period" default="10" />
  <param name="timing" value="$(arg update_period)" />
</launch>
```

```terminal
roslaunch my_package my_package.launch updaete_period:=30
```

##### Create Service File for Service Test

```terminal
roscd ros_tutorials_service_josh
mkdir srv
cd srv
vim SrvTutorial.srv
```

```SrvTutorial.srv
int64 a
int64 b
---
int64 result
```

- Messages are separated by "\-\-\-" into the set for request and the others for response.
- Message type can be not only time and int32, but also
  - built-in types: bool, int8, int16, float32, string, time, duration, etc.
  - common_msgs: common messages being used in ROS
  - [Message reference](<http://wiki.ros.org/msg>){:target="_blank"}

#### Source File Creation

##### Create Publisher and Subscriber Nodes for Topic Test

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
      ros::init(argc, argv, "topic_publisher_josh"); // 노드명 초기화
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
      ros::init(argc, argv, "topic_subscriber_josh"); // 노드명 초기화
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
##### Create Server and Client Nodes for Service Test

- Server Node Creation

  ```terminal
  roscd ros_tutorials_service_josh/src
  vim service_server.cpp
  ```

  ```service_server.cpp
  #include "ros/ros.h" // ROS 기본 헤더 파일
  #include "ros_tutorials_service_josh/SrvTutorial.h" // SrvTutorial 서비스 파일 헤더 (빌드후 자동 생성됨)

  // 서비스 요청이 있을 경우, 아래의 처리를 수행한다
  // 서비스 요청은 req, 서비스 응답은 res로 설정하였다
  bool calculation(ros_tutorials_service_josh::SrvTutorial::Request &req, ros_tutorials_service_josh::SrvTutorial::Response &res)
  {
      // 서비스 요청시 받은 a와 b 값을 더하여 서비스 응답 값에 저장한다
      res.result = req.a + req.b;

      // 서비스 요청에 사용된 a, b 값의 표시 및 서비스 응답에 해당되는 result 값을 출력한다
      ROS_INFO("request: x=%ld, y=%ld", (long int)req.a, (long int)req.b);
      ROS_INFO("sending back response: %ld", (long int)res.result);

      return true;
  }

  int main(int argc, char **argv) // 노드 메인 함수
  {
      ros::init(argc, argv, "service_server_josh"); // 노드명 초기화

      ros::NodeHandle nh; // 노드 핸들 선언

      // 서비스 서버 선언, ros_tutorials_service_josh 패키지의 SrvTutorial 서비스 파일을 이용한
      // 서비스 서버 ros_tutorials_service_server를 선언한다
      // 서비스명은 ros_tutorial_srv이며 서비스 요청이 있을 때,
      // calculation라는 함수를 실행하라는 설정이다
      ros::ServiceServer ros_tutorials_service_server = nh.advertiseService("ros_tutorial_srv", calculation);
      ROS_INFO("ready srv server!");
      ros::spin(); // 서비스 요청을 대기한다

      return 0;
  }
  ```

- Client Node Creation

  ```terminal
  roscd ros_tutorials_service_josh/src
  vim service_client.cpp
  ```

  ```service_client.cpp
  #include "ros/ros.h" // ROS 기본 헤더 파일
  #include "ros_tutorials_service_josh/SrvTutorial.h" // SrvTutorial 서비스 파일 헤더 (빌드후 자동 생성됨)
  #include <cstdlib> // atoll 함수 사용을 위한 라이브러리

  int main(int argc, char **argv) // 노드 메인 함수
  {
      ros::init(argc, argv, "service_client_josh"); // 노드명 초기화

      if (argc != 3) // 입력값 오류 처리
      {
          ROS_INFO("cmd : rosrun ros_tutorials_service_josh service_client_josh arg0 arg1");
          ROS_INFO("arg0: double number, arg1: double number");
          return 1;
      }

      ros::NodeHandle nh; // ROS 시스템과 통신을 위한 노드 핸들 선언

      // 서비스 클라이언트 선언, ros_tutorials_service_josh 패키지의 SrvTutorial 서비스 파일을 이용한
      // 서비스 클라이언트 ros_tutorials_service_client를 선언한다
      // 서비스명은 "ros_tutorial_srv"이다
      ros::ServiceClient ros_tutorials_service_client =
      nh.serviceClient<ros_tutorials_service_josh::SrvTutorial>("ros_tutorial_srv");

      // srv라는 이름으로 SrvTutorial 서비스 파일을 이용하는 서비스를 선언한다
      ros_tutorials_service_josh::SrvTutorial srv;

      // 서비스 요청 값으로 노드가 실행될 때 입력으로 사용된 매개변수를 각각의 a, b에 저장한다
      srv.request.a = atoll(argv[1]);
      srv.request.b = atoll(argv[2]);

      // 서비스를 요청하고, 요청이 받아들여졌을 경우, 응답 값을 표시한다
      if (ros_tutorials_service_client.call(srv))
      {
          ROS_INFO("send srv, srv.Request.a and b: %ld, %ld", (long int)srv.request.a, (long int)srv.request.b);
          ROS_INFO("receive srv, srv.Response.result: %ld", (long int)srv.response.result);
      }
      else
      {
          ROS_ERROR("Failed to call service ros_tutorial_srv");
          return 1;
      }
      return 0;
  }
  ```

##### Create Server and Client Nodes for Parameter Test

- Server Node Creation

  ```terminal
  roscd ros_tutorials_service_josh/src
  vim service_server.cpp
  ```

  ```service_server.cpp
  #include "ros/ros.h" // ROS 기본 헤더 파일
  #include "ros_tutorials_service_josh/SrvTutorial.h" // SrvTutorial 서비스 파일 헤더 (빌드후 자동 생성됨)

  // 서비스 요청이 있을 경우, 아래의 처리를 수행한다
  // 서비스 요청은 req, 서비스 응답은 res로 설정하였다
  bool calculation(ros_tutorials_service_josh::SrvTutorial::Request &req, ros_tutorials_service_josh::SrvTutorial::Response &res)
  {
      // 서비스 요청시 받은 a와 b 값을 파라미터 값에 따라 연산자를 달리한다.
      // 계산한 후 서비스 응답 값에 저장한다
      switch(g_operator)
      {
          case PLUS:
              res.result = req.a + req.b; break;
          case MINUS:
              res.result = req.a - req.b; break;
          case MULTIPLICATION:
              res.result = req.a * req.b; break;
          case DIVISION:
              if(req.b == 0){
                  res.result = 0; break;
              }
              else{
                  res.result = req.a / req.b; break;
              }
          default:
              res.result = req.a + req.b; break;
      }

      // 서비스 요청에 사용된 a, b 값의 표시 및 서비스 응답에 해당되는 result 값을 출력한다
      ROS_INFO("request: x=%ld, y=%ld", (long int)req.a, (long int)req.b);
      ROS_INFO("sending back response: %ld", (long int)res.result);

      return true;
  }

  int main(int argc, char **argv) // 노드 메인 함수
  {
      ros::init(argc, argv, "service_server_josh"); // 노드명 초기화

      ros::NodeHandle nh; // 노드 핸들 선언

      // 서비스 서버 선언, ros_tutorials_service_josh 패키지의 SrvTutorial 서비스 파일을 이용한
      // 서비스 서버 ros_tutorials_service_server를 선언한다
      // 서비스명은 ros_tutorial_srv이며 서비스 요청이 있을 때,
      // calculation라는 함수를 실행하라는 설정이다
      ros::ServiceServer ros_tutorials_service_server = nh.advertiseService("ros_tutorial_srv", calculation);
      ROS_INFO("ready srv server!");

      ros::Rate r(10); // 10 hz
      while (1)
      {
          nh.getParam("calculation_method", g_operator); // 연산자를 매개변수로부터 받은 값으로 변경한다
          ros::spinOnce(); // 콜백함수 처리루틴
          r.sleep(); // 루틴 반복을 위한 sleep 처리
      }

      return 0;
  }
  ```

- Client Node Creation

  ```terminal
  roscd ros_tutorials_service_josh/src
  vim service_client.cpp
  ```

  - Use the same file as the one in the Service Test

#### Build and Run the Sample Packages

```terminal
cm
```

##### Execute Publisher and Subscriber Nodes for Topic Test

```terminal
rosrun ros_tutorials_topic_josh topic_publisher_josh
```

```terminal
rosrun ros_tutorials_topic_josh topic_subscriber_josh
```

##### Execute Server and Client Nodes for Service Test

```terminal
$ rosrun ros_tutorials_service_josh service_server_josh
[ INFO] [1608540574.728446500]: ready srv server!
```

```terminal
$ rosrun ros_tutorials_service_josh service_client_josh 2 3
[ INFO] [1608540608.362758300]: send srv, srv.Request.a and b: 2, 3
[ INFO] [1608540608.364704800]: receive srv, srv.Response.result: 5
$ rosservice call /ros_tutorial_srv 10 2
result: 12
```

##### Execute Server and Client Nodes for Parameter Test

```terminal
$ rosrun ros_tutorials_service_josh service_server_josh
[ INFO] [1608540574.728446500]: ready srv server!
```

```terminal
$ rosparam list
/calculation_method
/rosdistro
/roslaunch/uris/host_localhost__42759
/rosversion
/run_id
$ rosservice call /ros_tutorial_srv 10 2
result: 12
$ rosparam set /calculation_method 3
$ rosservice call /ros_tutorial_srv 10 2
result: 20
```
