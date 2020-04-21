# the path to be indexed (default: ..)
# Directory indexing includes subdirectories.
#SOURCE = /path/to/c-file-or-directory

# arguments given to the compiler (default: see the included file)
#CFLAGS =

# include directories given to the compiler (default: none)
#INCLUDE = $(SOURCE)/include ../include

# the default goal (default: help)
# Set to build or test as desired.
#.DEFAULT_GOAL := build

# names of unit test programs
# Values based on test source file names will be dynamically added.
#TESTS =

# functions to dump into separate source files
# Values based on test source file names will be dynamically added.
#FUNCTIONS = a_private_func

# additional header dependencies for all tests
#COMMON = common.h

# Changes to the above variables should remain above this include.
include Mock4thewin.mk

# additional dependencies for all tests
#$(TESTS): foo.o

# additional dependency for a specific test
#api_func.c: a_private_func.c
