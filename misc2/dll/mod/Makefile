OUT = bin/libMeinMod
OUT_DIR = $(dir $(OUT))
OUT_DLL = $(OUT).dll
OUT_LIB = $(OUT).a

ifeq ($(OS),Windows_NT)
	CC = gcc
else
	CC = i686-w64-mingw32-cc
endif

CPPFLAGS :=
CFLAGS := -I../lua-5.1.5/src
LDFLAGS := -L../lua-5.1.5/src -lgdi32 -luser32 -lkernel32 -static -lpthread -llua

objs := $(patsubst %.cpp,$(OUT_DIR)/%.o,$(wildcard *.cpp))
deps := $(objs:.o=.dep)

.PHONY: all test
all: $(OUT_DLL)

-include $(deps)

$(OUT_DIR)/%.o: %.cpp
	@mkdir -p $(@D)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@
	@$(CC) $(CPPFLAGS) -MM $< | sed -e '1,1 s|[^:]*:|$@:|' > $(@D)/$*.dep

$(OUT_DLL) : $(objs)
	$(CC) $^ $(LDFLAGS) -o $@ -Wl,--out-implib,$(OUT_LIB) -shared -Wl,-soname,libMeinMod.so.1
	cp -f $@ ../test/
	cp -f $@ ../test2/

clean:
	@rm -f $(deps) $(objs) $(OUT_DLL) $(OUT_LIB)
	@rmdir --ignore-fail-on-non-empty $(OUT_DIR)
