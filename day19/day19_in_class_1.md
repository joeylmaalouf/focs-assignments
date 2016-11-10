# FOCS Day 19 Activity 1

## 1. Friendship

Enter the following into Racket. This file is also at `https://github.com/focs16fall/focs-assignments/tree/master/day19/friends.dl`.

```
#lang datalog

likes(amy, susan).
likes(susan, amy).
likes(amy, mark).
likes(lola, mark).
likes(brewster, mark).
likes(brewster, lucky).
likes(amy, tyrion).
likes(tyrion, amy).
likes(susan, tyrion).
likes(tyrion, susan).
```

a. Define a predicate `mutual(A, B)` that is true iff A and B like each other. Who are the pairs of mutual friends in this database?

b. Define a predicate `popular(A)` that is true iff at least three people like A. Who is popular?

c. Add a rule whose meaning is that everyone likes themself. How does this affect the meaning of  `popular`?

## 2. Playing peano

Enter the following into Racket. This is also at `https://github.com/focs16fall/focs-assignments/tree/master/day19/peano.dl`.

```
#lang datalog

% model
% s(M, N) means N is the successor of M.
s(0, 1).
s(1, 2).
s(2, 3).
s(3, 4).
s(4, 5).
s(5, 6).

% integers
integer(0).
integer(N) :- s(M, N).

% sum axioms
sum(A, B, C) :- A=C, B=0.
sum(A, SB, SC) :- sum(A, B, C), s(B, SB), s(C, SC).

% product axioms
product(A, B, C) :- integer(A), B=0, C=0.
```

a. Explore. Try `sum(2, 3, 5)?`, `sum(2, 3, 6)?`, `sum(2, 3, N)?`, `sum(2, 3, N)`, `sum(4, 5, N)?`

b. Implement another product axiom, such that `product(2, 3, 6)?` is true.