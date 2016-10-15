# Contributions from users/readers after the publication of the paper

[![DOI](https://zenodo.org/badge/20165/fangohr/paper-supplement-ocaml-performance.svg)](https://zenodo.org/badge/latestdoi/20165/fangohr/paper-supplement-ocaml-performance) <a href="http://arxiv.org/abs/1601.07392"><img src="https://img.shields.io/badge/preprint-arxiv:1601.07392-lightgrey.svg" alt="arxiv"></a>
<a href="http://dl.acm.org/citation.cfm?doid=2897676.2897677"><img src="https://img.shields.io/badge/journal-SE4Science-blue.svg" alt="URL"></a>

<br>

Contributions received **after** the publication of
["Nmag micromagnetic simulation tool - software engineering lessons learned"](http://arxiv.org/abs/1601.07392) by Hans Fangohr, Maximilian Albert and Matteo Franchin. In proceedings of the International Workshop on Software Engineering for Science, at ICSE2016 SE4Science '16, 1-7 (2016)

Journal URL: http://dl.acm.org/citation.cfm?doid=2897676.2897677

DOI: doi = 10.1145/2897676.2897677

## Introduction

This branch of the repository is a fork of the master branch and contains
additions and improvements possibly contributed by external parties. While the
master branch is frozen so that it remains consistent with the original
publication, this branch can evolve and incorporate additional
observations and suggestions. For example, we could update this branch to
reflect the state of the latest versions of the OCaml and C/C++ compilers.

## Content of this study

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
