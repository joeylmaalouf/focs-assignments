# FOCS Day 10 In Class

## 1.

Consider the following context-free grammar G:

```
E -> E + E | T         # <- added "| T"
T -> T x T | (E) | a
```

a. What are its terminals?

**Answer:** G's terminals are `+`, `x`, `(`, `)`, `a`

b. What are its variables?

**Answer:** G's variables are *E* and *T*.

c. How many rules does it have?

**Answer:** G has 5 rules. `E -> E + E | T` abbreviates the two rules `E -> E + E` and `E -> T`. For the purposes of sizing the grammar, and of applying conversions such as CFG -> PDA and CFG -> Chomsky normal form, each disjunct is counted as a separate rule.

d. What is its start variable? (Assume this grammar's presentation follows the usual conventions)?

**Answer**: G's start variable is *E*. This is the left side of the first-listed rule.

e. List three strings that in this grammar's language.

**Answer**: `a`, `(a)`, `((a))`, `(a+a)`, `(a+(axa))`.

f. List three strings not in this grammar's language.

**Answer**: `aa`, `(a`, `a+a+a`, `a+(axa)+a`, `a-a`.

## 2-6.

**Answers:** These are given in the solution set to homework 10.
