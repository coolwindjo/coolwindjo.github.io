---
layout: post
categories: GUI
tags: [qt, lecture, qt-example]
---

## Reference Links

- [YouTube Lecture: Qt 6 with C++ by Bryan Cairns](<https://www.youtube.com/watch?v=KugPAznC4Yo&list=PLUbFnGajtZlXbrbdlraCe3LMC_YH5abao&index=6>){:target="_blank"}
- [QObject](<https://doc.qt.io/qt-6/qobject.html>){:target="_blank"}.
- [Signals and Slots](<https://doc.qt.io/qt-6/signalsandslots.html>){:target="_blank"}.
- [meta-object system](<https://doc.qt.io/qt-6/metaobjects.html>){:target="_blank"}.
- [Understanding QObject in Qt by Bryan Cairns](<https://bcairns.medium.com/understanding-qobject-in-qt-97de374ca0cd>){:target="_blank"}.

## Qt Console Application

### What's going on under the hood

@startuml
skinparam activity {
  BackgroundColor<< MOC >> Red
}
"Source Code" --> Preprocessor
--> MOC <<MOC>>
--> Compiler
--> Linker
@enduml
