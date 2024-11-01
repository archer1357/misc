OUTDIR = bin
OUTFILE = $(OUTDIR)/test

CC = gcc
EXT = c

CPPFLAGS :=
CFLAGS :=
LDFLAGS := -lkernel32

objs := $(patsubst %.$(EXT),$(OUTDIR)/%.o,$(wildcard *.$(EXT)))
deps := $(objs:.o=.dep)

.PHONY: all test
all: $(OUTFILE)

-include $(deps)

$(OUTDIR)/%.o: %.$(EXT)
	@mkdir -p $(@D)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@
	@$(CC) $(CPPFLAGS) -MM $< | sed -e '1,1 s|[^:]*:|$@:|' > $(@D)/$*.dep

$(OUTFILE) : $(objs)
	$(CC) $^ $(LDFLAGS) -o $@

test: $(OUTFILE)
	$(OUTFILE)

clean:
	@rm -f $(deps) $(objs) $(OUTFILE)
	@rmdir --ignore-fail-on-non-empty $(OUTDIR)
