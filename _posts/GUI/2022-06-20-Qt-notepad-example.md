---
layout: post
categories: GUI
tags: [qt, notepad, qt-example]
---

## Reference Links

- [Qt Documentation - Notepad Example](<https://doc.qt.io/qt-6/qtwidgets-tutorials-notepad-example.html>){:target="_blank"}
- [Qt Source code - Notepad Example](<https://code.qt.io/cgit/qt/qtbase.git/tree/examples/widgets/tutorials/notepad>){:target="_blank"}
- [Building and Running an Example](<https://doc.qt.io/qtcreator/creator-build-example-application.html>){:target="_blank"}
- [Using Qt Creator](<https://doc.qt.io/qtcreator/index.html>){:target="_blank"}
- [Creating other kind of applications with Qt Creator](<https://doc.qt.io/qtcreator/creator-tutorials.html>){:target="_blank"}
- [QWindow and Dialog Widgets](<https://doc.qt.io/qt-6/application-windows.html>){:target="_blank"}
- [The Event System](<https://doc.qt.io/qt-6/eventsandfilters.html>){:target="_blank"}
- [Qt Designer Manual](<https://doc.qt.io/qt-6/qtdesigner-manual.html>){:target="_blank"}
- [Layout Management](<https://doc.qt.io/qt-6/layout.html>){:target="_blank"}
- [Widgets and Layouts](<https://doc.qt.io/qt-6/graphicsview.html#widgets-and-layouts>){:target="_blank"}
- [Layout Examples](<https://doc.qt.io/qt-6/layout.html#layout-examples>){:target="_blank"}
- [Qt Widget Gallery](<https://doc.qt.io/qt-6/gallery.html>){:target="_blank"}
- [Application Main Window](<https://doc.qt.io/qt-6/mainwindow.html>){:target="_blank"}
- [Main Window Examples](<https://doc.qt.io/qt-6/examples-mainwindow.html>){:target="_blank"}
- [Object Model](<https://doc.qt.io/qt-6/object.html>){:target="_blank"}
- [qmake Model](<https://doc.qt.io/qt-6/qmake-manual.html>){:target="_blank"}

## Goals

- We teach basic Qt knowledge by implementing a simple Notepad application using C++ and the [QtWidgets](<https://doc.qt.io/qt-6/qtwidgets-index.html>){:target="_blank"} module.
  - The application is a small text editor which allows you to...
    - create a text file,
    - save it,
    - print it,
    - or reopen and edit it again.
    - set the font to be used.

## Notepad Example

![notepad_example]({{"/assets/images/posts/2022-06-20/notepad_example.png"}})

### Running the example

- To run the example from [Qt Creator](<https://doc.qt.io/qtcreator/index.html>), open the Welcome mode and select the example from Examples.

### Creating the Notepad Project

- Setting up a new project in Qt Creator is aided by a wizard that guides you step-by-step through the project creation process.
  - The wizard prompts you to enter the settings needed for that particular type of project and creates the project for you.

![qtcreator_new_project]({{"/assets/images/posts/2022-06-20/qtc_new_project.png"}})
![qtcreator_new_project_cmake]({{"/assets/images/posts/2022-06-20/qtc_new_project_cmake.png"}})

- To create the Notepad project, select **File** > **New Project** >  **Application** > **Qt Widgets Application** > **Choose...**, and follow the instructions of the wizard.
- In the **Class Information** dialog, type *Notepad* as the class name and select **QMainWindow** as the base class.

![qtcreator_class_information]({{"/assets/images/posts/2022-06-20/qtc_class_info.png"}})

- The **Qt Widgets Application** wizard creates a project that contains a main source file and a set of files that specify a user interface (Notepad widget):

  | file name | description |
  |-|-|
  | CMakeLists.txt | the project file |
  | main.cpp | the main source file for the application |
  | notepad.cpp | the source file of the notepad class of the Notepad widget |
  | notepad.h | the header file of the notepad class for the Notepad widget |
  | notepad.ui | the UI form for the Notepad widget |

- The files come with the necessary boiler plate code for you to be able to build and run the project.

### Main Source File

- The wizard generates the following code in th main.cpp file:

```main.cpp
#include "notepad.h"    // 1.
#include <QApplication>

int main(int argc, char *argv[])    // 2.
{
    QApplication a(argc, argv);   // 3.
    Notepad w;    // 4.
    w.show();   // 5.
    return a.exec();    // 6.
}
```

1. Include the header files for the Notepad widget and [QApplication](<https://doc.qt.io/qt-6/qapplication.html>){:target="_blank"}.
2. Defines the main function that is the entry point for all C and C++ based applications.
3. Creates a [QApplication](<https://doc.qt.io/qt-6/qapplication.html>){:target="_blank"} object.
  - This object manages application-wide resources and is necessary to run any Qt program that uses Qt Widgets.
  - It constructs an application object with argc command line arguments run in argv.
    - (For GUI applications that do not use Qt Widgets, you can use [QGuiApplication](<https://doc.qt.io/qt-6/qguiapplication.html>){:target="_blank"} instead.)
4. Creates the Notepad object.
  - This is the object for which the wizard created the class and the UI file.
    - The UI contains visual elements that are called **widgets** in Qt.
      - Examples of widgets are
        - text edits,
        - scroll bars,
        - labels,
        - and radio buttons.
      - A widget can also be a container for other widgets;
        - a dialog
        - or a main application window,
5. Shows the Notepad widget on the screen in its own window.
  - Widgets can also function as containers.
    - e.g. [QMainWindow](<https://doc.qt.io/qt-6/qmainwindow.html>){:target="_blank"} which often contains several types of widgets.
      - Widgets are not visible by default;
      - the function [show()](<https://doc.qt.io/qt-6/qwidget.html#show>){:target="_blank"} makes the widget visible.
6. Makes the [QApplication](<https://doc.qt.io/qt-6/qapplication.html>){:target="_blank"} enter its event loop.
  - When a Qt application is running, events are generated and sent to the widgets of the application.
  - e.g. mouse presses and key strokes

### Designing a UI

- The wizard generates a UI definition in XML format: notepad.ui.
  - When you open the notepad.ui file in Qt Creator, it automatically opens in the integrated Qt Designer.
- When you build the application, Qt Creator launches the Qt [User Interface Compiler (uic)](<https://doc.qt.io/qt-6/uic.html>){:target="_blank"} that reads the .ui file and creates a corresponding C++ header file, ui_notepad.h.

### Using Qt Designer

- The wizard creates an application that uses a [QMainWindow](<https://doc.qt.io/qt-6/qmainwindow.html>){:target="_blank"}.
  - It has its own layout to which you can add
    - a menu bar,
    - dock widgets,
    - toolbars,
    - a status bar.
  - The center area can be occupied by any kind of widget.
    - The wizard places the Notepad widget there.
- To add widgets in Qt Designer:
  1. In the Qt Creator **Edit** mode, double-click the notepad.ui file in the **Projects** view to launch the file in the integrated Qt Designer.
  2. Drag and drop widgets Text Edit ([QTextEdit](<https://doc.qt.io/qt-6/qtextedit.html>){:target="_blank"}) to the form.
  3. Press **Ctrl+A** (or **Cmd+A**) to select the widgets and click **Lay out Vertically** (or press **Ctrl+L**) to apply a vertical layout ([QVBoxLayout](<https://doc.qt.io/qt-6/qvboxlayout.html>){:target="_blank"}).
  4. Press **Ctrl+S** (or **Cmd+S**) to save your changes.
- The UI now looks as follows in Qt Designer:

![qtcreator_qtdesigner_ui]({{"/assets/images/posts/2022-06-20/qtc_qtd_ui.png"}})

- You can view the generated XML file in the code editor:

```notepad.ui
<?xml version="1.0" encoding="UTF-8"?>    <!-- 1. -->
<ui version="4.0">    <!-- 2. -->
 <class>Notepad</class>
 <widget class="QMainWindow" name="Notepad">
  <property name="geometry">
   <rect>
    <x>0</x>
    <y>0</y>
    <width>800</width>
    <height>600</height>
   </rect>
  </property>
  <property name="windowTitle">
   <string>Notepad</string>
  </property>
  <widget class="QWidget" name="centralwidget"/>
  <widget class="QMenuBar" name="menubar">
   <property name="geometry">
    <rect>
     <x>0</x>
     <y>0</y>
     <width>800</width>
     <height>20</height>
    </rect>
   </property>
  </widget>
  <widget class="QStatusBar" name="statusbar"/>
 </widget>
 <resources/>
 <connections/>
</ui>
```

1. Contains the XML declaration, which specifies the XML version and character encoding used in the document:
2. The rest of the file specifies an **ui** element that defines a Notepad widget:

- The UI file is used together with the header and source file of the Notepad class.

### Notepad Header File

- The wizard generated a header file for the Notepad class that has the necessary #includes, a constructor, a destructor, and the Ui object.

```notepad.h
#ifndef NOTEPAD_H
#define NOTEPAD_H

#include <QMainWindow>    // 1.

QT_BEGIN_NAMESPACE
namespace Ui { class Notepad; }   / /2.
QT_END_NAMESPACE

class Notepad : public QMainWindow    // 3.
{
    Q_OBJECT

public:
    Notepad(QWidget *parent = nullptr);   // 4.
    ~Notepad();   // 5.

private:
    Ui::Notepad *ui;    // 6.
};
#endif // NOTEPAD_H
```

1. Includes [QMainWindow](<https://doc.qt.io/qt-6/qmainwindow.html>){:target="_blank"} that provides a main application window.
2. Declares the Notepad class in the Ui namespace, which is the standard namespace for the UI classes generated from .ui files by the uic tool.
3. The class declaration contains the Q_OBJECT macro. It must come first in the class definition, and declares our class as a [QObject](<https://doc.qt.io/qt-6/qobject.html>){:target="_blank"}.
  - Naturally, it must also inherit from **QObject**.
    - A **QObject** adds several abilities to a normal C++ class.
    - Notably, the class name and slot names can be queried at runtime.
    - It is also possible to query a slot's parameter types and invoke it.
4. Declares a constructor that has a default argument called **parent**.
  - The value nullptr indicates that the widget has no parent (it is a top-level widget).
5. Declares a virtual destructor to free the resources that were acquired by the object during its life-cycle.
  - According to the C++ naming convention, destructors have the same name as the class they are associated with, prefixed with a tilde(~).
  - In **QObject** , destructors are virtual to ensure that the destructors of derived classes are invoked properly when an object is deleted through a pointer-to-base-class.
6. Declares a member variable which is a pointer to the Notepad UI class.
  - A member variable is associated with a specific class, and accessible for all its methods.

### Notepad Source File

- The source file that the wizard generated for the Notepad class looks as follows:

```notepad.cpp
#include "notepad.h"    // 1.
#include "./ui_notepad.h"

Notepad::Notepad(QWidget *parent)   // 2.
    : QMainWindow(parent)   // 3.
    , ui(new Ui::Notepad)   // 4.
{
    ui->setupUi(this);    // 5.
}

Notepad::~Notepad()   // 6.
{
    delete ui;
}
```

1. Includes the Notepad class header file that was generated by the wizard and the UI header file that was generated by the **uic** tool.
2. Defines the Notepad constructor.
3. Calls the [QMainWindow](<https://doc.qt.io/qt-6/qmainwindow.html>){:target="_blank"} constructor, which is the base class for the Notepad class.
4. Creates the UI class instance and assigns it to the **ui** member.
5. Sets up the UI.
6. In the destructor, we delete the **ui**.

### Project File

- The wizard generates the following project file, **CMakeLists.txt**, for us.

```CMakeLists.txt
cmake_minimum_required(VERSION 3.5)

project(NotepadEx VERSION 0.1 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 Qt5 COMPONENTS Widgets REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Widgets REQUIRED)

set(PROJECT_SOURCES
        main.cpp
        notepad.cpp
        notepad.h
        notepad.ui
)

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(NotepadEx
        MANUAL_FINALIZATION
        ${PROJECT_SOURCES}
    )
# Define target properties for Android with Qt 6 as:
#    set_property(TARGET NotepadEx APPEND PROPERTY QT_ANDROID_PACKAGE_SOURCE_DIR
#                 ${CMAKE_CURRENT_SOURCE_DIR}/android)
# For more information, see https://doc.qt.io/qt-6/qt-add-executable.html#target-creation
else()
    if(ANDROID)
        add_library(NotepadEx SHARED
            ${PROJECT_SOURCES}
        )
# Define properties for Android with Qt 5 after find_package() calls as:
#    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
    else()
        add_executable(NotepadEx
            ${PROJECT_SOURCES}
        )
    endif()
endif()

target_link_libraries(NotepadEx PRIVATE Qt${QT_VERSION_MAJOR}::Widgets)

set_target_properties(NotepadEx PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

if(QT_VERSION_MAJOR EQUAL 6)
    qt_finalize_executable(NotepadEx)
endif()
```

- The project file specifies the source, header, and UI files included in the project.

### Adding User Interaction

![qtcreator_ui_type_here]({{"/assets/images/posts/2022-06-20/qtc_ui_type_here.png"}})

- To add functionality to the editor, we start by adding menu items and buttons on a toolbar.
- Click on "Type Here", and add the options New, Open, Save, Save as, Print and Exit.
  - This creates 5 lines in the Action Editor below.
  
