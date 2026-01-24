---
layout: post
title: Integrated Daily Battle Plan - Day6
subtitle:
categories: Programming
status:
tags:
mathjax: true
---
2025-12-26 08:42

Tags: [[_Integrated Daily Battle Plan]], [[study]]

## String Ops & Binary Search

### 1. Modern C++ String Optimization

- **Problem:** Naive string manipulation (e.g., `to_lower` then `filter`) often creates unnecessary copies and multiple passes.
    
- **Solution:** * **In-place / Single-pass:** Perform filtering and transformation within a single loop/iterator traversal to reduce $O(3N)$ to $O(N)$.
    
    - **`std::string_view`:** Use `string_view` for read-only string arguments. It avoids heap allocation and works seamlessly with `std::string`, `char*`, and `std::vector<char>` buffers.
        
    - **Key Benefit:** Prevents **Memory Fragmentation** in long-running robotics processes.
        

### 2. Algorithmic Scaling: "Is Subsequence" (LeetCode 392)

- **Scenario:** Checking thousands of short strings ($S$) against one massive static stream ($T$).
    
- **Naive Approach:** $O(S \times T)$ - iterates through $T$ for every $S$. Too slow for real-time.
    
- **Engineering Optimization (Inverted Index):**
    
    - **Pre-computation:** Store indices of each char in $T$ using `std::vector<int> pos[26]`.
        
    - **Binary Search:** Use `std::upper_bound` to find the _next_ valid character position in $O(\log T)$.
        
    - **Complexity:** $O(T)$ (setup) + $O(S \cdot \log T)$ (query).
        
- **Trade-off:** High memory usage for index vs. extremely low latency for queries.
    

### 3. Critical C++ Traps

- **Signed/Unsigned Mismatch:** Comparing `int` loop counters with `string::length()` (which returns `size_t` / `unsigned long`) can cause infinite loops or logic errors if the counter becomes negative.
    
    - _Rule:_ Always cast to `static_cast<int>` or use `size_t` consistently.