LISP := sbcl

.PHONY: test
test:
	$(LISP) --load test/run.lisp
