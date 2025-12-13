---
layout: post
title: Summary of additional benefits of avoiding heap allocation
categories: Programming
status: published
tags:
  - cpp
  - embedded
  - robotics
  - muti-thread
---
2025-12-13 08:15

Tags: [[programming]], [[study]]

# Summary of additional benefits of avoiding heap allocation

## Predictable Performance with Deterministic operation using Locality:

- Reduced Jitter: Heap allocation takes a variable amount of time depending on the operating system or memory manager. This variability, especially under high load, can lead to jitter. Stack memory is located close to the CPU cache, resulting in very fast access speeds. Avoiding heap allocation ensures that all operations complete very quickly and consistently on the stack, which is advantageous for meeting the requirements of real-time systems. 

## Reduced Memory Fragmentation:

- Frequent heap allocation and deallocation create "holes" of varying sizes in the heap memory, leading to memory fragmentation. Severe fragmentation can cause allocation failures even when sufficient memory is available. Using the stack inherently prevents this fragmentation problem.

## Improved Exception Safety:

- Heap allocation functions like `new` or `malloc` can throw exceptions (e.g., `std::bad_alloc`) if memory is insufficient. `std::string_view` and `std::span` do not perform allocations, thus eliminating the possibility of such exceptions.

## Resolving Lock Contention

- Heap memory allocation (e.g., inside `new` or `malloc`) typically uses a global lock. When multiple threads request heap allocation simultaneously, they will **contend** for this lock. 'Using stack only' fundamentally eliminates the **race condition** that occurs when multiple worker threads simultaneously create `std::string` objects.
