---
layout: post
categories: GUI
tags: [qt, memory-management, copy-on-write, shared-data]
---

## Reference Links

- [Qt - Implicit Sharing](<https://doc.qt.io/qt-6/implicit-sharing.html>){:target="_blank"}
- [Qt - Implicit Sharing iterator problem](<https://doc.qt.io/qt-6/containers.html#implicit-sharing-iterator-problem>){:target="_blank"}
- [Qt - Threads and Implicitly Shared Classes](<https://doc.qt.io/qt-6/threads-modules.html#threads-and-implicitly-shared-classes>){:target="_blank"}
- [Qt - QSharedData](<https://doc.qt.io/qt-6/qshareddata.html>){:target="_blank"}
- [Qt - QSharedDataPointer](<https://doc.qt.io/qt-6/qshareddatapointer.html>){:target="_blank"}

## Implicit Sharing

- Many C++ classes in Qt use implicit data sharing to
  - maximize resource usage and
  - minimize copying.
- Implicitly shared classes are both safe and efficient when passed as arguments,
  - because only a pointer to the data is passed around, and
  - the data is copied only if and when a function writes to it,
    - i.e., copy-on-write

### Overview

- A shared class consists of
  - a pointer to a shared data block that contains
    - a reference count and the data.
- When a shared object is created, it sets the reference count to 1.
  - The reference count is
    - incremented whenever a new object references the shared data,
    - decremented when the object dereferences the shared data.
      - The shared data is deleted when the reference count becomes zero.
- When dealing with shared objects, there are two ways of copying an object.
  - We usually speak about deep and shallow copies.
    - A deep copy implies duplicating and an object.
    - A shallow copy is a reference copy,
      - i.e. just a pointer to a shared data block.
  - Making a deep copy can be expensive in terms of memory and CPU.
  - Making a shallow copy is very fast, because it only involves setting a pointer and incrementing the reference count.
- Object assignment (with operator=()) for implicitly shared objects is implemented using shallow copies.
- The benefit of sharing is that a program does not need to duplicate data unnecessarily,
  - which results in lower memory use and less copying of data.
    - Objects can easily be assigned,
      - sent as function arguments, and
      - returned from functions.
- Implicit sharing mostly takes place behind the scenes; the programmer rarely needs to worry about it.
  - However, Qt's container iterators have different behaviour than those from the STL. Read **Qt - Implicit Sharing iterator problem**.
- In multithreaded applications implicit sharing takes place, as explained in **Qt - Threads and Implicitly Shared Classes**.
- When implementing your own implicitly shared classes, use the **QSharedData**, and **QSharedDataPointer** classes.

### Implicit Sharing in Detail

- Copy-On-Write or Value semantics
  - Implicit sharing automatically detaches the object from a shared block
    - if the object is about to change and the reference count is greater than one.
  - An implicitly shared class has control of its internal data.
    - In any member functions that modify its data,
      - it automatically detaches before modifying the data.
  - **Qt - Implicit Sharing iterator problem** is the special case.

- The [QPen](<https://doc.qt.io/qt-6/qpen.html>){:target="_blank"} class, which uses implicit sharing, detaches from the shared data in all member functions that change the internal data.

```cpp
void QPen::setStyle(Qt::PenStyle style)
{
  detach();         // detach from common data
  d-style = style;  // set the style member
}

void QPen::detach()
{
  if (d->ref != 1) {
    ...             // perform a deep copy
  }
}
```

### List of Classes

- The classes listed below automatically detach from common data if an object is about to be changed.
  - The programmer will not even notice that the objects are shared.
  - Thus you should treat separated instances of them as separate objects.
    - They will always behave as separate objects
      - but with the added benefit of sharing data whenever possible.
  - For this reason, you can pass instances of these classes as arguments to functions by value without concern for the copying overhead.

```cpp
QPixmap p1, p2;
p1.load("image.bmp");
p2 = p1;                      // p1 and p2 share data

QPainter paint;
paint.begin(&p2);             // cuts p2 loose from p1
paint.drawText(0, 50, "Hi");
paint.end();
```

- In this example, *p1* and *p2* share data until [QPainter::begin()](<https://doc.qt.io/qt-6/qpainter.html#begin>){:target="_blank"} is called for *p2*. because painting a pixmap will modify it.
 > Warning: Be careful with copying an implicitly shared container([QMap](<https://doc.qt.io/qt-6/qmap.html>){:target="_blank"}, [QList](<https://doc.qt.io/qt-6/qlist.html>){:target="_blank"}, etc.) while you use [STL-style iterator](<https://doc.qt.io/qt-6/containers.html#stl-style-iterators>){:target="_blank"}. See [Implicit sharing iterator problem](<https://doc.qt.io/qt-6/containers.html#implicit-sharing-iterator-problem>){:target="_blank"}.
