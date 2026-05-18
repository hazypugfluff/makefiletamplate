# =========================================================
# Toolchain
# =========================================================

CC      := gcc
AR      := ar
RM      := rm -f
MKDIR   := mkdir -p

# =========================================================
# Project metadata
# =========================================================

TARGET  := app
PREFIX  ?= /usr/local
BINDIR  := $(PREFIX)/bin

# Source layout
SRC_DIR := src
INC_DIR := include
BUILD_DIR := build

SRCS := $(wildcard $(SRC_DIR)/*.c)
OBJS := $(SRCS:$(SRC_DIR)/%.c=$(BUILD_DIR)/%.o)
DEPS := $(OBJS:.o=.d)

# =========================================================
# Build configuration
# =========================================================

DEBUG ?= 0

ifeq ($(DEBUG),1)
	CFLAGS   := -Wall -Wextra -O0 -g -DDEBUG
else
	CFLAGS   := -Wall -Wextra -O2
endif

CPPFLAGS := -I$(INC_DIR)
LDFLAGS  :=
LDLIBS   :=

# Dependency generation
CFLAGS += -MMD -MP

# =========================================================
# Parallel build
# =========================================================

NPROCS := $(shell echo $$(( $$(nproc) > 2 ? $$(nproc) - 2 : 1 )))
MAKEFLAGS += -j$(NPROCS)

# =========================================================
# Targets
# =========================================================

.PHONY: all build clean install uninstall run dirs

all: dirs $(TARGET)

build: all

dirs:
	@$(MKDIR) $(BUILD_DIR)

# Link
$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)

# Compile
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

# =========================================================
# Convenience targets
# =========================================================

run: $(TARGET)
	./$(TARGET)

clean:
	$(RM) -r $(BUILD_DIR) $(TARGET)

install: $(TARGET)
	install -d $(DESTDIR)$(BINDIR)
	install -m 755 $(TARGET) $(DESTDIR)$(BINDIR)/$(TARGET)

uninstall:
	$(RM) $(DESTDIR)$(BINDIR)/$(TARGET)

# =========================================================
# Dependencies
# =========================================================

-include $(DEPS)
