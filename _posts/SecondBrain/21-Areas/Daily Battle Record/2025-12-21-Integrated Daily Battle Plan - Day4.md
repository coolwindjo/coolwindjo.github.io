---
layout: post
title: Integrated Daily Battle Plan - Day4
subtitle:
categories: Programming
status: published
tags:
---
2025-12-22 08:05

Tags: [[_Integrated Daily Battle Plan]], [[study]]

## Training Log: 2025-12-21
### 1. Key Concepts & Corrections
* **Topic:** Space Complexity in Frequency Counting (LC 169)
* **Weakness:** Defaulting to `std::unordered_map` ($O(N)$ Space) without considering embedded constraints (Heap fragmentation, OOM).
* **Correction:** **Boyer-Moore Voting Algorithm**. Two-pass approach (Voting -> Verification) guarantees $O(1)$ Space and handles "No Majority" cases safely.

* **Topic:** Memory Access Patterns & Cognitive Load (LC 189)
* **Weakness:** "Pulling" logic (`prev = (cur - k + n) % n`) increases cognitive load and branch misprediction risks.
* **Correction:** **"Pushing" logic** (Standard Cycle Sort) combined with **GCD (Greatest Common Divisor)** determines the exact number of cycles, removing the need for a `visited` array or total `count` variable.

### 2. Representative Code Snippet (Cheatsheet)
*Context: LC 189 - Rotate Array (The "Masterpiece" Logic)*
```cpp
#include <vector>
#include <numeric> // std::gcd

class Solution {
public:
    void rotate(std::vector<int>& nums, int k) {
        int n = nums.size();
        k = k % n;
        if (k == 0) return;

        // OPTIMIZED Pattern (Mastery Level)
        // 1. GCD determines exact cycle count (Mathematical guarantee).
        // 2. "Pushing" logic (Forward move) reduces cognitive load vs "Pulling".
        // 3. Register-based swap (temp) is zero-cost on modern compilers.
        int cycles = std::gcd(n, k); 

        for (int start = 0; start < cycles; ++start) {
            int current = start;
            int prev_val = nums[start];

            do {
                int next_idx = (current + k) % n;
                
                // SWAP Logic
                int temp = nums[next_idx];
                nums[next_idx] = prev_val;
                prev_val = temp;

                current = next_idx;
            } while (start != current);
        }
    }
};
````

### 3. Mentor's Verdict

- **Performance:** Initially shaky on System Constraints (Memory), but demonstrated **Senior-level defense** on Algorithm Logic (GCD).
    
- **Action:** Adopt the "Pushing" mental model for all permutation problems to improve readability.
    
