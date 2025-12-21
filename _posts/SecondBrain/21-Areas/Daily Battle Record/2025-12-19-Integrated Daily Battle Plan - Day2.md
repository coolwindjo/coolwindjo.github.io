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

## **C++ STL Patterns & Memory Optimization**

---

### 1. The "Erase-Remove" Idiom
**Concept:** Efficiently removing elements from a `std::vector` without manual loops.
* `std::remove`: logically shifts non-deleted elements to the front. Returns iterator to the *new logical end*.
* `vector::erase`: physically resizes the container by removing the "garbage" tail.

```cpp
#include <algorithm>
#include <vector>

void cleanVector(std::vector<int>& nums, int val) {
    // Standard Pattern
    nums.erase(std::remove(nums.begin(), nums.end(), val), nums.end());
}
````

### 2. Safe Erasure in Loops (Iterator Invalidation)

Critical Risk: Calling erase(it) invalidates the current iterator. ++it in the for loop header will cause a crash (Undefined Behavior).

Solution: Use the iterator returned by erase(), which points to the next valid element.

```cpp
// Correct Pattern for selective erasure
for (auto it = nums.begin(); it != nums.end(); /* no increment here */) {
    if (shouldRemove(*it)) {
        it = nums.erase(it); // Update 'it' to the next valid element
    } else {
        ++it; // Manual increment
    }
}
```

### 3. Two-Pointer: Reader-Writer Pattern (In-Place Modification)

Goal: Modify array in O(N) time and O(1) space.

Mental Model:

- **Writer (`k`):** Pointer to the end of the "Clean/Valid Zone".
    
- **Reader (`i`):** Pointer scanning the "Input/Dirty Zone".


```cpp
// Example: Remove 'val' from vector in-place
int removeElement(vector<int>& nums, int val) {
    int writer = 0;
    for (int reader = 0; reader < nums.size(); ++reader) {
        if (nums[reader] != val) {
            nums[writer++] = nums[reader]; // Overwrite & Advance
        }
    }
    return writer; // New size
}
```

### 4. Sorted Array Deduplication (Generalized "At Most K")

Problem: Remove duplicates from sorted array, allowing at most k duplicates.

Key Logic: Compare current reader value against the validated value at writer - k.

- **Zone A (0 to writer-1):** Validated, immutable truth.
    
- **Rule:** If `nums[reader] != nums[writer - k]`, it means we haven't filled our quota of `k` identical items yet.
    

```cpp
// Example: Allow at most 2 duplicates (LeetCode 80)
int removeDuplicates(vector<int>& nums) {
    if (nums.size() <= 2) return nums.size();
    
    int writer = 2; // First 2 elements are always valid
    for (int reader = 2; reader < nums.size(); ++reader) {
        // Compare against the "Safe Zone" (writer - 2)
        if (nums[reader] != nums[writer - 2]) {
            nums[writer++] = nums[reader];
        }
    }
    return writer;
}
```

### 5. Architecture Note: High-Frequency Shared Pointers

Topic: Multi-core data sharing (e.g., Robotics Pipeline).

Risk: std::shared_ptr uses atomic instructions for reference counting.

Performance Hit:

- **Cache Coherency Traffic:** Multiple cores updating the same ref-count causes cache line invalidation (False Sharing/Bus Storm).
    
- **Mitigation:** In hard real-time loops, prefer passing by `const reference`, using object pools (Raw Pointers with manual lifecycle), or `std::unique_ptr` where ownership is clear.

	---
	