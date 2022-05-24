---
layout: post
categories: GUI
tags: [qt, observer-pattern, signal, slot]
---

## Reference Links

- [Qt for Beginners](<https://wiki.qt.io/Qt_for_Beginners>){:target="_blank"}

## The observer pattern

- Nearly all UI toolkits have a mechanism to detect an user action, and respond to this action.
  - Some of them use callbacks, other use listeners, but basically, all of them are inspired by the observer pattern.
  - Observer pattern is used when an observable object wants to notify other observers objects about a state change.
    - An user has clicked on a button -> a menu should be displayed
    - A web page just finished loading -> a process should extract some information from this loaded page.
    - An user is scrolling through a list of items(in an app store for example) -> reached the end, so other items should be loaded
  - Observer pattern is used everywhere in GUI applications,
    - And often leads to some boilerplate code (duplicate code).
      - Qt was created with the idea of removing this boilerplate code and providing a nice and clean syntax,
      - And the signal and slots mechanism is the answer.

## Signals and slots

- Instead of having observable objects and observers, and registering them, Qt provides two high level concepts: **signals** and **slots**.
  - A **signal** is a message
    - that object can send
    - most of the time to inform of a status change
  - A **slots** is a function (handler?)
    - that is used to accept and respond to a signal
- Examples from [QPushButton](<https://doc.qt.io/qt-5/qpushbutton.html>){:target="_blank"} class.
  - Signals
    - `clicked` (pressed & released)
    - `pressed`
    - `released`
  - Slots
    - `QApplication::quit`
    - `QWidget::setEnabled`
    - `QPushButton::setText`
- In order to respond to a signal, a **slot** must be *connected* to a **signal**.
  - Qt provides the method QObject::**connect**.
    - It is used this way, with the two macros `SIGNAL` and `SLOT`

    ```cpp
    FooObjectA *fooA = new FooObjectA();
    FooObjectB *fooB = new FooObjectB();

    QObject::connect(fooA, SIGNAL (bared()), fooB, SLOT (baz()));
    ```
    - assuming that `FooObjectA` have a `bared` signal, and `FooObjectB` have a `baz` slot.
      - write signature of the signal and the slot inside the two macros *SIGNAL* and *SLOT*.
    - **Remark**: Basically, *signal*s and *slot*s are methods, that might or might not have arguments,
      - but that never return anything.
    - While the notion of a *signal* as a method is unusual,
      - a *slot* is actually a real method, and can be called as usual in other methods, or whilst responding to a *signal*.

## Transmitting information

- The *signal*s and *slot*s mechanism is useful to respond to buttons clicks, but it can do much more than that.
  - For example, it can also be used to communicate information.
    - While playing song,
      - a progress bar is needed to show how much time remains before the song is over.
      - A media player might have a class that is used to check the progress of the media.
        - An instance of this class might periodically send a *tick* signal, with the progress value.
          This *signal* can be connected to a  [QProgressBar](<https://doc.qt.io/qt-5/qprogressbar.html>){:target="_blank"}, that can be used to display the progress.
        - The hypothetical class used to check the progress might have a *signal* that have this signature:
          ```cpp
          void MediaProgressManager::tick(int ms);
          ```
        - and we know from the documentation, that the [QProgressBar](<https://doc.qt.io/qt-5/qprogressbar.html>){:target="_blank"} has this slot:
          ```cpp
          void QProressBar::setValue(int value);
          ```
        - You can see that the *signal* and the *slot* have the same kind of parameters, especially the *type* **int**.
          - If you connect a *signal* to a *slot* that does not share the same kind of parameters, when the connection is done (at run-time) you will get a warning like:
          > QObject::connect: Incompatible sender/receiver arguments
          - This is because the *signal* transmits the information to the *slot* using the parameters.
          - The first parameter of the *signal* is passed to the first one of the *slot*, and the same for second, third, and so forth.
        - The code for the connection will look like this:
          ```cpp
          MediaProgressManager *manager = new MediaProgressManager();
          QProgressBar *progress = new QProgressBar(window);

          QObject::connect(manager, SIGNAL (tick(int)), progress, SLOT (setValue(int)) );
          ```
          - You can see that you have to provide a signature inside the *SIGNAL* and *SLOT* macro, providing the type of values that are passed through the *signal*s.
            - You may also provide the name of the variable if you want. (It is actually even better).

## Feature of signals and slots

- A *signal* can be connected to several *slots*
- Many *signals* can be connected to a *slot*
- A *signal* can be connected to a *signal*:
  - it is *signal* relaying.
  - The second is sent if the first *signal* is sent

## Examples

- Responding to an event
  - [QPushButton](<https://doc.qt.io/qt-5/qpushbutton.html>){:target="_blank"} provides the *clicked* signal.
  - [QApplication](<https://doc.qt.io/qt-5/qapplication.html>){:target="_blank"} provides the *quit* slot, that closes the application.
  - In order to make a click on a button close the app, we have to connect the signal *clicked* of the button to the *quit* slot of QApplication instance.
  - How to access to the QApplication instance while you are in another class.
    - There exists a static function in [QApplication](<https://doc.qt.io/qt-5/qapplication.html>){:target="_blank"}, with the following signature, that is used to get it:
    ```cpp
    QApplication * QApplication::instance()
    ```
    - This leads to the following modification of our previous code:
    ```window.cpp
    #include "window.h"

    #include <QApplication>
    #include <QPushButton>

    Window::Window(QWidget *parent) : QWidget(parent)
    {
      // Set size of the window
      setFixedSize(100, 50);

      // Create and position the button
      m_button = new QPushButton("Hello World", this);
      m_button->setGeometry(10, 10, 80, 30);

      // New : Do the connection
      connect(m_button, SIGNAL (clicked()), QApplication::instance(), SLOT (quit()) );
    }
    ```
    - While clicking on the button inside of the window, the application should quit.

## Transmitting information with signals and slots

- Simpler example for information transmission.
  - Only displays a progress bar and a slider (created by [QSlider](<http://doc.qt.io/qt-5/qslider.html#>){:target="_blank"}) inside a window, and while the slider is moved, the value of the progress bar is synced with a very simple connection.
  ```cpp
  void QSlider::valueChanged(int value);
  void QProgressBar::setValue(int value);
  ```
  - QSlider automatically emits the signal `valueChanged` with the new value passed as a parameter when the value is changed, and the method `setValue` of QProgressBar, is used to set the value of the progress bar.
  ```cpp
  #include <QApplication>
  #include <QProgressBar>
  #include <QSlider>

  int main(int argc, char **argv) {
    QApplication app(argc, argv);

    // Create a container window
    Window window;
    window.setFixedSize(200, 140);

    // Create a progress bar
    // with the range between 0 and 100, and a starting value of 0
    QProgressBar* progressBar = new QProgressBar(&window);
    progressBar->setRange(0, 100);
    progressBar->setValue(0);
    progressBar->setGeometry(10, 50, 180, 30);

    // Create a horizontal slider
    // with the range between 0 and 100, and a starting value of 0
    QSlider* slider = new QSlider(&window);
    slider->setOrientation(Qt::Horizontal);
    slider->setRange(0, 100);
    slider->setValue(0);
    slider->setGeometry(10, 90, 180, 30);

    window.show();

    // Connection
    // This connection set the value of the progress bar
    // while the slider's value changes
    QObject::connect( slider, SIGNAL (valueChanged(int)), progressBar, SLOT (setValue(int)) );

    return app.exec();
  }
  ```