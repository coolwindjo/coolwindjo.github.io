---
layout: post
title: Integrated Daily Battle Plan - Day5
subtitle:
categories: Programming
status: published
tags:
mathjax: true
---
2025-12-23 09:24

Tags: [[_Integrated Daily Battle Plan]], [[study]]

## Algorithm Pattern Optimization

### 1. Key Concepts & Corrections

* **Topic:** Cache Locality & Memory Overhead (LC 383 Ransom Note)
    * **Weakness:** Defaulting to `std::unordered_map` for small, fixed character sets (e.g., lowercase English letters). This incurs hashing overhead and heap fragmentation.
    * **Correction:** **Fixed-Size Array Strategy**. Use `std::vector<int>(26)` or `int arr[26]`.
        * *Benefit:* Deterministic $O(1)$ access (pointer arithmetic) vs. Hashing average $O(1)$.
        * *Hardware:* Sequential memory access (Stack/Contiguous Heap) significantly improves CPU Cache Hit rates compared to scattered Linked-List nodes in a Hash Map bucket.

* **Topic:** Bijective Mapping Validation (LC 205 Isomorphic Strings)
    * **Weakness:** Implementing only "Forward Mapping" (Domain $\to$ Codomain) and failing to detect "Many-to-One" collisions (e.g., mapping both 'a' and 'b' to 'x').
    * **Correction:** **Double-Map or Map+Set Approach**. You must verify:
        1.  $A \to B$ (Forward consistency).
        2.  $B$ has not been used by any other $A' \neq A$ (Reverse consistency).

### 2. Representative Code Snippet (Cheatsheet)
*Context: LC 383 - Ransom Note (High-Performance Pattern)*

```cpp
#include <vector>
#include <string>

class Solution {
public:
    bool canConstruct(std::string ransomNote, std::string magazine) {
        // OPTIMIZATION: Use Stack-allocated array or fixed Vector instead of Hash Map.
        // Reason: Avoids Hashing overhead and improves Cache Locality.
        std::vector<int> freq(26, 0);

        // 1. Build Frequency Map (Magazine)
        for (char c : magazine) {
            freq[c - 'a']++;
        }

        // 2. Consume (Ransom Note)
        for (char c : ransomNote) {
            // Decrement and check in single atomic-like step
            if (--freq[c - 'a'] < 0) {
                return false; // Fail fast
            }
        }
        return true;
    }
};
```
