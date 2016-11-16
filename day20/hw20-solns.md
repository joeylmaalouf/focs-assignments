# FOCS Homework 20

```
Student Name: Solution set
Check one:
[ ] I completed this assignment without assistance or external resources.
[x] I completed this assignment with assistance from teaching staff
   and/or using these external resources: ___
```

## 1. Datalog

a. Consider a dialect of Datalog that includes `not`. [Many implementations include `not`. Racket Datalog does not.] What is value of the query in the following program?

```
likes(amy, susan).
likes(susan, amy).
likes(mark, amy).
unliked(X) :- not likes(Someone, X).
unliked(mark)?
```

True:

1. `likes(Someone, mark)` fails to match any of the facts `likes(amy, susan)`, `likes(susan, amy)`, `likes(mark, amy)` because in none of these cases is the second argument == `mark`.
2. By [negation as failure](https://en.wikipedia.org/wiki/Negation_as_failure), `not likes(Someone, mark)` therefore succeeds.
3. Therefore `not likes(Someone, X)` succeeds when `X == mark ` .
4. Therefore  `unliked(mark)` succeeds.

b. How about after extending this program with the following fact?

```
likes(amy, mark).
unliked(mark)?
```

1. `likes(Someone, mark)` succeed with `Someone = amy`
2. By negation as failure, `not likes(Someone, mark)` fails
3. Therefore `unliked(mark)` fails.

c. Is Datalog NP-Complete?

[This should have been a challenge question; discussion without full answer follows…]

NP-complete is a predicate that is true of a decision problem (a parameterized question with a yes/no answer). The evident decision problem for Datalog is: for a given program and query (the parameters), does the query succeed (the yes/no answer).

A problem is NP-complete if it's both in NP, and is NP-hard.

A problem X is NP-hard if for any NP problem Y there's a polynomial-time reduction from Y to X. This turns out to be the same requirement as the condition that exists some NP-complete problem that has a polynomial-time reduction to X. Datalog is NP-hard if some NP-complete problem can be written as a Datalog program. An example is SAT. A SAT solver can be written in Datalog.

A problem is in NP if it can provide a certificate (proof) of any "yes" answer, that can be verified in deterministic polynomial time. For Datalog to be in NP, there must be a polynomial-time verifiable proof of the success for any query. 

One candidate for a certificate is the search (proof) tree. If the search tree is polynomial on the size of the program, it can be verified in time polynomial to the size of the program.

## 2. SQL

Consider the tables `college` and `town`:

| college_name | students | town_name |
| ------------ | -------- | --------- |
| Babson       | 2840     | Needham   |
| Olin         | 350      | Needham   |
| Wellesley    | 2474     | Wellesley |

| town_name | population | settled_date |
| --------- | ---------- | ------------ |
| Needham   | 28,888     | 1680         |
| Dedham    | 24,729     | 1635         |

What values does each of the following joins select?

 All joins are on the column `town_name` that is present in both tables. (That is, these are **natural joins**.)

a. An inner join of college and town.

The inner join contains only those rows that are present in both the left and right table.

| college_name | students | town_name | population | settled_date |
| ------------ | -------- | --------- | ---------- | ------------ |
| Babson       | 2840     | Needham   | 28,888     | 1680         |
| Olin         | 2840     | Needham   | 28,888     | 1680         |

b. A left join of `college` and `town`.

| college_name | students | town_name | population | settled_date |
| ------------ | -------- | --------- | ---------- | ------------ |
| Babson       | 2840     | Needham   | 28,888     | 1680         |
| Olin         | 2840     | Needham   | 28,888     | 1680         |
| Wellesley    | 2474     | Wellesley | NULL | NULL |

The left join contains all rows of the left table, with columns from the right table where a joined row exists.

c. A right join of `college` and `town`.

| college_name | students | town_name | population | settled_date |
| ------------ | -------- | --------- | ---------- | ------------ |
| Babson       | 2840     | Needham   | 28,888     | 1680         |
| Olin         | 2840     | Needham   | 28,888     | 1680         |
| NULL | NULL | Dedham    | 24,729     | 1635         |

d. A full join of `college` and `town`.

| college_name | students | town_name | population | settled_date |
| ------------ | -------- | --------- | ---------- | ------------ |
| Babson       | 2840     | Needham   | 28,888     | 1680         |
| Olin         | 2840     | Needham   | 28,888     | 1680         |
| Wellesley    | 2474     | Wellesley | NULL | NULL |
| NULL | NULL | Dedham    | 24,729     | 1635         |

## 3. Prolog

…

## 4. (Optional) Sorting

Using the descriptions of sorting algorithms in the PDF attached to [Day 15](https://sites.google.com/site/focs16fall/in-class-exercises/day-15-sorting-and-friends):

Write out the steps in sorting the following arrays with each of the algorithms.  Specifically, show the state of the array after each pass through the outer loop.  [NB:  you may omit passes that either subdivide or concatenate sub-arrays without changing the order.]

This version doesn't show underlined portions. [hw20-4-solns.rtf](./hw20-4-solns.rtf) shows the underlines.

```
Bubble sort:

3 9 4 1 8 3 7 2
3 4 1 8 3 7 2 9
1 3 4 3 7 2 8 9
1 3 3 4 2 7 8 9
1 3 3 2 4 7 8 9
1 3 2 3 4 7 8 9
1 2 3 3 4 7 8 9 
[repeated if there’s no check for sorted]


3 1 2 4 6 5 2 7
1 2 3 4 5 2 6 7
1 2 3 4 2 5 6 7
1 2 3 2 4 5 6 7
1 2 2 3 4 5 6 7
[and repeated if there’s no check for sorted]


9 1 8 2 7 6 5 4
1 8 2 7 6 5 4 9
1 2 7 6 5 4 8 9
1 2 6 5 4 7 8 9
1 2 5 4 6 7 8 9
1 2 4 5 6 7 8 9
[and repeated if there’s no check for sorted]


8 3 4 3 4 8 3 4
3 4 3 4 8 3 4 8
3 3 4 4 3 4 8 8
3 3 4 3 4 4 8 8 
3 3 3 4 4 4 8 8 
[and repeated if there’s no check for sorted]


Insertion sort:  

3 9 4 1 8 3 7 2
3 9 4 1 8 3 7 2
3 9 4 1 8 3 7 2
3 4 9 1 8 3 7 2
1 3 4 9 8 3 7 2
1 3 4 8 9 3 7 2
1 3 3 4 8 9 7 2
1 3 3 4 7 8 9 2
1 2 3 3 4 7 8 9


3 1 2 4 6 5 2 7
3 1 2 4 6 5 2 7
1 3 2 4 6 5 2 7
1 2 3 4 6 5 2 7
1 2 3 4 6 5 2 7
1 2 3 4 6 5 2 7
1 2 3 4 5 6 2 7
1 2 2 3 4 5 6 7
1 2 2 3 4 5 6 7


9 1 8 2 7 6 5 4
9 1 8 2 7 6 5 4
1 9 8 2 7 6 5 4
1 8 9 2 7 6 5 4
1 2 8 9 7 6 5 4
1 2 7 8 9 6 5 4
1 2 6 7 8 9 5 4
1 2 5 6 7 8 9 4
1 2 4 5 6 7 8 9


8 3 4 3 4 8 3 4
8 3 4 3 4 8 3 4
3 8 4 3 4 8 3 4
3 4 8 3 4 8 3 4
3 3 4 8 4 8 3 4
3 3 4 4 8 8 3 4
3 3 4 4 8 8 3 4
3 3 3 4 4 8 8 4
3 3 3 4 4 4 8 8


Selection sort:  (underlined portion is important; non-underlined portion is unsorted and might be in a different order if not using in place selection sort)

3 9 4 1 8 3 7 2
1 9 4 3 8 3 7 2
1 2 4 3 8 3 7 9
1 2 3 4 8 3 7 9
1 2 3 3 8 4 7 9
1 2 3 3 4 8 7 9
1 2 3 3 4 7 8 9
1 2 3 3 4 7 8 9
1 2 3 3 4 7 8 9


3 1 2 4 6 5 2 7
1 3 2 4 6 5 2 7
1 2 3 4 6 5 2 7
1 2 2 4 6 5 3 7
1 2 2 3 6 5 4 7
1 2 2 3 4 5 6 7
1 2 2 3 4 5 6 7
1 2 2 3 4 5 6 7
1 2 2 3 4 5 6 7


9 1 8 2 7 6 5 4
1 9 8 2 7 6 5 4
1 2 8 9 7 6 5 4
1 2 4 9 7 6 5 8
1 2 4 5 7 6 9 8
1 2 4 5 6 7 9 8
1 2 4 5 6 7 9 8
1 2 4 5 6 7 8 9
1 2 4 5 6 7 8 9


8 3 4 3 4 8 3 4
3 8 4 3 4 8 3 4
3 3 4 8 4 8 3 4
3 3 3 8 4 8 4 4
3 3 3 4 8 8 4 4
3 3 3 4 4 8 8 4
3 3 3 4 4 4 8 8 
3 3 3 4 4 4 8 8 
3 3 3 4 4 4 8 8 

Merge sort:

3 9 4 1 8 3 7 2
[subdivisions omitted]
3 9   1 4   3 8   2 7
1 3 4 9   2 3 7 8
1 2 3 3 4 7 8 9


3 1 2 4 6 5 2 7
[subdivisions omitted]
1 3   2 4  5 6   2 7
1 2 3 4   2 5 6 7
1 2 2 3 4 5 6 7 


9 1 8 2 7 6 5 4
[subdivisions omitted]
1 9   2 8   6 7   4 5
1 2 8 9    4 5 6 7
1 2 4 5 6 7 8 9


8 3 4 3 4 8 3 4
[subdivisions omitted]
3 8   3 4   4 8   3 4
3 3 4 8   3 4 4 8
3 3 3 4 4 4 8 8


Quick sort:

3 9 4 1 8 3 7 2 
1 2   3   9 4 8 3 7
1   2   3   4 8 3 7   9
1   2   3   3   4   8 7   9
1   2   3   3   4   7   8   9  


3 1 2 4 6 5 2 7
1 2 2   3   4 6 5 7
1   2 2   3   4   6 5 7
1   2   2   3   4   5   6   7


9 1 8 2 7 6 5 4
1 8 2 7 6 5 4    9
1    8 2 7 6 5 4    9
1    2 7 6 5 4    8    9
1    2    7 6 5 4     8     9
1    2    6 5 4    7    8     9
1    2    5 4    6    7    8    9
1    2    4    5    6    7    8    9


8 3 4 3 4 8 3 4
3 4 3 4 3 4    8   8
3   4 3 4 3 4   8   8
3   3 3    4   4 4   8    8
3   3   3   4   4   4   8   8


Heap sort:

3 9 4 1 8 3 7 2
[insertions into maxheap:  spaces separate heap from uninserted elements]
3    9 4 1 8 3 7 2
9 3    4 1 8 3 7 2
9 3 4    1 8 3 7 2
9 3 4 1    8 3 7 2
9 8 4 1 3    3 7 2
9 8 4 1 3 3    7 2
9 8 7 1 3 3 4    2
9 8 7 2 3 3 4 1
[now deletions from the top of the heap to create a sorted list]
8 3 7 2 1 3 4    9
7 3 4 2 1 3    8 9
4 3 3 2 1    7 8 9
3 2 3 1    4 7 8 9
3 2 1    3 4 7 8 9
2 1    3 3 4 7 8 9
1    2 3 3 4 7 8 9
   1 2 3 3 4 7 8 9


3 1 2 4 6 5 2 7
3    1 2 3 6 5 2 7
3 1    2 3 6 5 2 7
3 1 2    3 6 5 2 7
3 3 2 1    6 5 2 7
6 3 2 1 3    5 2 7
6 3 5 1 3 2    2 7
6 3 5 1 3 2 2    7
7 6 5 3 3 2 2 1
6 3 5 3 1 2 2    7
5 3 2 3 1 2    6 7
3 3 2 2 1    5 6 7
3 2 2 1    3 5 6 7
2 1 2    3 3 5 6 7
2 1    2 3 3 5 6 7
1    2 2 3 3 5 6 7
   1 2 2 3 3 5 6 7

9 1 8 2 7 6 5 4
9    1 8 2 7 6 5 4
9 1    8 2 7 6 5 4
9 1 8    2 7 6 5 4
9 2 8 1    7 6 5 4
9 7 8 1 2    6 5 4
9 7 8 1 2 6    5 4
9 7 8 1 2 6 5    4
9 7 8 4 2 6 5 1
8 7 6 4 2 1 5    9
7 5 6 4 2 1    8 9
6 5 1 4 2    7 8 9
5 4 1 2    6 7 8 9
4 2 1    5 6 7 8 9
2 1    4 5 6 7 8 9
1    2 4 5 6 7 8 9
   1 2 4 5 6 7 8 9

8 3 4 3 4 8 3 4
8    3 4 3 4 8 3 4
8 3    4 3 4 8 3 4
8 3 4    3 4 8 3 4
8 3 4 3    4 8 3 4
8 4 4 3 3    8 3 4
8 4 8 3 3 4    3 4
8 4 8 3 3 4 3    4
8 4 8 4 3 4 3 3
8 4 4 4 3 3 3    8
4 4 4 3 3 3    8 8
4 3 4 3 3    4 8 8
4 3 3 3    4 4 8 8
3 3 3    4 4 4 8 8
3 3    3 4 4 4 8 8
3    3 3 4 4 4 8 8
   3 3 3 4 4 4 8 8
```