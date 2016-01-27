# Small OCaml performance study

Supplement for manuscript "Nmag micromagnetic simulation tool -- software engineering lessons learned" by Hans Fangohr, Maximilian Albert and Matteo Franchin (2016).

This repository contains some test programs that help investigating the
performance of code emitted by the OCaml compiler (`ocamlopt`) for some of
simple cases which are particularly relevant to numerical code. The tests are
provided in separate directories. Each directory contains the OCaml version and
the C++ version of the same test. Here is a list of the available directories:

1. [`multidim-arrays`](multidim-arrays): test accesses to multi dimensional
   arrays implemented (i) as regular OCaml arrays and (ii) using the `Bigarray`
   OCaml module.

2. [`array-sum`](array-sum): test addition of two large unidimensional arrays.

3. [`summation`](summation): test computation with low memory bandwidth
   requirements

See the README files in the individual subdirectories for more details on
the investigations performed and results obtained.

Matteo Franchin, Maximilian Albert, Hans Fangohr, 2016
