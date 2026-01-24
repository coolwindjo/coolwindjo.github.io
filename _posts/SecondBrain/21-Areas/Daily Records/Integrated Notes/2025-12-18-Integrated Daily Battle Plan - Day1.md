---
layout: post
title: Integrated Daily Battle Plan - Day1 Cheatsheet
categories: Programming
status: published
tags:
---
2025-12-18 17:55

Tags: [[_Integrated Daily Battle Plan]], [[study]]

## **Engineering Tech Cheat Sheet: Advanced C++ & Robotics Architecture**

---
### 1. Advanced Memory Management (Smart Pointers)

#### A. Internal Structure & Performance

- **Structure:** `std::shared_ptr<T>` contains **Two Pointers**:
    
    1. **Managed Object Pointer:** Points to data (`T*`).
        
    2. **Control Block Pointer:** Points to metadata on **Heap**.
        
- **Control Block:** Contains `Strong Ref Count`, `Weak Ref Count`, Custom Deleter.
    
    - **Atomic Operations:** `Ref Count` increments/decrements use atomic hardware instructions (`lock xadd`).
        
    - **Cost:** Atomic ops cause **CPU Cache Line Locking/Flush**. Expensive in high-frequency loops (e.g., 100Hz LiDAR callback).

> To visually clarify item 1.A of your Cheat Sheet (the `std::shared_ptr` structure), we are providing a diagram. You should be able to draw this on a whiteboard during an interview.
        

#### B. `std::make_shared` vs `new` (The Trade-off)

|**Feature**|**std::shared_ptr<T>(new T())**|**std::make_shared<T>()**|
|---|---|---|
|**Allocations**|**2** (Object + Control Block separate)|**1** (Contiguous Block)|
|**Cache Locality**|Poor (Potential cache miss)|**Excellent** (Spatial Locality)|
|**Weak Ptr Trap**|Object memory released when Strong=0|**Memory Bloat Risk**|

- **⚠️ The Trap (Memory Bloat):** In `make_shared`, Control Block and Object are one memory chunk. Even if `Strong Count == 0`, **the ENTIRE memory (100MB LiDAR Data) is NOT released** until `Weak Count == 0`.
    
    - **Rule:** For large data with `weak_ptr` observers -> Use `new`.
        

#### C. Parameter Passing

- **Bad:** `void func(std::shared_ptr<T> p)` -> Calls copy ctor -> Atomic Inc/Dec -> **Performance Hit**.
    
- **Good:** `void func(const std::shared_ptr<T>& p)` -> No Ref Count change -> **Zero Overhead**.
    

---

### 2. System Architecture & Low-Latency Design

#### A. Zero-Copy vs. Socket Communication

- **The Problem (Socket/TCPROS):** Even on localhost, data travels: `User Space` -> `Kernel Space` -> `User Space`. (Requires **Serialization** + **4 Data Copies**).
    
- **The Solution (Shared Memory):** `mmap` same physical RAM to virtual address space of multiple processes. (**0 Copies**).
    

#### B. The Virtual Memory Trap

- **Scenario:** Sending `std::vector` or pointers via Shared Memory.
    
- **Failure:** `0x1234` in Process A ≠ `0x1234` in Process B. Pointers become invalid (Segfault).
    
- **Fix:** Use **Relative Pointers** (Offset based) or Fixed-size structures (Flattened Data).
    

#### C. Serialization Strategy

- **JSON:** Human readable, but **Heavy parsing** & **Large payload**. (Use for Configs only).
    
- **Protobuf / FlatBuffers:**
    
    - **Schema Evolution:** Tag-based fields allow adding/removing fields without breaking legacy receivers (**Forward/Backward Compatibility**).
        
    - **Performance:** Binary format, smaller size. FlatBuffers allows access without unpacking (Zero-copy read).
        

---

### 3. C++ Design Patterns (Safety-Critical)

#### A. Singleton (Static Initialization Fiasco)

- **Danger:** Global variables in different `.cpp` files have **undefined initialization order**.
    
- **Fix (Meyers' Singleton):** Use `static` local variable inside a function. Guaranteed to initialize on first call.
    
    ```cpp
    static Config& getInstance() {
        static Config instance; // Lazy Init + Thread-Safe (C++11+)
        return instance;
    }
    ```
    

#### B. PIMPL (Pointer to Implementation)

- **Goal:** Break compilation dependency (reduce build time) & ABI stability.
    
- **Implementation:**
    
    - **Header:** `std::unique_ptr<Impl> pImpl;` + Forward Declaration.
        
    - **Cpp:** Define `struct Impl { headers... }`.
        
- **Critical Detail:** Destructor `~Class()` **must be defined in .cpp**. (Compiler needs `sizeof(Impl)` to generate delete code).
    

---

### 4. Concurrency & Multi-threading

#### A. `std::async` Trap

- **Issue:** Default policy allows `deferred` execution (runs serially on main thread when `.get()` is called).
    
- **Fix:** Always force new thread: `std::async(std::launch::async, ...)`
    

#### B. Race Conditions

- **Shared Ptr:** Ref Count is thread-safe, but **Managed Object is NOT**.
    
    - Simultaneous `read` & `write` to the _same_ `shared_ptr` global instance requires `std::mutex`.
        

---

### 5. JavaScript Internals (for C++ Mindset)

#### A. Scope & Memory

- **Hoisting:** Variable declarations move to top. `var` = garbage init, `let/const` = RAII-like safety (TDZ).
    
- **Closure Trap:** `var` in loops shares one memory address. Use `let` for block scoping.
    

#### B. Event Loop Priority

1. **Call Stack** (Synchronous)
    
2. **Microtask Queue** (`Promise`, `process.nextTick`) -> High Priority (ISR-like).
    
3. **Macrotask Queue** (`setTimeout`, I/O) -> Low Priority.
    

---

### 6. Suggested Action Items

1. **Build a Sandbox:** Create a `cpp_experiments` repo.
    
2. **Verify `make_shared` Bloat:** Write a test allocating 100MB, holding a `weak_ptr`, and checking RAM usage (RSS) via `top`.
    
3. **Implement PIMPL:** Refactor one of your heavy classes to use PIMPL and measure compile time difference.
    

---
