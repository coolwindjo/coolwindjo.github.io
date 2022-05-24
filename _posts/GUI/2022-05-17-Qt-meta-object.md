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

```

```window.cpp

```
