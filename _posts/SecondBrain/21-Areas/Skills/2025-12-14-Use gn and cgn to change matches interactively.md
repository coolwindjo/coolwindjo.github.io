---
layout: post
title: Use gn and cgn to change matches interactively
categories: SkillOrKnowhow
status: published
tags:
  - vim
  - perplexity
---
2025-12-14 09:02

Tags: [[]]

# Use gn and cgn to change matches interactively

In Vim, you can use `gn`and `cgn`to interactively change search results one by one.[1][2]

## Basic concepts

- `gn`: Go to the next match section of the current search pattern **+ Visually select that section** .[2]
- `cgn`: **Find the next match of the current search pattern and replace it** .[1][2]

## Example of usage

1. Set the word you want to change as a search word
    
    - Example: `:set hlsearch`Assuming that is on, `/foo`→ Search with Enter `foo`.[3]
2. Change the first match
    
    - `cgn`Enter in command mode .
    - Vim `foo`will select the next and switch to insert mode, so after you type a new word `<Esc>`, .[2][1]
3. Repeat the same changes for the remaining matches
    
    - `.`Each time you press (dot), `cgn`the “just done” action is repeated, replacing the next match with the same new word.[1][2]
    - Skip the match you want to skip `n`, and then go back to the position you want to change `cgn`→ and `.`repeat from there.

In summary:

```vim
/foo<CR>      " 바꿀 단어 검색
cgn           " 첫 번째 매치 변경
<Esc>
.             " 다음 매치 동일 변경
.             " 또 다음 매치 동일 변경
n             " 이번 건 건너뛰기
cgn           " 다음 매치를 새 값으로 변경
```

This pattern allows you to **quickly make bulk edits by checking each location**`:%s/.../.../g` instead of doing a “replace all”.[2][1]

## References
- [1](https://stackoverflow.com/questions/53931919/how-to-change-a-word-in-vim-and-all-of-its-other-occurrences) 
- [2](https://vonheikemen.github.io/devlog/tools/how-to-survive-without-multiple-cursors-in-vim/) 
- [3](https://kakaruto.com/posts/replace-all-occurrences-of-a-word-in-vim-and-neovim)