/* minimal TAP: test anything protocol */
/* https://testanything.org/ */

#include <stdio.h>
#include <stdlib.h>

int plan_;		/* number of tests */
int ok_count_;		/* number of passing tests */
int index_;		/* ordinal of current test */
int verbose_;		/* flag: show all expressions */

/* how many tests should run? */
/* set verbose flag if environment var VERBOSE exists */
#define plan(x) do {						\
	plan_ = (x);						\
	if (plan_) {						\
		printf("%d..%d\n", 1, plan_);			\
	}							\
	if (getenv("VERBOSE")) {				\
		verbose_ = 1;					\
	}							\
} while (0)

/* test expression x and keep count of true values */
/* output diagnostic if false or if VERBOSE is set */
#define ok(x) do {						\
	int pass = (x);						\
	char *msg = "not ok";					\
	index_++;						\
	if (pass) {						\
		ok_count_++;					\
		msg += 4;					\
	}							\
	if (verbose_ || !pass) {				\
		printf("%s %d - %s:%d\t%s\n", msg, index_,	\
				__FILE__, __LINE__, #x);	\
	}							\
	else {							\
		printf("%s %d\n", msg, index_);			\
	}							\
} while (0)

/* summarize test run, and return an exit value for main() */
#define grade() ({						\
	int pass;						\
	if (!plan_) {						\
		plan(index_);					\
	}							\
	pass = plan_ == ok_count_;				\
	printf("%s\n", pass ? "PASSED" : "FAILED");		\
	pass ? EXIT_SUCCESS : EXIT_FAILURE;			\
})


/* vim: set ts=8 noet */
