# Memory-unintensive summation

In this example we carry out the same computation that was carried out in the
array-sum example, except that the summation is done without storing the
values in RAM. Also, the initial values are generated using a provided
function, rather than just calling the sin function. These changes make this
example less affected by memory bandwith problems than the array-sum example.

This directory contains 2 programs that do this in Ocaml and C++:

1. `array_test.ml`: OCaml code

2. `carray_test.cc`: C++ code

The two programs are compiled with OCaml 4.01.0 and gcc 5.2.1.
The output of running make (on an Intel Core i5-6600 processor running at
3.3 GHz) is the following:

    ocamlfind ocamlopt -package unix -S -linkpkg array_test.ml -o array_test
    g++ -std=c++11 -Wall -O3 carray_test.cc -o carray_test
    time ./array_test
    Diff is 1.27826
    Sum time 2.83848 s
    2.83user 0.00system 0:02.83elapsed 99%CPU (0avgtext+0avgdata 4568maxresident)k
    0inputs+0outputs (0major+646minor)pagefaults 0swaps
    time ./carray_test
    Diff is 1.27826
    Sum time 0.678228s
    0.67user 0.00system 0:00.67elapsed 99%CPU (0avgtext+0avgdata 3252maxresident)k
    0inputs+0outputs (0major+128minor)pagefaults 0swaps

The OCaml example takes 4.2 times longer to perform the summation than the C++
code.