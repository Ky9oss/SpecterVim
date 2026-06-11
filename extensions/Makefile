# gcc -shared -fPIC -O2 -Wall -o mylib.so mylib.c
INCLUDE_DIR = $(realpath ./include)
LIB_DIR     = $(realpath ../lib)
BIN_DIR     = $(realpath ../bin)
SRC_DIR     = $(realpath ./src)

# INCOMPLETE      = $(SRC_DIR)/spl_last.c $(SRC_DIR)/spl_ls.c

vpath %.c $(SRC_DIR)
vpath %.h $(INCLUDE_DIR)

SRCS       = $(wildcard $(SRC_DIR)/*.c)
SHARES     = $(wildcard $(SRC_DIR)/share/*.c)

ELFS       = $(filter-out $(patsubst $(SRC_DIR)/%.c,%,$(INCOMPLETE)),$(patsubst $(SRC_DIR)/%.c,%,$(SRCS)))
SHARED_OBJ = $(patsubst $(SRC_DIR)/share/%.c,lib%.so,$(SHARES))

CC         = gcc-15
CFLAGS    += -Wall -g
SO_CFLAGS  = -shared -fPIC -O2 -Wall -fvisibility=hidden

LIBS_CFLAGS = -L$(LIB_DIR) -lmylib

ASMS       = $(patsubst $(SRC_DIR)/%.c,%.s,$(SRCS))
ASMFLAGS   = -S -masm=intel -fno-asynchronous-unwind-tables -fno-exceptions

ADDERSS_SANITIZER_FALGS += -g3 -fno-omit-frame-pointer -fno-common -fsanitize=address

all: $(ELFS) 

asm: $(ASMS)

so: $(SHARED_OBJ)

%.s:%.c
	$(CC) $(CFLAGS) $(ASMFLAGS) -I$(INCLUDE_DIR) $< $(LIBS_CFLAGS) -o $(BIN_DIR)/$@

lib%.so:share/%.c
	$(CC) $(SO_CFLAGS) -I$(INCLUDE_DIR) $< $(LIBS_CFLAGS) -o $(LIB_DIR)/$@

# $< is the source file. $@ is the target file.
%:%.c
	$(CC) $(CFLAGS) -I$(INCLUDE_DIR) $< $(LIBS_CFLAGS) -o $(BIN_DIR)/$@
	# $(CC) $(CFLAGS) $(ADDERSS_SANITIZER_FALGS) -I$(INCLUDE_DIR) -L$(LIB_DIR) $< -lspl -o $(BIN_DIR)/$@-asan

clean:
	-rm -f $(BIN_DIR)/$(ELFS)
	-rm -f $(LIB_DIR)/$(SHARED_OBJ)

.PHONY: all clean asm so
