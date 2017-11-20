TARGET := prompt_git_status
SRC_DIR := src
OBJ_DIR := obj
BIN_DIR := ~/bin
SRC_FILES := $(wildcard *.cc)
#OBJ_FILES := $(patsubst $(SRC_DIR)/%.cc,$(OBJ_DIR)/%.o,$(SRC_FILES))
OBJ_FILES := $(patsubst %.cc,$(OBJ_DIR)/%.o,$(SRC_FILES))
CC := clang++
CPPFLAGS := --std=c++17 -O3 -Wall -I.
LDLIBS := -lpthread -lX11
LDFLAGS := -I.

$(BIN_DIR)/$(TARGET): $(OBJ_FILES)
	$(CC) $(CPPFLAGS) -o $@ $^ $(LDLIBS)

$(OBJ_DIR)/%.o: %.cc
#$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cc
	$(CC) $(CPPFLAGS) -c -o $@ $<

.PHONY: clean
clean:
	rm $(OBJ_DIR)/* $(BIN_DIR)/$(TARGET)
