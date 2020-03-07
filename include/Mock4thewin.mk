prefix = /usr/local
help:
	@echo -e \
	'\nInstructions available at\n\n'\
	'\thttps://github.com/dan4thewin/mock4thewin\n\n'\
	'To start, in the directory where you write your unit tests run:\n\n'\
	'\tmake -f "$(prefix)/include/Mock4thewin.mk" setup\n\n'\
	'Edit the new Makefile to suit your needs.  Then run:\n\n\tmake test\n'

#------------------------------------------------------------------------
# The setup target populates the current directory with links and
# a default Makefile that includes this one.
#
symlinks = Mock4thewin.mk tap.h

setup: Makefile $(symlinks)

$(symlinks):
	ln -fs "$(prefix)/include/$@" .

Makefile:
	cp "$(prefix)/include/Mock4thewin-template.mk" Makefile

#------------------------------------------------------------------------
# See the make section at https://git.io/fjxVo for a description
#
TESTS += $(patsubst %.c,%,$(wildcard test-*.c))
FUNCTIONS += $(patsubst test-%,%,$(TESTS))

temp_src = $(patsubst %,%.c,$(FUNCTIONS))

build: $(TESTS)

test: clean-gcov clean-lcov build
	unit-test-report $(TESTS)

clean-gcov:
	rm -f *.gcov

lcov: test
	lcov --rc lcov_branch_coverage=1 -c -d . -o - 2>&- | stitch-cov index > cov.info
	genhtml -s --branch-coverage cov.info -o html

clean-lcov:
	rm -fr cov.info html

clean: clean-gcov clean-lcov
	rm -f index $(TESTS) $(temp_src) *.gc??

index: $(or $(SOURCE), ..) Makefile
	ctags-xref -R $< > $@

$(temp_src): index
	show-source $(patsubst %.c,%,$@) > $@

CFLAGS_DFLT = -std=c99 -Wall -O0 -ggdb

$(TESTS): test-%: test-%.c %.c tap.h
	$(CC) --coverage $(or $(CFLAGS), $(CFLAGS_DFLT)) $(INCLUDE:%=-I%) $< -o $@

.PHONY: help setup build test clean-gcov lcov clean-lcov clean
