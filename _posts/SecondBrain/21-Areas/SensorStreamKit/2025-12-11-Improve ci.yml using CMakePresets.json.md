---
layout: post
title: Improve ci.yml using CMakePresets.json
subtitle:
categories: Programming
status: published
tags:
  - robotics
  - cmake
  - workflow
  - embedded
  - cpp
---
2025-12-11 13:25

Tags: [[study]], [[build-environment]]

# Streamlining CI/CD with Modern CMake Presets

When comparing the new `ci.yml` and `CMakePresets.json` files against the older `ci-prev.yml`, one improvement stands out: **complex command-line arguments have been replaced with reusable presets, dramatically simplifying and standardizing the CI pipeline**. This shift leverages **Modern CMake’s Presets feature**, bringing clarity, consistency, and maintainability to the workflow.

---

## I. Fundamental Improvements Through CMake Presets

In the legacy `ci-prev.yml`, every CMake variable—such as `-DCMAKE_BUILD_TYPE` or `-DCMAKE_TOOLCHAIN_FILE`—was defined manually inside the CI script. The new approach moves this complexity into `CMakePresets.json`, where reusable presets encapsulate all configuration details.

- **Centralized Build Settings & Reproducibility**  
  Presets ensure every team member shares the same build environment, guaranteeing consistency and reproducibility. A hidden base preset (`ci-base`) defines common properties such as the Ninja generator, VCPKG toolchain path, and flags for building tests and examples. All other presets inherit from this base, reducing duplication.

- **Simplified CLI Usage**  
  Instead of typing long, error-prone command lines, builds can now be invoked with a single command:  
  ```
  cmake --preset <name>
  ```

---

## II. Job-Specific Enhancements in CI/CD

| Job | Legacy (`ci-prev.yml`) | Improved (`ci.yml` + Presets) |
|-----|------------------------|-------------------------------|
| **Build Matrix** | Hardcoded options like `cmake -B build -DCMAKE_BUILD_TYPE=${{ matrix.build_type }} ...` | Simplified to `cmake --preset ${{ matrix.preset }}` and `cmake --build --preset ${{ matrix.preset }}`, with build type and binary directory automatically resolved. |
| **Code Coverage** | Coverage flags manually injected into `CMAKE_CXX_FLAGS`. | A dedicated `coverage` preset encapsulates flags and sets `Debug` mode. Examples are disabled to optimize build and reporting time. |
| **Static Analysis** | Manual invocation of `cmake -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON`. | An `analysis` preset defines `CMAKE_EXPORT_COMPILE_COMMANDS: ON` and disables tests/examples, speeding up `compile_commands.json` generation. |

---

## III. Clearer Test Execution Environment

Previously, tests required explicit working-directory settings and manual `ctest` calls. The new workflow uses:

```
ctest --preset ${{ matrix.preset }}
```

This leverages **testPresets** in `CMakePresets.json`:

- **Linking Build & Test Configurations**  
  Each test preset references its corresponding configure preset (e.g., `"configurePreset": "debug"`), ensuring CMake knows exactly which binaries to test.

- **Standardized Output**  
  With `"outputOnFailure": true`, detailed logs appear only when tests fail, keeping CI logs concise and readable.

---

## IV. Coverage Implementation Best Practices

The updated pipeline also integrates industry-standard practices for coverage:

1. **Dedicated Coverage Job**  
   Coverage builds are separated from release builds, using `Debug` mode to ensure accurate instrumentation.

2. **Compiler Flags Encapsulated in Presets**  
   Coverage flags (`--coverage -fprofile-arcs -ftest-coverage`) are defined inside the `coverage` preset, not hardcoded in CI scripts.

3. **Accurate Reporting with lcov**  
   - `lcov --capture` consolidates `.gcda` and `.gcno` files into a single report.  
   - `lcov --remove` excludes system headers and external libraries, focusing coverage on project code.

4. **Codecov Integration**  
   The pipeline uses `codecov/codecov-action@v4` to upload results, simplifying authentication and report publishing.

---

## Conclusion

By adopting **Modern CMake Presets**, the SensorStreamKit CI/CD pipeline has evolved into a cleaner, more maintainable system. Presets centralize build settings, eliminate redundant command-line arguments, and ensure reproducibility across environments. Combined with best practices for coverage and analysis, this workflow exemplifies how modern tooling can transform CI/CD pipelines into efficient, reliable processes.

---

Would you like me to also shape this into a **step-by-step tutorial style** (with code snippets and “how to apply this in your own project” sections), or keep it as a **case study narrative**? Both could work well depending on your target audience.
## References
- CMake --preset: 더 이상 길고 복잡한 빌드 명령어에 시달리지 말자: https://craftsmanship.tistory.com/m/125
- Building with CMake Presets: https://mcuoneclipse.com/2023/12/03/building-with-cmake-presets/
