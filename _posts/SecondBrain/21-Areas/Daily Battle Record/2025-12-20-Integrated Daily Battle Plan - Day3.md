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

# Low-Latency C++ Optimization & Exception Safety

---

## 1. The `noexcept` Performance Contract
**Core Doctrine:** `noexcept` is not just documentation; it is an architectural decision that affects binary size (removing `.eh_frame` overhead) and runtime path selection (Move vs. Copy).

### A. The "Vector Reallocation" Trap
`std::vector` requires **Strong Exception Guarantee** during resizing.
* **Scenario:** Vector runs out of capacity -> Allocates new block -> Moves elements.
* **The Trap:** If `Move Constructor` is **NOT** `noexcept`, the compiler forces a **COPY** to ensure data isn't lost if a move throws halfway. This destroys performance.

#### **Drill Snippet: The Optimized Sensor Node**
```cpp
class SensorNode {
    int* data;
    size_t size;

public:
    // [BAD] Compiler assumes this might throw -> std::vector uses COPY.
    // SensorNode(SensorNode&& other) { ... }

    // [GOOD] Explicit contract -> std::vector uses MOVE (Pointer Swap).
    SensorNode(SensorNode&& other) noexcept 
        : data(other.data), size(other.size) {
        other.data = nullptr;
        other.size = 0;
    }
    
    // [MANDATORY] Destructors must never throw.
    ~SensorNode() noexcept {
        delete[] data; // Internal try-catch if logic is complex
    }
};
````

### B. Conditional Noexcept (The Wrapper Pattern)

**Rule:** When writing templates or wrappers, do not blindly add `noexcept`. Use the "Conditional Noexcept" idiom to propagate the safety guarantee of the underlying type.

```cpp
template <typename T>
void safe_swap(T& a, T& b) noexcept(noexcept(a.swap(b))) {
    // If a.swap(b) is noexcept, this function is noexcept.
    // If a.swap(b) throws, this function throws (avoiding std::terminate crash).
    a.swap(b);
}
```

### C. `std::move_if_noexcept` Strategy

**Use Case:** Critical Transactional Logic where **Data Safety > Performance**.

```cpp
void transfer_ownership(SensorNode& source, std::vector<SensorNode>& dest) {
    // 1. If Move Ctor is noexcept: Casts to rvalue (Fast Move).
    // 2. If Move Ctor throws: Casts to const lvalue (Safe Copy).
    dest.push_back(std::move_if_noexcept(source)); 
}
```

---

## 2. Low-Level Mechanics: Stack Unwinding

**Concept:** The "Preparation Code" overhead.

- **Without `noexcept`:** Compiler generates **LSDA (Language Specific Data Area)** and registers entries in the `.eh_frame` table (The "Backpack" analogy).
    
- **With `noexcept`:** No table registration. If an exception occurs, it jumps straight to `std::terminate`.
    
- **Benefit:** Reduced binary size, faster function entry/exit, better instruction cache locality.
    

## 3. Action Items

- [ ] **Code Audit:** Check `SensorNode` and `ImageFrame` classes in the current project. Add `noexcept` to all Move Constructors and Move Assignment Operators.
    
- [ ] **Verification Drill:** Write a small test utilizing `std::vector::resize` and print "Copy" vs "Move" to console to verify the `noexcept` effect.
    
- [ ] **Refactor:** Apply `noexcept(noexcept(...))` pattern to any custom utility templates.

---