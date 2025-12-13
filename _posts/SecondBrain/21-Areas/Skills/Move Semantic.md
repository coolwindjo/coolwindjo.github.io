---
layout: post
title: Move Semantic
categories: Programming
status: in-progress
tags:
  - cpp
---
2025-12-12 20:56

Tags: [[programming]]

# Move Semantic

Welcome to Opus 4.5

  

> Refering to "https://claude.ai/chat/a19516ad-449a-4ae2-9a29-93d4dc3fb411", please make vscode project for practicing 

Modern C++ Move Semantics and Zero-Copy pattern. 

  

⏺ I don't have access to external URLs like Claude.ai chat links - I can only work with files and URLs that I can fetch

  content from. That chat URL is a private conversation that I cannot access.

  

  However, I can help you create a VSCode project for practicing Modern C++ Move Semantics and Zero-Copy patterns. Let me

   set this up for you.

  

⏺ **Bash**(mkdir -p cpp_move_semantics/{src,.vscode,include})

  ⎿  Interrupted · What should Claude do instead?

  

> # Modern C++ Move Semantics와 Zero-Copy 패턴

  

네, Modern C++의 move semantics는 FPGA의 direct memory mapping과 **개념적으로 유사**합니다. 하지만 목적과 레벨이 

다릅니다.

  

## 1. 개념적 유사성

  

### **FPGA Direct Memory Mapping (하드웨어 레벨)**

```cpp

// FPGA가 작성한 데이터를 V3H가 "그대로" 접근

float* feature_map = fpga_get_feature_map();  // 포인터만 얻음, 복사 없음

v3h_dma_transfer(feature_map, ...);           // 원본 메모리 직접 사용

```

  

### **C++ Move Semantics (소프트웨어 레벨)**

```cpp

// 데이터를 "옮기기만" 하고 복사 안 함

std::vector<float> feature_map = create_large_data();  // 원본 생성

auto moved_map = std::move(feature_map);               // 소유권 이전, 복사 없음

```

  

## 2. Move Semantics를 활용한 Zero-Copy 구현

  

### **예제 1: Feature Map 전달**

  

```cpp

#include <vector>

#include <memory>

#include <iostream>

  

class FeatureMap {

private:

    std::vector<float> data_;

    size_t width_;

    size_t height_;

    size_t channels_;

public:

    // Constructor

    FeatureMap(size_t w, size_t h, size_t c) 

        : width_(w), height_(h), channels_(c) {

        data_.resize(w * h * c);

        std::cout << "FeatureMap created: " << data_.size() * sizeof(float) 

                  << " bytes\n";

    }

    // Move constructor (복사 없이 소유권 이전)

    FeatureMap(FeatureMap&& other) noexcept 

        : data_(std::move(other.data_)),  // vector의 내부 포인터만 이동

          width_(other.width_),

          height_(other.height_),

          channels_(other.channels_) {

        std::cout << "FeatureMap moved (zero-copy)\n";

    }

    // Move assignment

    FeatureMap& operator=(FeatureMap&& other) noexcept {

        if (this != &other) {

            data_ = std::move(other.data_);

            width_ = other.width_;

            height_ = other.height_;

            channels_ = other.channels_;

            std::cout << "FeatureMap move-assigned (zero-copy)\n";

        }

        return *this;

    }

    // Delete copy operations (복사 방지)

    FeatureMap(const FeatureMap&) = delete;

    FeatureMap& operator=(const FeatureMap&) = delete;

    float* data() { return data_.data(); }

    const float* data() const { return data_.data(); }

    size_t size() const { return data_.size(); }

};

  

// FPGA 시뮬레이션 (데이터 생성)

class FPGASimulator {

public:

    // RVO (Return Value Optimization)과 결합

    static FeatureMap extract_features(const std::vector<uint8_t>& image) {

        FeatureMap fm(512, 512, 64);  // 대용량 데이터

        // Edge detection, feature extraction 시뮬레이션

        float* data = fm.data();

        for (size_t i = 0; i < fm.size(); ++i) {

            data[i] = static_cast<float>(i % 256) / 255.0f;

        }

        return fm;  // Move semantics 자동 적용 (RVO)

    }

};

  

// V3H IMP/CVe 처리 시뮬레이션

class V3HProcessor {

public:

    // Move semantics로 데이터 받기

    float process_tunnel_detection(FeatureMap&& fm) {

        std::cout << "Processing " << fm.size() << " elements\n";

        // Matrix 연산 시뮬레이션

        float result = 0.0f;

        const float* data = fm.data();

        for (size_t i = 0; i < std::min(fm.size(), size_t(1000)); ++i) {

            result += data[i];

        }

        return result / 1000.0f;

    }

};

  

// 사용 예제

int main() {

    std::vector<uint8_t> camera_image(640 * 480, 128);

    // Step 1: FPGA에서 feature 추출 (RVO로 zero-copy)

    FeatureMap features = FPGASimulator::extract_features(camera_image);

    // Step 2: V3H로 전달 (move로 zero-copy)

    V3HProcessor v3h;

    float tunnel_probability = v3h.process_tunnel_detection(std::move(features));

    std::cout << "Tunnel probability: " << tunnel_probability << "\n";

    // features는 이제 비어있음 (moved-from state)

    return 0;

}

```

  

### **출력:**

```

FeatureMap created: 67108864 bytes

FeatureMap moved (zero-copy)

Processing 16777216 elements

Tunnel probability: 0.499512

```

  

## 3. 더 현실적인 Zero-Copy 패턴

  

### **예제 2: Shared Pointer를 활용한 소유권 공유**

  

```cpp

#include <memory>

#include <vector>

  

class SharedFeatureMap {

private:

    std::shared_ptr<std::vector<float>> data_;

public:

    explicit SharedFeatureMap(size_t size) 

        : data_(std::make_shared<std::vector<float>>(size)) {}

    // 복사 없이 소유권 공유

    SharedFeatureMap share() const {

        SharedFeatureMap copy;

        copy.data_ = data_;  // reference count만 증가

        return copy;

    }

    float* data() { return data_->data(); }

    size_t size() const { return data_->size(); }

private:

    SharedFeatureMap() = default;

};

  

// FPGA와 V3H가 동시에 접근 가능 (읽기 전용)

void process_pipeline() {

    SharedFeatureMap fpga_output(512 * 512 * 64);

    // FPGA가 데이터 작성

    // ...

    // V3H IMP가 접근 (복사 없음)

    auto imp_input = fpga_output.share();

    // V3H CVe도 접근 (복사 없음)

    auto cve_input = fpga_output.share();

    // 모두 같은 메모리를 가리킴

    assert(imp_input.data() == cve_input.data());

}

```

  

## 4. std::span을 활용한 Non-owning View (C++20)

  

```cpp

#include <span>

#include <vector>

#include <array>

  

class FeatureMapView {

public:

    // Non-owning view (메모리 소유 안 함, 참조만)

    explicit FeatureMapView(std::span<float> data) : data_(data) {}

    // 원본 데이터 직접 접근

    float* data() { return data_.data(); }

    size_t size() const { return data_.size(); }

    // Sub-view 생성 (zero-copy)

    FeatureMapView subview(size_t offset, size_t count) {

        return FeatureMapView(data_.subspan(offset, count));

    }

private:

    std::span<float> data_;

};

  

void process_with_span() {

    // FPGA의 메모리 영역

    std::vector<float> fpga_memory(512 * 512 * 64);

    // View 생성 (복사 없음, 포인터만)

    FeatureMapView full_view(fpga_memory);

    // IMP가 일부 채널 처리

    auto imp_view = full_view.subview(0, 512 * 512 * 32);

    // CVe가 나머지 채널 처리

    auto cve_view = full_view.subview(512 * 512 * 32, 512 * 512 * 32);

    // 병렬 처리 가능

}

```

  

## 5. FPGA Direct Memory Mapping을 흉내낸 구현

  

```cpp

#include <sys/mman.h>

#include <fcntl.h>

#include <cstring>

#include <stdexcept>

  

class DirectMemoryMapper {

private:

    void* mapped_addr_;

    size_t size_;

    int fd_;

public:

    // FPGA의 물리 메모리 영역을 직접 매핑 (Linux 예제)

    DirectMemoryMapper(uintptr_t phys_addr, size_t size) 

        : size_(size) {

        fd_ = open("/dev/mem", O_RDWR | O_SYNC);

        if (fd_ < 0) {

            throw std::runtime_error("Cannot open /dev/mem");

        }

        mapped_addr_ = mmap(

            nullptr,

            size,

            PROT_READ | PROT_WRITE,

            MAP_SHARED,

            fd_,

            phys_addr

        );

        if (mapped_addr_ == MAP_FAILED) {

            close(fd_);

            throw std::runtime_error("mmap failed");

        }

    }

    ~DirectMemoryMapper() {

        if (mapped_addr_ != MAP_FAILED) {

            munmap(mapped_addr_, size_);

        }

        if (fd_ >= 0) {

            close(fd_);

        }

    }

    // Zero-copy access

    template<typename T>

    T* as() {

        return static_cast<T*>(mapped_addr_);

    }

    // Move-only type

    DirectMemoryMapper(DirectMemoryMapper&& other) noexcept

        : mapped_addr_(other.mapped_addr_),

          size_(other.size_),

          fd_(other.fd_) {

        other.mapped_addr_ = MAP_FAILED;

        other.fd_ = -1;

    }

    DirectMemoryMapper(const DirectMemoryMapper&) = delete;

};

  

// 사용 예제 (실제 FPGA 메모리 접근)

void access_fpga_memory() {

    constexpr uintptr_t FPGA_BASE_ADDR = 0x80000000;

    constexpr size_t FEATURE_MAP_SIZE = 512 * 512 * 64 * sizeof(float);

    // FPGA 메모리 영역을 프로세스 주소공간에 매핑

    DirectMemoryMapper mapper(FPGA_BASE_ADDR, FEATURE_MAP_SIZE);

    // Zero-copy access

    float* fpga_features = mapper.as<float>();

    // V3H DMA에 직접 전달 (복사 없음)

    v3h_dma_transfer(fpga_features, ...);

}

```

  

## 6. 비교표

  

| 특징 | FPGA Direct Mapping | C++ Move Semantics |

|------|-------------------|-------------------|

| **레벨** | 하드웨어/메모리 | 소프트웨어/객체 |

| **목적** | 물리 메모리 공유 | 객체 소유권 이전 |

| **복사 방지** | 포인터만 전달 | 내부 포인터 이동 |

| **적용 범위** | FPGA ↔ CPU | 함수/객체 간 |

| **성능** | 진짜 zero-copy | 거의 zero-copy |

| **안전성** | 동기화 필요 | RAII로 안전 |

  

## 7. 실전 조합 예제

  

```cpp

// FPGA direct mapping + C++ move semantics

class TunnelDetector {

private:

    DirectMemoryMapper fpga_mapper_;

public:

    TunnelDetector() 

        : fpga_mapper_(FPGA_ADDR, FPGA_SIZE) {}

    // FPGA 데이터를 zero-copy로 가져와서 처리

    float detect() {

        // Step 1: FPGA 메모리 직접 접근 (zero-copy)

        float* fpga_data = fpga_mapper_.as<float>();

        // Step 2: std::span으로 view 생성 (zero-copy)

        std::span<float> feature_view(fpga_data, FEATURE_SIZE);

        // Step 3: V3H로 move (zero-copy)

        return process_on_v3h(std::move(feature_view));

    }

private:

    float process_on_v3h(std::span<float> features) {

        // DMA transfer (원본 포인터 사용)

        v3h_dma_transfer(features.data(), ...);

        // IMP/CVe processing

        return run_cnn(features);

    }

};

```

  

## 결론

  

**Move semantics는 FPGA direct mapping의 소프트웨어 버전**입니다:

  

1. **FPGA → V3H**: 물리 메모리 공유 (하드웨어 zero-copy)

2. **C++ Move**: 객체 소유권 이전 (소프트웨어 zero-copy)

3. **조합**: Direct mapping으로 메모리 접근 + Move semantics로 안전한 전달

  

Move semantics만으로는 FPGA의 direct mapping을 완벽히 대체할 수 없지만, **소프트웨어 계층에서 불필요한 복사를 제거**하는 

데 매우 유용합니다! 🎯please make vscode project for practicing 

Modern C++ Move Semantics and Zero-Copy pattern. 

  

⏺ 이해했습니다! 제공해주신 내용을 바탕으로 Modern C++ Move Semantics와 Zero-Copy 패턴을 연습할 수 있는 VSCode 프로젝트를

  만들어 드리겠습니다.

  

⏺ **Bash**(mkdir -p cpp_move_semantics_practice/{src,include,.vscode})

  ⎿  (No content)

  

⏺ **Write**(cpp_move_semantics_practice/CMakeLists.txt)

  ⎿  Wrote **23** lines to **cpp_move_semantics_practice/CMakeLists.txt**

     cmake_minimum_required(VERSION 3.20)

     project(MoveSemanticsPractice LANGUAGES CXX)

     set(CMAKE_CXX_STANDARD 20)

     set(CMAKE_CXX_STANDARD_REQUIRED ON)

     set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

     # Compiler warnings

     if(CMAKE_CXX_COMPILER_ID MATCHES "Clang|GNU")

         add_compile_options(-Wall -Wextra -Wpedantic -Wmove)

     … +13 lines (ctrl+o to expand)

  

⏺ **Write**(cpp_move_semantics_practice/src/01_basic_move.cpp)

  ⎿  Wrote **278** lines to **cpp_move_semantics_practice/src/01_basic_move.cpp**

     /**

      * 01_basic_move.cpp

      *

      * Move Semantics 기초 - lvalue, rvalue, std::move의 이해

      *

      * 학습 목표:

      * 1. lvalue와 rvalue의 차이 이해

      * 2. std::move의 동작 원리

      * 3. Move constructor와 Move assignment operator

      */

     … +268 lines (ctrl+o to expand)

  

⏺ **Write**(cpp_move_semantics_practice/src/02_feature_map.cpp)

  ⎿  Wrote **322** lines to **cpp_move_semantics_practice/src/02_feature_map.cpp**

     /**

      * 02_feature_map.cpp

      *

      * FPGA -> V3H 파이프라인에서 사용되는 FeatureMap 클래스

      * Move Semantics를 활용한 Zero-Copy 구현

      *

      * 학습 목표:

      * 1. 실제 시나리오에서의 Move Semantics 적용

      * 2. RVO (Return Value Optimization) 이해

      * 3. Move-only 타입 설계

     … +312 lines (ctrl+o to expand)

  

⏺ **Write**(cpp_move_semantics_practice/src/03_shared_feature_map.cpp)

  ⎿  Wrote **347** lines to **cpp_move_semantics_practice/src/03_shared_feature_map.cpp**

     /**

      * 03_shared_feature_map.cpp

      *

      * shared_ptr를 활용한 소유권 공유 패턴

      * 여러 프로세서가 동시에 같은 데이터에 접근해야 할 때 유용

      *

      * 학습 목표:

      * 1. std::shared_ptr로 소유권 공유

      * 2. std::weak_ptr로 순환 참조 방지

      * 3. std::make_shared의 장점

     … +337 lines (ctrl+o to expand)

  

⏺ **Write**(cpp_move_semantics_practice/src/04_span_view.cpp)

  ⎿  Wrote **347** lines to **cpp_move_semantics_practice/src/04_span_view.cpp**

     /**

      * 04_span_view.cpp

      *

      * std::span을 활용한 Non-owning View (C++20)

      * 메모리를 소유하지 않고 참조만 하는 경량 뷰

      *

      * 학습 목표:

      * 1. std::span의 개념과 사용법

      * 2. Non-owning view의 장점

      * 3. 다양한 컨테이너와의 호환성

     … +337 lines (ctrl+o to expand)

  

⏺ **Write**(cpp_move_semantics_practice/src/05_direct_memory_mapper.cpp)

  ⎿  Wrote **459** lines to **cpp_move_semantics_practice/src/05_direct_memory_mapper.cpp**

     /**

      * 05_direct_memory_mapper.cpp

      *

      * FPGA Direct Memory Mapping 시뮬레이션

      * 실제 임베디드 환경에서 사용되는 패턴

      *

      * 학습 목표:

      * 1. Memory-mapped I/O 개념 이해

      * 2. RAII로 리소스 관리

      * 3. Move-only 타입 설계

     … +449 lines (ctrl+o to expand)

  

⏺ **Write**(cpp_move_semantics_practice/src/06_complete_pipeline.cpp)

  ⎿  Wrote **505** lines to **cpp_move_semantics_practice/src/06_complete_pipeline.cpp**

     /**

      * 06_complete_pipeline.cpp

      *

      * FPGA -> V3H 완전한 파이프라인 시뮬레이션

      * 모든 Zero-Copy 패턴을 종합한 예제

      *

      * 학습 목표:

      * 1. 실제 시나리오에서 패턴 조합

      * 2. Pipeline 아키텍처 설계

      * 3. 성능 최적화 전략

     … +495 lines (ctrl+o to expand)

  

⏺ **Write**(cpp_move_semantics_practice/.vscode/tasks.json)

  ⎿  Wrote **92** lines to **cpp_move_semantics_practice/.vscode/tasks.json**

     {

         "version": "2.0.0",

         "tasks": [

             {

                 "label": "CMake Configure",

                 "type": "shell",

                 "command": "cmake",

                 "args": [

                     "-B",

                     "${workspaceFolder}/build",

     … +82 lines (ctrl+o to expand)

  

⏺ **Write**(cpp_move_semantics_practice/.vscode/launch.json)

  ⎿  Wrote **60** lines to **cpp_move_semantics_practice/.vscode/launch.json**

     {

         "version": "0.2.0",

         "configurations": [

             {

                 "name": "01_basic_move",

                 "type": "lldb",

                 "request": "launch",

                 "program": "${workspaceFolder}/build/01_basic_move",

                 "args": [],

                 "cwd": "${workspaceFolder}",

     … +50 lines (ctrl+o to expand)

  

⏺ **Write**(cpp_move_semantics_practice/.vscode/settings.json)

  ⎿  Wrote **17** lines to **cpp_move_semantics_practice/.vscode/settings.json**                   

     {

         "cmake.configureOnOpen": true,

         "cmake.buildDirectory": "${workspaceFolder}/build",

         "C_Cpp.default.configurationProvider": "ms-vscode.cmake-tools",

         "C_Cpp.default.cppStandard": "c++20",

         "C_Cpp.default.compileCommands": "${workspaceFolder}/build/compile_commands.json",

         "editor.formatOnSave": true,

         "editor.tabSize": 4,

         "files.associations": {

             "*.h": "cpp",

     … +7 lines (ctrl+o to expand)

  

⏺ **Write**(cpp_move_semantics_practice/.vscode/c_cpp_properties.json)

  ⎿  Wrote **35** lines to **cpp_move_semantics_practice/.vscode/c_cpp_properties.json**

     {

         "configurations": [

             {

                 "name": "Mac",

                 "includePath": [

                     "${workspaceFolder}/**",

                     "${workspaceFolder}/include"

                 ],

                 "defines": [],

                 "macFrameworkPath": [

     … +25 lines (ctrl+o to expand)

  

⏺ **Write**(cpp_move_semantics_practice/README.md)
  ⎿  Wrote **108** lines to **cpp_move_semantics_practice/README.md**                                               

     # Modern C++ Move Semantics & Zero-Copy Practice

     FPGA -> V3H 파이프라인 시나리오를 기반으로 한 Modern C++ Move Semantics 및 Zero-Copy 패턴 학습 프로젝트

     ## 요구사항

     - C++20 지원 컴파일러 (Clang 14+, GCC 10+)
     - CMake 3.20+
     - VSCode + CMake Tools Extension (선택사항)
     … +98 lines (ctrl+o to expand)

  

⏺ 빌드 테스트를 해보겠습니다:

⏺ **Bash**(cd /Users/josh/workspace/sandbox/claude_code/cpp_move_semantics_practice && cmake -B build -S . 2>&1)

  ⎿  Error: Exit code 127

     (eval):1: command not found: cmake

⏺ **Bash**(which cmake || brew --prefix cmake 2>/dev/null || echo "CMake not installed")

  ⎿  cmake not found        

     /opt/homebrew/opt/cmake

⏺ **Bash**(cd /Users/josh/workspace/sandbox/claude_code/cpp_move_semantics_practice && /opt/homebrew/opt/cmake/bin/cmake -B build

       -S . 2>&1)

  ⎿  Error: Exit code 127

     (eval):1: no such file or directory: /opt/homebrew/opt/cmake/bin/cmake

⏺ **Bash**(ls -la /opt/homebrew/opt/cmake/ 2>/dev/null || ls -la /usr/local/bin/cmake 2>/dev/null || echo "CMake binary not

      found")

  ⎿  CMake binary not found

⏺ CMake가 설치되어 있지 않은 것 같습니다. 프로젝트는 완성되었으니 구조를 확인해 드리겠습니다:

⏺ **Bash**(find /Users/josh/workspace/sandbox/claude_code/cpp_move_semantics_practice -type f | head -20)

  ⎿  /Users/josh/workspace/sandbox/claude_code/cpp_move_semantics_practice/CMakeLists.txt       
     /Users/josh/workspace/sandbox/claude_code/cpp_move_semantics_practice/README.md

     /Users/josh/workspace/sandbox/claude_code/cpp_move_semantics_practice/.vscode/settings.json

     … +9 lines (ctrl+o to expand)

⏺ 프로젝트가 완성되었습니다. 생성된 프로젝트 구조:

  cpp__move__semantics__practice/_

  _├── CMakeLists.txt_
  _├── README.md_
  _├── .vscode/_
  _│   ├── settings.json_
  _│   ├── c__cpp__properties.json_
  _│   ├── launch.json_
  _│   └── tasks.json_
  _├── src/_
  _│   ├── 01__basic__move.cpp          # Move Semantics 기초_
  _│   ├── 02__feature__map.cpp         # FeatureMap + RVO_
  _│   ├── 03__shared__feature__map.cpp  # shared__ptr 패턴_
  _│   ├── 04__span__view.cpp           # std::span (C++20)_
  _│   ├── 05__direct__memory__mapper.cpp # FPGA Memory Mapping
  │   └── 06__complete__pipeline.cpp   # 전체 파이프라인
  └── include/

  

  **사용 방법**

  cd cpp_move_semantics_practice

  

  # CMake 설치 (필요시)
  brew install cmake

  

  # 빌드

  cmake -B build -S .
  cmake --build build

  

  # 실행

  ./build/01_basic_move
  ./build/02_feature_map

  # ... 등

  

  **각 예제 학습 목표**

  | 파일                      | 주요 개념                                  |
  |-------------------------|----------------------------------------|
  | 01_basic_move           | lvalue/rvalue, std::move, Rule of Five |
  | 02_feature_map          | Move-only 타입, RVO/NRVO                 |
  | 03_shared_feature_map   | shared_ptr, weak_ptr, custom deleter   |
  | 04_span_view            | std::span, non-owning view, subspan    |
  | 05_direct_memory_mapper | Memory mapping, RAII, 메모리 정렬           |
  | 06_complete_pipeline    | Memory Pool, 전체 파이프라인 통합               |

  

  VSCode에서 Cmd+Shift+B로 빌드하고 F5로 디버깅할 수 있습니다.
## References
- [My Obsidian Setup: The King of Note Taking Apps](<www.youtube.com/watch?v=xR5-0XDkwU0>){:target="_blank"} ![](//www.youtube.com/watch?v=xR5-0XDkwU0)