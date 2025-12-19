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

### 1. The "Dot" Method (가장 추천: `cgn`)

Vim 7.4부터 도입된 `gn` (Search Next Match) 모션을 활용한 가장 우아한 방법이다. 순차적이지만 **기계적인 속도**로 동시 수정 효과를 낸다.

**절차 (Step-by-Step):**

1. **커서 위치:** 수정하려는 단어 위에 커서를 둔다.
    
2. **`*` (Asterisk):** 해당 단어를 검색한다. (모든 일치하는 단어가 하이라이트 됨)
    
3. **`cgn` 입력:** "Change Go Next"의 약자.
    
    - 커서가 다음 일치 단어로 점프하면서 지우고 **Insert Mode**로 진입한다.
        
4. **수정:** 새로운 단어를 타이핑하고 **`ESC`**를 누른다.
    
5. **`.` (Dot) 연타:**
    
    - 이제 `.` 키를 누를 때마다 다음 단어를 찾아 **자동으로 똑같이 수정**해준다.
        

**요약:** `*` -> `cgn` -> (수정) -> `ESC` -> `.` -> `.` -> `.`

---

### 2. The "Global Substitution" (대량 수정: `:%s`)

화면에 보이는 것뿐만 아니라 파일 전체, 혹은 특정 범위의 모든 단어를 한 방에 바꿀 때 쓴다.

**명령어:**

Vim Script

```
:%s/OldWord/NewWord/gc
```

- `%`: 문서 전체.
    
- `s`: Substitute (치환).
    
- `g`: Global (한 줄에 여러 개 있어도 다 바꿈).
    
- `c`: **Confirm (확인).** 바꿀 때마다 `y/n`을 물어본다. (이게 있어야 눈으로 보면서 수정 가능)
    

**팁:** 커서가 있는 단어를 자동으로 넣으려면 커서 위에서 `:%s/<C-r><C-w>/NewWord/gc` 를 입력해라. (`<C-r><C-w>`는 현재 커서 단어를 커맨드 라인에 붙여넣는다.)

---

### 3. Visual Block (수직 정렬된 경우: `Ctrl + v`)

만약 수정하려는 단어들이 **세로로 나란히 정렬**되어 있다면 이게 제일 빠르다.

1. **`Ctrl + v`**: Visual Block 모드 진입.
    
2. **`j` / `k`**: 커서를 아래/위로 움직여서 수정할 열(Column)을 선택.
    
3. **`c` (Change)**: 선택 영역이 지워지고 Insert 모드 진입.
    
4. **수정**: 단어를 입력. (입력 중에는 한 줄만 바뀌는 것처럼 보인다.)
    
5. **`ESC`**: **이때 모든 줄에 동시에 적용된다.**
    

---

### 4. Plugins (VS Code 방식)

만약 정말로 멀티 커서 UI가 필요하다면, **`mg979/vim-visual-multi`** 플러그인을 설치해라.

- VS Code의 `Ctrl+D`와 거의 똑같이 동작한다.
    
- 하지만 의존성이 생기므로 추천하지 않는다.
    
---

### 5. 꼬리 질문 (Tail Question)

`cgn` 방식과 `:%s` 방식은 모두 텍스트를 수정하지만, 수정 후 **"Undo (`u`)"**를 눌렀을 때의 동작 방식이 근본적으로 다르다.

**Q: `cgn`으로 5개의 단어를 수정하고 `u`를 한 번 눌렀을 때와, `:%s`로 5개를 한 번에 수정하고 `u`를 눌렀을 때, 되돌리기(Undo)는 각각 어떻게 동작하는가? Vim의 Undo Tree 관점에서 설명해라.**

**실시.**
In Vim, you can use `gn`and `cgn`to interactively change search results one by one.[1][2]


### 1. `settings.json` 설정 (Standard Method)

VS Code에서 `Ctrl + Shift + P` -> `Preferences: Open User Settings (JSON)`을 열고, 아래 블록을 추가해라.

JSON

```
"vim.normalModeKeyBindingsNonRecursive": [
    {
        "before": ["<Esc>", "<Esc>"],
        "commands": [":nohl"]
    }
]

" <Leader> + h 키를 누르면 하이라이트 해제 (보통 Leader는 \ 또는 Space)
nnoremap <silent> <Leader>h :nohlsearch<CR>

" 혹은 ESC를 두 번 누르면 해제되도록 설정 (매우 직관적)
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>

```

- **`before`**: 입력할 키 시퀀스. `["<Esc>", "<Esc>"]`는 ESC 두 번 연타를 의미한다.
    
- **`commands`**: 실행할 Vim 명령어. `:nohlsearch`의 약어인 `:nohl`을 쓰면 된다.
    
- **`NonRecursive`**: `nnoremap` (No Recursive)과 동일하다. 즉, 이 매핑이 다른 매핑을 트리거하지 않도록 방지한다.
    

---

### 2. `.vimrc` 파일 사용 (Alternative Method)

만약 자네가 "나는 죽어도 순수 Vim 설정을 파일로 관리하겠다"는 주의라면, VS Code가 자네의 로컬 `.vimrc`를 읽도록 강제할 수 있다.

`settings.json`에 다음을 추가해라:

JSON

```
"vim.vimrc.enable": true,
"vim.vimrc.path": "/home/username/.vimrc" // 자네의 실제 경로
```

하지만 **VS Code Vim 확장 프로그램은 모든 Vim 기능을 지원하지 않으므로**, `.vimrc`를 직접 로드하는 방식은 종종 호환성 에러를 뿜어낸다. 1번 방식(JSON)이 훨씬 안정적이다.

---

### 3. 꼬리 질문 (Tail Question)

자네가 설정한 키는 `"vim.normalModeKeyBindingsNonRecursive"`다. Vim 스크립트의 `nnoremap`에 해당한다.

**Q: 만약 이것을 `NonRecursive`가 아닌 `"vim.normalModeKeyBindings"` (즉, `nmap`)로 설정했고, 다른 어딘가에 `:nohl` 명령어를 또 다른 키(예: `x`)로 매핑해두었다고 가정하자. 이때 발생할 수 있는 "무한 루프(Infinite Loop)" 혹은 "의도치 않은 동작"의 위험성을 `Recursive Mapping`의 개념을 들어 설명해라.**

**실시.**
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