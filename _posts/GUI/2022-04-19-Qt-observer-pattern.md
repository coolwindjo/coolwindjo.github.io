---
layout: post
categories: GUI
tags: [qt, ]
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