# Generic GNU Make C Template

A reusable GNU Make template for small-to-medium C projects.

Designed to provide:
- clean project structure
- automatic dependency tracking
- parallel builds
- debug/release configurations
- install/uninstall targets
- minimal maintenance overhead

---

# Features

- GNU Make based workflow
- Automatic source discovery
- Out-of-tree object builds
- Header dependency generation (`-MMD -MP`)
- Parallel build auto-detection via `nproc`
- Debug and release build modes
- Standard Unix install layout
- Clean separation of:
  - compiler flags
  - preprocessor flags
  - linker flags
  - libraries

---

# Intended Project Layout

```text
project/
├── Makefile
├── include/
│   └── *.h
├── src/
│   └── *.c
└── build/
```

The `build/` directory is generated automatically.

---

# Requirements

- GNU Make
- GCC or compatible C compiler
- POSIX-compatible shell
- `nproc` (GNU coreutils)

---

# Usage

## Build

```bash
make
```

---

## Run

```bash
make run
```

---

## Clean

```bash
make clean
```

---

## Debug Build

```bash
make DEBUG=1
```

Enables:
- `-g`
- `-O0`
- `-DDEBUG`

---

## Install

Default install path:

```text
/usr/local/bin
```

Install:

```bash
sudo make install
```

Custom prefix:

```bash
make PREFIX=$HOME/.local install
```

---

## Uninstall

```bash
sudo make uninstall
```

---

# Build System Overview

## Compiler Variables

| Variable | Purpose |
|---|---|
| `CC` | C compiler |
| `CPPFLAGS` | Preprocessor flags (`-I`, `-D`) |
| `CFLAGS` | Compiler flags |
| `LDFLAGS` | Linker flags |
| `LDLIBS` | Libraries |

---

## Build Modes

### Release (default)

```bash
make
```

Uses:
- `-O2`

### Debug

```bash
make DEBUG=1
```

Uses:
- `-O0`
- `-g`
- `-DDEBUG`

---

# Parallel Build Handling

The template automatically determines an appropriate job count:

```make
NPROCS := $(shell echo $$(( $$(nproc) > 2 ? $$(nproc) - 2 : 1 )))
MAKEFLAGS += -j$(NPROCS)
```

This leaves two logical CPUs free for system responsiveness.

---

# Dependency Tracking

Dependency files are generated automatically using:

```make
-MMD -MP
```

This ensures source files rebuild correctly when headers change.

---

# Example

Minimal source tree:

```text
include/
└── hello.h

src/
└── main.c
```

Build:

```bash
make
```

Run:

```bash
./app
```

---

# Philosophy

This template aims to stay:
- lightweight
- readable
- easily hackable
- framework-free

It is intended as a middle ground between:
- tiny one-file Makefiles
- heavyweight meta-build systems

---

# License
MIT License

Copyright (c) 2026 Joeseph Kerr

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
