---
layout: post
title: Integrated Daily Battle Plan - Day3
subtitle:
categories: Programming
status: published
tags:
---
2025-12-21 11:34

Tags: [[_Integrated Daily Battle Plan]], [[study]]

# Tech Drill Master: Ultimate Field Manual

---

## I. The `noexcept` Contract & Move Semantics
> **Core Doctrine:** `noexcept` is not just a comment; it is a contract with the compiler that dictates runtime performance and binary size.

### 1. Mandatory Usage (The "Must-Haves")
* **Move Constructor & Assignment Operator:**
    * **Why:** `std::vector` (and other containers) use `std::move_if_noexcept` during reallocation/resizing.
    * **Consequence:** If missing, the container silently falls back to **Deep Copy** to maintain Strong Exception Guarantee. Performance collapses from $O(1)$ to $O(N)$ per element.
* **Destructors (`~T()`):**
    * **Why:** Throwing during stack unwinding (while another exception is active) causes `std::terminate()`.
    * **Default:** C++11 destructors are `noexcept(true)` by default.
* **Swap Functions:**
    * **Why:** STL algorithms rely on non-throwing swaps.

### 2. Under the Hood: The "Preparation Code"
* **Without `noexcept`:**
    * Compiler generates **Unwind Tables (`.eh_frame`)** and **LSDA (Language Specific Data Area)**.
    * Runtime overhead during exception search + Binary size bloat.
* **With `noexcept`:**
    * No unwind tables needed for that frame.
    * If an exception tries to escape, calls `std::terminate()` immediately.
    * **Result:** Smaller binary, faster execution (optimization barrier removed).

### 3. Advanced Idioms
* **Conditional `noexcept`:**
    ```cpp
    // "I am safe only if my internal operations are safe."
    void swap(T& a, T& b) noexcept(noexcept(a.swap(b)));
    ```
* **`std::move_if_noexcept` vs `std::move`:**
    * `std::move`: "Speed is king. I don't care about data safety." (Unconditional cast).
    * `std::move_if_noexcept`: "Safety first." (Moves only if `noexcept`, otherwise Copies). Use inside container internals.

---

## II. Smart Pointer Surgery
> **Core Doctrine:** Understand the memory layout. `shared_ptr` is not free.

### 1. `std::shared_ptr` Anatomy
* **Structure:**
    1.  **Managed Object Pointer:** Points to the data `T`.
    2.  **Control Block Pointer:** Points to heap metadata.
* **Control Block Contains:**
    * `Strong Ref Count` (Atomic, expensive).
    * `Weak Ref Count`.
    * `Deleter`.
    * `Allocator`.

### 2. `make_shared` vs `new`

| Feature            | `std::make_shared<T>()`                                 | `std::shared_ptr<T>(new T)`                    |
| :----------------- | :------------------------------------------------------ | :--------------------------------------------- |
| **Allocations**    | **1** (Single block for Data + Control Block)           | **2** (Data heap + Control Block heap)         |
| **Cache Locality** | **High** (Data adjacent to metadata)                    | **Low** (Potentially far apart)                |
| **Memory Bloat**   | **Risk:** Data stays alive until *all* `weak_ptr`s die. | **Safe:** Data freed when strong count hits 0. |

### 3. Performance Rules
* **Parameter Passing:** Always pass by `const std::shared_ptr<T>&` in hot paths. Passing by value triggers **Atomic Increment/Decrement** (Cache line locking).
* **Cycle Breaking:** Use `std::weak_ptr` for back-references (e.g., Parent <-> Child).

---

## III. System Architecture & Memory
> **Core Doctrine:** Latency kills Robotics. Minimizing copies is the ultimate goal.

### 1. PIMPL (Pointer to Implementation)
* **Goal:** Compilation Firewall & ABI Stability.
* **Mechanism:** Move private members to a struct in `.cpp`. The header only holds a `unique_ptr<Impl>`.
* **Critical Detail:** Destructor `~Class()` must be defined in the `.cpp` file where `Impl` is complete (size known).

### 2. Data Transport: Zero-Copy vs. Socket
* **Socket (ROS 1 / TCP):**
    * Serialization $\to$ User Buffer $\to$ Kernel Buffer $\to$ (Network) $\to$ Kernel Buffer $\to$ User Buffer $\to$ Deserialization.
    * **Cost:** **4 Deep Copies** + Context Switches.
* **Shared Memory (ROS 2 / Iceoryx):**
    * Mechanism: `mmap` maps physical RAM to virtual address space of multiple processes.
    * **Cost:** **Zero Copy**. Just pointer passing.
    * **Trap:** Pointers in Shared Memory must be **Relative Pointers** (Offsets), not absolute Virtual Addresses.

---

## IV. Interview Behavioral Checks (Tail Questions)

### Q: "Why did you use `std::vector` instead of `std::list` for the sensor buffer?"
* **Answer:** **Cache Locality**. `std::vector` guarantees contiguous memory. CPU prefetcher works efficiently. `std::list` causes cache misses due to pointer chasing (random heap nodes).

### Q: "Explain `virtual memory` in the context of our robot causing a segfault."
* **Answer:** The robot accessed a Virtual Address not mapped to a Physical Address (Page Fault -> Segfault). This protects other processes (like the Safety Controller) from crashing due to a buggy Perception Node.

### Q: "When would you prefer a Monolithic architecture over Microservices (Nodes) in Robotics?"
* **Answer:** When **Latency** is the absolute bottleneck (e.g., High-frequency control loop > 1kHz). Merging nodes into "Nodelets" (ROS) or a single process eliminates IPC overhead/Context switching completely.