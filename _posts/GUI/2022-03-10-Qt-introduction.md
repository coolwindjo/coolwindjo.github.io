---
layout: post
categories: GUI
tags: [qt, ]
---

## Reference Links

- [Qt for Beginners](<https://wiki.qt.io/Qt_for_Beginners>){:target="_blank"}


## Introduction to Qt

- Qt (pronounced as "cute", not "cu-tee") is a cross-platform framework that is usually used as a graphical toolkit, although it is also very helpful in creating CLI applications.

- Qt has an impressive collection of modules, including
  - **QtCore**, a base library that provides
    - containers,
    - thread management,
    - event management, and much more
  - **QtGui** and QtWidgets, a GUI toolkit for Desktop, that provides a lot of graphical components to design applications.
  - **QtNetwork**, that provides a useful set of classes to deal with network communications
  - **QtWebkit**, the webkit engine, that enable the use of web pages and web apps in a Qt application.
  - **QtSQL**, a full featured SQL RDBM abstraction layer extensible with own drivers, support for ODBC, SQLITE, MySQL and PostgreSQL is available out of the box
  - **QtXML**, support for simple XML parsing (SAX) and DOM
  - **QtXmlPatterns**, support for XSLT, XPath, XQuery and Schema validation

## Run the first Qt app. via Docker Container

### Scripts

  - run-qt5-container.sh

    ```shell
    xhost +local:docker
    docker build \
        -t qt5-image . && \
    docker run \
        --privileged \
        --rm \
        -it \
        --net=host \
        --name qt5-container \
        -e DISPLAY=$DISPLAY \
        -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
        -v /sandbox/workspace_qt5:/workspace \
        --workdir /workspace \
        qt5-image \
        /bin/bash
    ```

  - Dockerfile

    ```dockerfile
    FROM ubuntu:18.04

    # Install packages
    RUN apt-get update && apt-get install -q -y \
        --no-install-recommends \
        git wget \
        build-essential \
        perl \
        python \
        libgl-dev \
        && apt-get clean && rm -rf /var/lib/apt/lists/*

    RUN apt-get update && apt-get install -q -y \
        --no-install-recommends \
        qt5-default \
        qtcreator \
        && apt-get clean && rm -rf /var/lib/apt/lists/*

    #ENTRYPOINT [ "qtcreator" ]
    ```

### Create window

  - Let's start by creating our first project. It will be an empty project, so we have to proceed with: File > New file or project > Other Projects > Empty Qt Project
  ![image of the new project wizard]({{"https://qt-wiki-uploads.s3.amazonaws.com/images/thumb/0/0f/Beginners-01-NewProject.jpg/600px-Beginners-01-NewProject.jpg"}})

  - This is the project file (extension .pro). Qt uses a command line tool that parses these project files in order to generate "makefiles", files that are used by compilers to build an application. This tool is called qmake. But, we shouldn't bother too much about qmake, since Qt Creator will do the job for us.
    - TEMPLATE describes the type to build. It can be an application, a library, or simply subdirectories.
    - TARGET is the name of the app or the library.
    - QT is used to indicate what libraries (Qt modules) are being used in this project. Since our first app is a small GUI, we will need QtCore and QtGui.

    ```HelloWorld.pro
    TEMPLATE = app
    TARGET = name_of_the_app

    QT = core gui

    greaterThan(QT_MAJOR_VERSION, 4): QT += widgets
    ```


  - Let's now add the entry point of our application. Using File > New file or project > C++ > C++ Source file should do the job.
  ![image of the new file wizard]({{"https://qt-wiki-uploads.s3.amazonaws.com/images/thumb/3/3f/Beginners-03-NewFile.jpg/600px-Beginners-03-NewFile.jpg"}})

  - Follow the wizard once again, naming the file "main", and you are done. You will notice that in the project file, a new line has been added automatically by Qt Creator :

  ```HelloWord.pro
  TEMPLATE = app
  TARGET = name_of_the_app

  QT = core gui

  greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

  SOURCES +=  main.cpp
  ```

  ```main.cpp
  #include <QApplication>
  #include <QPushButton>

  int main(int argc, char **argv)
  {
    QApplication app (argc, argv);

    QPushButton button ("Hello world !");
    button.show();

    return app.exec();
  }
  ```

## How a Qt program is compiled

- Qt apps are compiled in 3 steps
  - A .pro file is written to describe the project to compile
  - A makefile is generated using qmake
  - The program is built using make (or nmake or jom on windows)

  ```sh
  cd HelloWorld
  mkdir -p ../build && cd ../build
  qmake ../HelloWorld/
  make
  ./hello_world_app
  ```

### Widgets

Qt objects have a lot of attributes that can be modified using getters and setters. In Qt, if an attribute is called foo, the associated getter and setter will have these signatures

```cpp
T foo() const;
void setFoo(const T);
```

In fact, Qt extends this system of attributes and getters and setters to something called property.

A property is a value of any type that can be accessed, be modified or constant, and can notify a change.

The property system is useful, especially in the third part (QML).

For now, we will use "attribute" or "property" to do the same thing.
- A QPushButton has plenty of properties :
  - text
  - font
    ```cpp
    QFont(const QString & family, int pointSize = –1, int weight = -1, bool italic = false)

    QFont font ("Courier");
    button.setFont(font);
    ```
  - icon
    ```cpp
    QIcon Qicon::fromTheme ( const QString &name, const QIcon &fallback = QIcon())

    QIcon icon ("/path/to/my/icon/icon.png");
    button.setIcon(icon);
    ```
  - tooltip
  ...

### Qt class hierarchy

@startuml
QObject <|-- QThread
QObject <|-- QWidget
QWidget <|-- QAbstractButton : a base class for all button types
QWidget <|-- QFrame : displays a frame
QWidget <|-- QProgressBar
QAbstractButton <|-- QCheckBox
QAbstractButton <|-- QPushButton
QAbstractButton <|-- QRadioButton
QFrame <|-- QAbstractScrollArea
QFrame <|-- QLabel : displays text or picture
QAbstractScrollArea <|-- QGrapihicsView
QAbstractScrollArea <|-- QTextEdit
hide members
@enduml

QObject is the most basic class in Qt. Most of classes in Qt inherit from this class. QObject provides some very powerful capabilities like:
- object name: you cans set a name, as a string, to an object and search for objects by names.
- parenting system
- signals and slots
- event management

Widgets are able to
- respond to events and
- use parenting system and signals and slots mechanism.

All widget inherit from QObject.

The most basic widget is the QWidget.
QWidget contains most properties that are used to describe a window, or a widget, like
- position and size,
- mouse cursor,
- tooltips, etc.

Remark: in Qt, a **widget** can also be a **window**.
In the previous section, we displayed a button that is a widget, but it appears directly as a window. There is no need for a "QWindow" class

This inheritance is done in order to facilitate properties management.
- Shared properties like size and cursors can be used on other graphical components, and
- QAbstractButton provides basic properties that are shared by all buttons.

### Parenting system

Parenting system is a convenient way of dealing with objects in Qt, especially widgets. Any object that inherits from QPObject can have a parent and children. This hierarchy tree makes many things convenient:
- When an object is destroyed, all of its children are destroyed as well. So calling delete becomes optional in certain cases.
- All QObjects have findChild and findChildren methods that can be used to search for children of a given object.
- Child widgets in a QWidget automatically appear inside the parent widget.

```cpp
#include <QApplication>
#include <QPushButton>

int main(int argc, char **argv)
{
 QApplication app (argc, argv);

 QPushButton button1 ("test");
 QPushButton button2 ("other", &button1);

 button1.show();

 return app.exec();
}
```
You can also note that when the application is closed, button1, which is allocated on the stack, is deallocated. Since button2 has button1 as a parent, it is deleted also.

You can even test this in Qt Creator in the analyze section, by searching for a memory leak — there won't be any.

There is clearly no benefit in putting a button inside a button, but based on this idea, we might want to put buttons inside a container, that does not display anything.

This container is simply the QWidget.

```cpp
#include <QApplication>
#include <QPushButton>

int main(int argc, char **argv)
{
 QApplication app (argc, argv);

 QWidget window;
 window.setFixedSize(100, 50);

 QPushButton *button = new QPushButton("Hello World", &window);
 button->setGeometry(10, 10, 80, 30);

 window.show();
 return app.exec();
}
```

Note that we create a fixed size widget (that acts as a window) using setFixedSize.

We also positioned the button using  setGeometry.

These method have the following signatures:
```cpp
void QWidget::setFixedSize(int width, int height)
void QWidget::setGeometry(int x, int y, int width, int height)
```

### Subclassing QWidget

We might want to split our code into different classes. What is often done is to create a class that is used to display a window, and implement all the widgets that are contained in this window as attributes of this class.

```cpp
#ifndef WINDOW_H
#define WINDOW_H

#include <QWidget>

class Window : public QWidget
{
 Q_OBJECT
 public:
  explicit Window(QWidget *parent = 0);

 signals:
 public slots:
};

#endif // WINDOW_H
```

```cpp
#include "window.h"

Window::Window(QWidget *parent) :
 QWidget(parent) {}
```

Qt Creator automatically generates a class template. Notice that there are some new elements in the header:
- The Q_OBJECT macro.
- A new category of methods:
  - signals
  - public slots

We can declare the size of the window, as well as the widgets that this window contains and their positions. For example, implementing the previous window that contains a button can be done in this way:

```cpp
#include <QApplication>
#include "window.h"

int main(int argc, char **argv)
{
 QApplication app (argc, argv);

 Window window;
 window.show();

 return app.exec();
}
```

```cpp
#ifndef WINDOW_H
#define WINDOW_H

#include <QWidget>

class QPushButton;
class Window : public QWidget
{
 public:
  explicit Window(QWidget *parent = 0);
 private:
 QPushButton *m_button;
};

#endif // WINDOW_H
```

```cpp
#include "window.h"
#include <QPushButton>

Window::Window(QWidget *parent) :
 QWidget(parent)
 {
 // Set size of the window
 setFixedSize(100, 50);

 // Create and position the button
 m_button = new QPushButton("Hello World", this);
 m_button->setGeometry(10, 10, 80, 30);
}
```

Please note that there is no need for writing a destructor for deleting m_button. With the parenting system, when the Window instance is out of the stack, the m_button is automatically deleted.
