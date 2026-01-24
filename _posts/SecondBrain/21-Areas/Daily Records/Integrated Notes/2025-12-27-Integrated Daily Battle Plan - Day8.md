---
layout: post
title: Integrated Daily Battle Plan - Day8
subtitle:
categories: Programming
status:
tags:
mathjax: true
---
2025-12-28 09:25

Tags: [[_Integrated Daily Battle Plan]], [[study]]

## Search Space & Iterator Safety

### 1. Algorithm Strategy: Subarray Sums (LeetCode 209)

**Problem:** Find the minimal length subarray where sum $\ge$ target.

| Strategy            | Time Complexity | Constraint            | Key Mechanism                                                                                         |
| :------------------ | :-------------- | :-------------------- | :---------------------------------------------------------------------------------------------------- |
| **Sliding Window**  | $O(N)$          | **Non-negative only** | Monotonic growth allows "caterpillar" movement (`right++`, then `left++`).                            |
| **Binary Search**   | $O(N \log N)$   | **Non-negative only** | Prefix Sums are sorted. Search for `target` in the accumulated array.                                 |
| **Monotonic Deque** | $O(N)$          | **Negative allowed**  | (LeetCode 862) Prefix Sums are unsorted. Discard "useless" start candidates to maintain sorted deque. |

### 2. C++ STL & Binary Search Patterns

**Goal:** Find the rightmost index `mid` where `P[mid] <= Val`.

* **Logic Transformation:**
    * Original: `P[right] - P[mid] >= target`
    * Transformed: `P[mid] <= P[right] - target` (Find largest `mid` $\le$ Value)
* **STL Implementation:**
    * `std::upper_bound`: Returns first element **strictly greater** ($>$).
    * `std::prev(iterator)`: Moves back one step to get the element **less or equal** ($\le$).

### 3. Critical Safety Protocol: Iterator Bounds

**The "Segfault Trap":**
Using `std::prev()` on the result of `upper_bound` without checks is dangerous.

```cpp
auto it = std::upper_bound(P.begin(), P.end(), val);

// ❌ DANGER: If 'val' is smaller than ALL elements, 'it' == P.begin().
// std::prev(P.begin()) points to invalid memory -> Undefined Behavior.
size_t idx = std::prev(it) - P.begin(); 

// ✅ SAFE PATTERN:
if (it != P.begin()) {
    size_t idx = std::prev(it) - P.begin();
    // Proceed...
}

```

### 4. Senior Engineering Insight

* **Prefix Sum Padding:** Always size `N+1` and set `P[0] = 0`. This simplifies range math (`P[r] - P[l]`) preventing Index Out of Bounds when `l=0`.
* **Type Safety:** `accumulate` or manual sums can easily overflow `int`. Always use `long long` for prefix sums in production.

## String Optimization & Safety

### 1. Optimization Strategy: Direct Address Table (DAT)
**Context:** LeetCode 3 (Longest Substring Without Repeating Characters).

| Method | Overhead | Cache Locality | Time Complexity |
| :--- | :--- | :--- | :--- |
| **`std::unordered_set`** | High (Hashing + Bucket mgmt + Heap Alloc) | Poor (Pointer chasing) | $O(N)$ (High constant) |
| **`std::vector<int>` (DAT)** | Low (Stack/Contiguous Memory) | **Excellent** (L1 Cache friendly) | **$O(N)$ (Low constant)** |

* **Lazy Invalidation Pattern:** Instead of removing elements from the set physically (which requires a loop), store the **index** of the last occurrence.
* **Logic:** If `last_seen[char] < left`, it effectively "doesn't exist" in the current window.

### 2. Critical Safety Protocol: The "Signed Char" Trap
**Risk:** On x86 architectures, `char` is signed by default (`-128` to `127`).
**Scenario:** Processing binary data, Extended ASCII, or UTF-8 multi-byte sequences.
* Input `0xFF` (255) is interpreted as `-1`.
* Accessing `array[s[i]]` results in `array[-1]` $\rightarrow$ **Segfault / Memory Corruption**.

**The Fix (Mandatory):**
```cpp
// ❌ Dangerous (Junior Mistake)
int idx = s[i]; // Becomes -1 if s[i] is 0xFF

// ✅ Safe (Senior Standard)
// Cast to unsigned to ensure range [0, 255]
int idx = static_cast<unsigned char>(s[i]); 
````

### 3. Actionable Takeaways

- **Always Cast:** When using `char` as an array index, **always** cast to `unsigned char` or `uint8_t`.
    
- **Prune Branches:** Use `if-else` logic to avoid redundant calculations (e.g., only update `max_len` when the window actually expands).
    