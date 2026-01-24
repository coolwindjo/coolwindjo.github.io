---
layout: post
title: Integrated Daily Battle Plan - Day7
subtitle:
categories: Programming
status:
tags:
mathjax: true
---
2025-12-27 07:56

Tags: [[_Integrated Daily Battle Plan]], [[study]]

## Array & Two Pointers

### 1. Algorithm Optimization: 3Sum (LeetCode 15)

- **Problem:** Finding unique triplets that sum to zero.
- **Initial Bottleneck:** $O(N^3)$ Brute Force & Logic complexity.
- **Core Pattern:** **Sort + Two Pointers** ($O(N^2)$).
    - Fix one element `nums[i]`, then solve Two Sum (`b + c = -nums[i]`) on the rest.

### 2. Engineering Optimizations (The "Senior" Difference)

#### A. Memory Management (Space Complexity)
- **Anti-Pattern:** Using `std::unordered_map` or `std::set` to handle duplicates.
    - **Cost:** $O(N)$ extra space + Hashing overhead.
- **Solution:** Leverage **Sorted Property**.
    - Skip duplicates by checking adjacent elements: `while (l < r && nums[l] == nums[l+1]) l++; r--;`
    - **Result:** $O(1)$ Auxiliary Space (excluding output).

#### B. Logic Robustness (Sentinel Values)
- **Bug:** Initializing `prev` pointers with `nums[0]` or `nums[n-1]` caused logic errors for specific inputs (e.g., `[-1, -1, -1]`).
- **Fix:** Handle duplicates **on-the-fly** inside the loop *after* processing a valid triplet, rather than relying on state variables.

#### C. CPU Pruning (Early Exit)
- **Optimization:** If `nums[i] > 0`, break the loop immediately.
    - **Reason:** In a sorted array, if the smallest number is positive, the sum of three numbers can never be zero.
