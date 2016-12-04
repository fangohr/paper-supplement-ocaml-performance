.PHONY: all clean asm

CFLAGS := -std=c++11 -Wall -O3
RUN_PREFIX := time

all: array_test bigarray_test array_of_bigarrays_test carray_test
	@echo
	$(RUN_PREFIX) ./array_test
	@echo
	$(RUN_PREFIX) ./bigarray_test
	@echo
	$(RUN_PREFIX) ./array_of_bigarrays_test
	@echo
	$(RUN_PREFIX) ./carray_test

asm: array_test.s carray_test.s

array_test array_test.s: array_test.ml
	ocamlfind ocamlopt -package unix -S -linkpkg array_test.ml -o array_test
bigarray_test: bigarray_test.ml
	ocamlfind ocamlopt -unsafe -package unix,bigarray -linkpkg $^ -o $@
array_of_bigarrays_test: array_of_bigarrays_test.ml
	ocamlfind ocamlopt -unsafe -package unix,bigarray -linkpkg $^ -o $@

carray_test: carray_test.cc
	g++ $(CFLAGS) carray_test.cc -o carray_test

carray_test.s: carray_test.cc
	g++ $(CFLAGS) carray_test.cc -S -o carray_test.s

clean:
	rm -f *.cmi *.cmo *.cmx *.o array_test bigarray_test carray_test
	rm -f array_of_bigarrays_test array_test.s

