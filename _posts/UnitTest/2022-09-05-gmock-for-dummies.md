---
layout: post
categories: UnitTest
tags: [gmock, dummy]
---

## Reference Links

- [Official GoogleTest - gMock for Dummies](<http://google.github.io/googletest/gmock_for_dummies.html>){:target="_blank"}


## gMock for Dummies

### What is gMock?

- When writing Prototype or test,
  - not feasible or
  - wise to rely on real objects entirely
- A mock object
  - implements the same interface as a real object (so it can be used as one)
  - but lets you specify at runtime how it will be used and what it should do
    - which methods will be called?
    - in which order?
    - how many times?
    - with what arguments?
    - what will be return? etc.
- fake objects <-> mock objects
  - Fakes and mocks actually mean very different things in TDD community:
    - **Fake** objects have working implementations,
      - but usually take some shortcut
        - which makes them not suitable for production.
    - **Mocks** are objects pre-programmed with expectations,
      - which form a specification of the calls they are expected to receive.
      - allows you to check the interaction between
        - mock itself and
        - code that uses it.
- gMock is a library (or "framework") for creating mock classes and using them.
- When using gMock
  1. use some simple macros to describe the interface you want to mock, and
    - they will expand to the implementation of your mock class
  2. create some mock objects and specify its expectations and behaviour using an intuitive syntax
  3. exercise code that uses the mock objects.
    - gMock will catch any violation to the expectations as soon as it arises

### Getting Started

#### A Case for Mock Turtles

- For testing a graphics program, you can compare the screen with a golden screen snapshot.
  - tests like this are expensive to run and fragile
- Dependency Injection
  - Inversion of control
    - IoC inverts the flow of control as compared to traditional control flow.
    - In IoC, custom-written portions of a computer program receive the flow of control from a generic framework.
  - The DI pattern ensures that an object or function which wants to use a given service should not have to know how to construct those services.

```cpp
class Turtle {
  ...
  virtual ~Turtle() {}
  virtual void PenUp() = 0;
  virtual void PenDown() = 0;
  virtual void Forward(int distance) = 0;
  virtual void Turn(int degrees) = 0;
  virtual void GoTo(int x, int y) = 0;
  virtual void GetX() = 0;
  virtual void GetY() = 0;
};
```

- Note that the destructor of Turtle must be virtual,
  - as is the case for all classes you intend to inherit from
  - otherwise the destructor for the derived class will not be called when you delete an object through a base pointer,
    - and you'll get corrupted program states like memory leaks.
- You can
  - control whether the turtle's movement will leave a trace using *PenUp()* and *PenDown()*, and
  - control its movement using *Forward()*, *Turn()*, and *GoTo()*
  - tell you the current turtle position with *GetX()*, *GetY()*
- Your program will normally use a real implementation of this interface.
  - In tests, you can use a mock implementation instead. This allows you to easily check
    - what drawing primitives your program is calling,
    - with what arguments, and
    - in which order.
  - Tests written this way are much more
    - robust,
    - easier to read and maintain,
    - and run much, much faster.

### Writing the Mock Class

- If you are lucky, the mocks you need to use have already been implemented.
- Otherwise, gMock turns this work into a fun game!

#### How to Define it

- Using the *Turtle* interface as example, follow these simple steps.
  - Derive a class *MockTurtle* from *Turtle*.
  - Take a *virtual* function of *Turtle*
    - (while it's possible to [mock non-virtual methods using templates](<http://google.github.io/googletest/gmock_cook_book.html#MockingNonVirtualMethods>){:target="_blank"}, it's much more involved.)
  - In the *public:* section of the child class, write *MOCK_METHOD();*
  - Now comes the fun part:
    - you take the function signature, cut-and-paste it into the macro, and
    - add two commas - one between the return type and the name, another between the name and the argument list.
  - If you're mocking a const method, add a 4th parameter containing *(const)* (the parentheses are required).
  - Since you're overriding a virtual method, we suggest adding the *override* keyword.
    - For const methods the 4th parameter becomes *(const, override)*,
    - for non-const methods just *(override)*.
    - (This isn't mandatory.)
  - Repeat until all virtual functions you want to mock are done.
    - (It goes without saying that all pure virtual methods in your abstract class must be either mocked or overridden.)
- After the process, you should have something like:

```cpp
#include "gmock/gmock.h"  // Brings in gMock

class MockTurtle : public Turtle {
  public:
    ...
    MOCK_METHOD(void, PenUp, (), (override));
    MOCK_METHOD(void, PenDown, (), (override));
    MOCK_METHOD(void, Forward, (int distance), (override));
    MOCK_METHOD(void, Turn, (int degrees), (override));
    MOCK_METHOD(void, GoTo, (int x, int y), (override));
    MOCK_METHOD(int, GetX, (), (const, override));
    MOCK_METHOD(int, GetY, (), (const, override));
};
```

- You don't need to define these mock methods somewhere else.
  - The *MOCK_METHED* macro will generate the definition for you.



### Setting Expectations

- The key to using a mock object successfully is to
  - set the right expectations on it.
    - If you set the expectations too strict,
      - your test will fail as the result of unrelated changes.
    - If you set them too loose, bugs can slip through.
  - You want to do it just right
    - such that your test can catch exactly the kind of bugs you intend it to catch.
- gMock provides the necessary means for you to do it "just right".

#### General Syntax

- In gMock we use the *EXPECT_CALL()* macro to set an expectation on a mock method.
- The general syntax is:

```cpp
EXPECT_CALL(mock_object, method(matchers))
  .Times(cardinality)
  .WillOnce(action)
  .WillRepeatedly(action);
```

- The macro has two arguments:
  - first the mock object,
  - and then the method and its arguments.
  - Note that the two are separated by a comma(,), not a period(.).

- If the method is not overloaded,
  - the macro can also be called without matchers:

```cpp
EXPECT_CALL(mock_object, non-overloaded-method)
  .Times(cardinality)
  .WillOnce(action)
  .WillRepeatedly(action);
```

- This syntax allows the test writer
  - to specify "called with any arguments" without explicitly specifying the number or types of arguments.
- To avoid unintended ambiguity,
  - this syntax may only be used for methods that are not overloaded.

- Either form of the macro
  - can be followed by some optional *clauses*
    - that provide more information about the expectation.

- This syntax is designed to make an expectation read like English.
  - For example, you can probably guess that

  ```cpp
  using ::testing::Return;
  ...
  EXPECT_CALL(turtle, GetX())
    .Times(5)
    .WillOnce(Return(100))
    .WillOnce(Return(150))
    .WillRepeatedly(Return(200));
  ```

  says that the *turtle* object's *GetX()* method will be called five times,
    - it will return 100 the first time,
    - 150 the second time,
    - and then 200 every time.
  - Some people like to call this style of syntax a Domain-Specific Language(DSL).

  > Note: Why do we use a macro to do this? Well it serves two purposes:
  > first it makes expectations easily identifiable (either by *grep* or by a human reader), and
  > second it allows gMock to include the source file location of a failed expectation in messages, making debugging easier.
