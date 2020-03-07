# mock4thewin
Tools for mocking and unit testing with the C preprocessor

These tools are derived from the document,
_Unit Testing with the C Preprocessor_,
available at https://git.io/fjxVo .
Please refer there for a detailed explanation.

To install run `install` with a destination directory.
For example:

    ./install /usr/local

To start using the makefile and tools, run the `setup`
target with `make`. For example:

    cd ~/work/test
    make -f /usr/local/include/Mock4thewin.mk setup

Edit the newly created `Makefile` as needed.  Write
some unit tests, and finally run:

    make test

The above reports branch coverage using `gcov`.  To see
an annotated copy of the source with branch coverage run:

    make lcov

Note: This project requires tools from
https://github.com/dan4thewin/ctags-xref .
Please build and install those tools first.

Note: This project expects a gcc toolchain on
a modern Linux distribution.
