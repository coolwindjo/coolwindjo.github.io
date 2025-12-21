---
layout: post
title: Integrated Daily Battle Plan - Day2
subtitle:
categories: Programming
status: published
tags:
---
2025-12-20 11:09

Tags: [[_Integrated Daily Battle Plan]], [[study]]

# Engineering Interview Survival Kit: C++ & Algorithms

---

## I. Algorithmic Patterns: Two Pointers (Reader-Writer)

### Core Concept: "In-Place Operations"
* **Goal:** Modify data without $O(N)$ auxiliary space.
* **Time Complexity:** $O(N)$ (One-pass).
* **Space Complexity:** $O(1)$ (No extra allocation).

### Pattern 1: Basic Filtering (Remove Element)
Use a **Writer** pointer to track the "valid" tail, and a **Reader** to scan.

```cpp
// Pattern: Overwrite valid data to the front
int writer = 0;
for (int reader = 0; reader < nums.size(); ++reader) {
    if (nums[reader] != val) { // Keep Condition
        nums[writer++] = nums[reader];
    }
}
return writer; // New logical size
````

### Pattern 2: Sorted Array Deduplication (Limit k)

- **Problem:** Keep at most $k$ duplicates.
    
- **Engineering Rule:** **Trust the "Clean Zone"**. Do not use temporary variables for state.
    
- **Logic:** Compare `current_input` (reader) with the `last_valid_output` (writer - k).
    

C++

```
// Example: Keep max 2 duplicates (LeetCode 80)
if (nums.size() <= 2) return nums.size();
int writer = 2; 

for (int reader = 2; reader < nums.size(); ++reader) {
    // Check against the "Safe Zone" (writer - 2)
    // If different, it means we haven't filled the quota of 2 yet.
    if (nums[reader] != nums[writer - 2]) {
        nums[writer++] = nums[reader];
    }
}
```

---

## II. C++ STL Mechanics & Traps

### 1. The "Erase-Remove" Idiom

- **`std::remove`**: Does **NOT** resize the vector. It shifts elements and returns a "Logical End" iterator.
    
- **`vector::erase`**: Physically removes elements and **resizes** the container.
    

C++

```
// The Standard One-Liner
nums.erase(std::remove(nums.begin(), nums.end(), val), nums.end());
```

### 2. Iterator Invalidation (The Segfault Trap)

Modifying a container inside a loop invalidates iterators.

- **Wrong:** `erase(it)` inside a for-loop without updating `it`.
    
- **Right:** Update `it` with the return value of `erase`.
    

C++

```
// Safe Erasure in Loop
for (auto it = nums.begin(); it != nums.end(); /* no ++it */) {
    if (should_remove(*it)) {
        it = nums.erase(it); // RETURNS the next valid iterator
    } else {
        ++it;
    }
}
```

### 3. List vs. Vector Strategy

|**Feature**|**std::vector**|**std::list**|
|---|---|---|
|**Access**|Random ($O(1)$)|Sequential ($O(N)$)|
|**Prev Access**|`idx - k`|`std::prev(it, k)`|
|**Removal**|Expensive Shift ($O(N)$)|Pointer Swap ($O(1)$)|
|**Invalidation**|High (Realloc/Shift)|Low (Only deleted node)|

---

## III. Mental Models for Engineering

### 1. The "Admission Control" Mindset

When filtering data, act as a **Gatekeeper (Writer)**.

- Don't look at the chaotic line outside (**Input/Reader**).
    
- Look at your official logbook (**Output/Writer**).
    
- _Question:_ "Does this new person violate the rules based on who I _already_ let in?"
    

### 2. Loop Invariant

- **Zone A `[0 ... writer-1]`**: The "Truth". Finalized, sorted, valid data.
    
- **Zone B `[reader ... end]`**: The "Unknown". Data to be processed.
    
- **Zone C `[writer ... reader-1]`**: Garbage / Ignored.
    

### 3. System Design Teaser (Next Level)

- **`std::shared_ptr` Cost:** Thread-safe reference counting uses **Atomic Operations**.
    
- **The Hardware Reality:** Atomic ops cause **Cache Coherency Traffic** (locking the bus/cache line) between cores.
    
- **Result:** In high-frequency loops (e.g., 60Hz Robotics control), this kills parallelism.
    
---
