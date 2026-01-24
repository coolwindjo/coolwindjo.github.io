---
layout: post
title: Algorithm Design Mindset
subtitle:
categories: Programming
status: published
tags:
  - gemini-30-pro
---
2025-12-19 16:36

Tags: [[programming]], [[study]], [[mindset]]

# Algorithm Design Mindset

- [Leetcode 26 Remove Duplicates From Sorted Array](https://coolwindjo.github.io/algoguru/2025/12/19/leetcode-26-remove-duplicates-from-sorted-array.html){:target="_blank"}
- [Leetcode 80 Remove Duplicates From Sorted Array II](https://coolwindjo.github.io/algoguru/2025/12/19/leetcode-80-remove-duplicates-from-sorted-array-ii.html){:target="_blank"}

당신의 두려움은 **"Dirty Read(오염된 데이터 읽기)"**에 대한 걱정에서 비롯되었습니다. `[1, 1, 1, ...]` 상황에서 데이터를 덮어쓰면, "비교해야 할 원본 데이터가 사라지지 않을까?"라고 생각한 것입니다.

이 사고방식을 **Senior Engineer의 사고방식(Loop Invariant)**으로 전환하는 3단계 훈련법을 제시합니다.

### 1. Mental Model Shift: "Two Arrays in One"

배열이 하나(`nums`)라고 생각하지 마십시오. 논리적으로 **두 개의 영역**으로 쪼개져 있다고 상상해야 합니다.

- **Zone A (0 ~ writer - 1):** 이미 검증이 끝난 **"Clean & Final Output"**. 이곳의 데이터는 **절대적 진실**입니다.
    
- **Zone B (reader ~ end):** 아직 처리하지 않은 **"Input Stream"**.
    
- **Zone C (writer ~ reader - 1):** 쓰레기 값(Garbage) 혹은 중복된 값. 무시해도 되는 영역.
    

**당신의 오류:** 비교 대상을 "Zone B(원본)"에서 찾으려 했습니다. **정답:** 비교 대상은 "Zone A(이미 검증된 결과)"에 있습니다.

> **핵심 질문:** "내가 지금 넣으려는 값(`reader`)이, **'이미 확정된 결과물의 끝에서 두 번째 값(`writer-2`)'**과 중복되는가?"

### 2. Visual Proof: `writer`는 `writer-2`를 덮어쓰지 않는다

`writer`가 가리키는 곳은 "새로운 값을 쓸 곳"입니다. `writer-2`는 "이미 안전하게 저장된 과거의 곳"입니다.

`writer`는 항상 `writer-2`보다 2칸 앞에 있습니다. 따라서 **현재의 쓰기 동작(Overwrite)이 과거의 검증 데이터(Reference)를 파괴할 물리적 가능성은 0%입니다.**

Plaintext

```
Index:  0  1  2  3  4  5
Data:  [1, 1, 1, 2, 2, 3]
              ^  ^
        writer-2 |
              writer (여기다 쓸 건데, 저 뒤에 있는 writer-2가 다칠까? 절대 아님)
```

### 3. Algorithm Design Pattern: "Admission Control" (입국 심사관 패턴)

이런 문제를 풀 때는 자신을 **입국 심사관(Writer)**이라고 생각하십시오.

- **Writer(심사관):** "새로운 사람(`reader`)이 들어오려고 한다."
    
- **Rule:** "같은 국적의 사람은 최대 2명까지만 통과시켰다."
    
- **Check:** "내가 **가장 최근에 통과시킨 두 사람**을 보자. 그 중 두 번째 전 사람(`writer-2`)과 지금 들어오는 사람(`reader`)이 같은가?"
    
    - 같다면? -> 이미 2명 꽉 찼음. (`reader` 탈락, `writer` 제자리)
        
    - 다르다면? -> 통과. (`writer` 자리에 기록, `writer` 전진)
        

당신이 `v` 변수를 둔 것은, 심사관이 **"심사 기록부(Zone A)"**를 믿지 못하고 **"대기 줄에 있던 사람의 얼굴(Zone B)"**을 기억하려 했기 때문에 코드가 복잡해진 것입니다. **기록부(Zone A)를 믿으십시오.**
## Dockerfiles

```Dockerfile

```

## References
- [My Obsidian Setup: The King of Note Taking Apps](<www.youtube.com/watch?v=xR5-0XDkwU0>){:target="_blank"} ![](//www.youtube.com/watch?v=xR5-0XDkwU0)

## Step by step guide

1. 

## Related Posts
- [SensorFusionProject Category](<https://coolwindjo.github.io/categories.html#h-SensorFusionProject>){:target="_blank"} 
