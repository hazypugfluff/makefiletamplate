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

