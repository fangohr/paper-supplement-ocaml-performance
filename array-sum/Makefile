.PHONY: all clean asm

CFLAGS := -std=c++11 -Wall -O3

all: array_test carray_test carray_test.s
	@echo
	time ./array_test
	@echo
	time ./carray_test

asm: array_test.s carray_test.s

array_test array_test.s: array_test.ml
	ocamlfind ocamlopt -package unix -S -linkpkg array_test.ml -o array_test

carray_test: carray_test.cc
	g++ $(CFLAGS) carray_test.cc -o carray_test

carray_test.s: carray_test.cc
	g++ $(CFLAGS) carray_test.cc -S -o carray_test.s

clean:
	rm -f *.cmi *.cmo *.cmx *.o array_test carray_test
