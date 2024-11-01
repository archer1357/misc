OUTDIR = bin
OUTFILE = $(OUTDIR)/dos
CC = gcc

CPPFLAGS :=
LDFLAGS := -lncurses

objs := $(patsubst %.c,$(OUTDIR)/%.o,$(wildcard *.c))
deps := $(objs:.o=.dep)

.PHONY: all test
all: $(OUTFILE)

-include $(deps)

$(OUTDIR)/%.o: %.c
	@mkdir -p $(@D)
	$(CC) $(CPPFLAGS) -c $< -o $@
	@$(CC) $(CPPFLAGS) -MM $< | sed -e '1,1 s|[^:]*:|$@:|' > $(@D)/$*.dep

$(OUTFILE) : $(objs)
	$(CC) $^ $(LDFLAGS) -o $@

test: $(OUTFILE)
	@$(OUTFILE)

clean:
	@rm -f $(deps) $(objs) $(OUTFILE)
	@rmdir --ignore-fail-on-non-empty $(OUTDIR)
