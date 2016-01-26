# Multi-dimensional arrays

Example testing performance of multi-dimensional arrays in OCaml and C.  We
create an array of rank-3 tensors of size 3x3x3, populate them with some
numbers and then compute the square root of the average of the squares of all
the tensors entries.

This directory contains 3 programs that do this, but using different
language/representation of multi-dimensional arrays:

1. `array_test.ml`: OCaml code, where the tensor array is an array of arrays of
    arrays...

2. `bigarray_test.ml`: OCaml code where we use a `Bigarray.Genarray`.

3. `carray_test.cc`: C++ code where we use a regular C array.

The three programs are compiled with OCaml 4.01.0 and gcc 5.2.1.
The output of running make (on an Intel Core i5-6600 processor running at
3.3 GHz) is the following:

    ocamlfind ocamlopt -package unix -S -linkpkg array_test.ml -o array_test
    ocamlfind ocamlopt -package unix,bigarray -linkpkg bigarray_test.ml -o bigarray_test
    g++ -std=c++11 -Wall -O3 carray_test.cc -o carray_test

    time ./array_test
    Sum is 0.595922
    Create time 1.03602 s
      Init time 0.696919 s
       Sum time 0.079427 s
    1.72user 0.10system 0:01.82elapsed 99%CPU (0avgtext+0avgdata 429080maxresident)k
    0inputs+0outputs (0major+105119minor)pagefaults 0swaps

    time ./bigarray_test
    Sum is 0.595922
    Create time 3.09944e-06 s
      Init time 0.872199 s
       Sum time 0.392411 s
    1.24user 0.02system 0:01.26elapsed 99%CPU (0avgtext+0avgdata 215564maxresident)k
    0inputs+0outputs (0major+1258minor)pagefaults 0swaps

    time ./carray_test
    Sum is 0.595922
    Create time 4.05312e-06 s
      Init time 0.36247 s
       Sum time 0.0322895 s
    0.36user 0.02system 0:00.39elapsed 100%CPU (0avgtext+0avgdata 213880maxresident)k
    0inputs+0outputs (0major+745minor)pagefaults 0swaps

It can be seen that using regular OCaml arrays (1) is very slow in the creation
phase (~1 s) while both bigarrays (2) and C arrays (3) are very fast. On the
other hand regular OCaml arrays (1) are faster to initialise and much faster to
access than bigarrays (2). The overall outcome is that the C example runs in
about 0.4 s while the OCaml examples run in about 1.8 s (1) and 1.3 s
(2). Crucially, access time for bigarrays is more than an order of magnitude
greater than for C, while using regular OCaml arrays introduces setup time
delays that are simply not present in the other programs (2 and 3).
