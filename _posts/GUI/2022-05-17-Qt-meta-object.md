---
layout: post
categories: GUI
tags: [qt, meta-object]
---

## Reference Links

- [Qt for Beginners](<https://wiki.qt.io/Qt_for_Beginners>){:target="_blank"}

## The Meta Object

- Qt provides a meta-object system.
  - Meta-object (literally "over the object") is a way to achieve some programming paradigms that are normally impossible to achieve with pure C++ like:
    - Introspection: capability of examining a type at run-time
    - Asynchronous function calls
  - To use such **Meta-object** capabilities in an application, one can subclass [QObject](<http://doc.qt.io/qt-5/qobject.html#>){:target="_blank"} and **mark** it so that the **meta-object compiler (moc)** can interpret and translate it.
  - Code produced by **moc** includes
    - signals and slots signatures,
    - methods that are used to retrieve meta-information from those **marked** classes, properties handling...
  - All this information can be accessed using the following method:
  ```cpp
  const QMetaObject * QObject::metaObject() const
  ```
- [QMetaObject](<http://doc.qt.io/qt-5/qmetaobject.html#>){:target="_blank"} class contains all the methods that deal with meta-objects.

## Important macros

- The most important macro is **Q_OBJECT**.
  - Signal-Slot connections and their syntax cannot be interpreted by a regular C++ compiler.
    - The **moc** is provided to translate the QT syntax like "connect", "signals", "slots", etc into regular C++ syntax.
    ```mywidget.h
    class MyWidget : public QWidget
    {
      Q_OBJECT
      public:
        MyWidget(QWidget *parent=nullptr);
    }
    ```
    - Others marker macros for **moc** are
      - **signals**
      - public / protected / private **slots**

      that mark the different methods that need to be extended.
    - **SIGNAL** and **SLOT** are also two very important and useful macros.
      - When a **signal** is emitted, the **meta-object** system is used to compare the signature of the **signal**, to check the connection, and to find the **slot** using it's signature.
      - These macros are actually used to convert the provided method signature into a string that matches the one stored in the **meta-object**.

## Creating custom signals and slots

- Creating custom **slots**
  - Slots are like normal methods, but with small decorations around,
- Creating custom **signals**
  - Signals need little to no implementation at all.
- Checklist:
  - add **Q_OBJECT** macro
  - add **signals** section, and write signals prototypes
  - add **public slots** or **protected slots** or **private slots** sections, and write slots prototypes
  - implement **slots** as normal methods
  - establish **connect**ions

### Creating custom slots

- In order to implement a slot, we first need to [make the class be able to send signals and have slots](<https://coolwindjo.github.io/gui/2022/04/19/Qt-observer-pattern.html>){:target="_blank"}.
- This is done by setting the **Q_OBJECT** macro in the class declaration (often in the header).
- After that, a **slot** should be declared in the corresponding section, and implemented as a normal method.
- Finally, **slots** are connected to **signals**.

### Creating signals

- As for slots, we first need to add the **Q_OBJECT** macro.
- **Signals** should also be declared in the *signals* section, and there is no need for them to be implemented.
- They are emitted using the emit keyword:
```cpp
emit mySignal();
```
- Note that in order to send signals that have parameters, you have to pass them in the signal emission:
```cpp
emit mySignal(firstParameter, secondParameter ...);
```

### Example

#### Creating custom slots

- Let's start with our window with the button:

```window.h
#ifndef WINDOW_H
#define WINDOW_H

#include <QWidget>

class QPushButton;
class Window : public QWidget
{
    Q_OBJECT
public:
    explicit Window(QWidget *parent = nullptr);
private slots:
    void slotButtonClicked(bool checked);
private:
    QPushButton* m_pButton;
signals:
};

#endif // WINDOW_H
```

```window.cpp
#include "window.h"

#include <QPushButton>

Window::Window(QWidget *parent) : QWidget(parent)
{
    // Set size of the window
    setFixedSize(100, 50);

    // Create and position the button
    m_pButton = new QPushButton("Hello World", this);
    m_pButton->setGeometry(10, 10, 80, 30);

    // New: Do the connection
    // connect(m_pButton, SIGNAL (clicked()), QApplication::instance(), SLOT (quit()));
    m_pButton->setCheckable(true);
    connect(m_pButton, SIGNAL (clicked(bool)), this, SLOT (slotButtonClicked(bool)));

}

void Window::slotButtonClicked(bool checked) {
  if (checked) {
    m_pButton->setText("Checked");
  } else {
    m_pButton->setText("Hello World");
  }
}
```

- New Button Action
  - can be checked
    - when checked, it displays "checked"
    - when unchecked, it restores "Hello World"
  ```cpp
  signals:
    void QPushButton::clicked(bool checked)
  private slots:
    void Window::slotButtonClicked(bool checked);
  ```
  - Implement private and protected slots by prefixing them with "slot"

#### Emitting custom signals

- New Button Action
  - close the app. after clicking 10 times
    - implement a counter that count the number of clicks

```window.h
class Window : public QWidget
{
    Q_OBJECT
public:
    explicit Window(QWidget *parent = nullptr);
signals:
    void counterReached();
private slots:
    void slotButtonClicked(bool checked);
private:
    QPushButton* m_pButton;
    int m_nCounter;
};
```
- add "signals" section in the header
  - Even if the signal is declared as a method, there is no need to implement it. The meta-compiler is used to do this.
  - Now we need to emit the signal when the counter reaches 10.

```window.cpp
#include <QPushButton>
#include <QApplication>

Window::Window(QWidget *parent) : QWidget(parent)
{
    // Set size of the window
    setFixedSize(100, 50);

    // Create and position the button
    m_pButton = new QPushButton("Hello World", this);
    m_pButton->setGeometry(10, 10, 80, 30);
    m_pButton->setCheckable(true);

    m_nCounter = 0;

    // New: Do the connection
    connect(m_pButton, SIGNAL (clicked(bool)), this, SLOT (slotButtonClicked(bool)));
    connect(this, SIGNAL (counterReached()), QApplication::instance(), SLOT (quit()));
}

void Window::slotButtonClicked(bool checked) {
  if (checked) {
    m_pButton->setText("Checked");
  } else {
    m_pButton->setText("Hello World");
  }

  m_nCounter++;
  if (m_nCounter == 10){
      emit counterReached();
  }
}
```
- We need t o write the keyword emit to send the signal.

### Troubleshooting

While compiling your program, especially when you are adding the macro Q_OBJECT, you might have this compilation error.

```bash
main.cpp:(.text._ZN6WindowD2Ev[_ZN6WindowD5Ev]+0x3): undefined reference to `vtable for Window'
```

This is because of the meta-object compiler not being run on a class that should have meta-object. You should rerun qmake, by doing Build > Run qmake.

### Widgets

#### QRadioButton

- Radio button is a standard GUI component being used to make a unique choice from a list.
- QRadioButton behaves just like QPushButton thanks to a nice inheritance.
- By default, QRadioButton are not grouped, therefore more than one of them can be checked at the same time. In order to have the "exclusive" behaviour of many radio buttons, we need to use QButtonGroup.
- QButtonGroup
  - Allocate a new button group
  - Attach it to the parent object
    - e.g.)
      - MainWindow
      - this
  ```cpp
  QButtonGroup* pButtonGroup = new QButtonGroup(object);
  // Add buttons in the button group
  pButtonGroup->addButton(button1);
  pButtonGroup->addButton(button2);
  pButtonGroup->addButton(button3);
  ```
