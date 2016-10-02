# FOCS Homework 9, for Day 10

You may edit your answers into this file, or add a separate file in the same directory.

If you add a separate file, please include the following at the top:

```
Student Name: Joey Maalouf
Check one:
[X] I completed this assignment without assistance or external resources.
[ ] I completed this assignment with assistance from ___
   and/or using these external resources: ___
```

## 1. Reading

Read Sipser pp. 101–125. (This was the optional reading for today. It is required for Monday.)


## 2. Constructing Grammars

Construct a Context Free Grammar for each of the following languages.

a) All strings (over {0,1}) consisting of a substring _w_ followed by its reverse. (This is the same problem you were asked to work on in class.)

Give a derivation for `010010`.

```
X -> 0S0 | 1S1 | ε
```

`X -> 0X0 -> 01X10 -> 010X010 -> 010010`

---

b) All strings (over {a,b,c}) of the form a^{i}b^{i}c^{j}: an equal number of `a`s and `b`s, followed by any number of `c`s. For example, `aabb`, `aabbcc`, and `aabbcccc`, but not `aaaabbcc`.

```
X -> aYbZ | ε
Y -> aYb | ε
Z -> Zc | ε
```

`X -> aYbZ -> aaYbbZ -> aabbZ -> aabbZc -> aabbZcc -> aabbZccc -> aabbZcccc -> aabbcccc`

---

c) All strings (over {a,b,c}) of the form a^{i}b^{j}c^{j}: any number of `a`s, followed by an equal number of `b`s and `c`s. For example, `abbcc`, `aabbcc`, and `aaaabbcc`, but not `aabbccc`.

```
X -> ZbYc | ε
Y -> bYc | ε
Z -> aZ | ε
```

`X -> ZbYc -> ZbbYcc -> Zbbcc -> aZbbcc -> aaZbbcc -> aaaZbbcc -> aaaaZbbcc -> aaaabbcc`

---

d) Give two distinct grammars that produce the strings described by the regular expression `(ab)*`: empty, `ab`, `abab`, `ababab`, ….

```
X -> abX | ε
```

`X -> abX -> ababX -> abababX -> ababab`

```
X -> Xab | ε
```

`X -> Xab -> Xabab -> Xababab -> ababab`


## 3. Ambiguous Grammars

Consider the grammar:

    S --> a S | a S b S | epsilon 

This grammar is ambiguous. Show in particular that the string `a a b` has
two:

a. parse trees

```
   S
 /   \
a     S
   / / \ \
  a S   b S
    |     |
    ε     ε
```

```
    S
 / / \ \
a S   b S
 / \    |
a   S   ε
    |
    ε
```

b. leftmost derivations (These are the ones that, starting from the start variable, rewrite the leftmost nonterminal first.)

`S -> aSbS -> aaSbS -> aabS -> aab`

`S -> aS -> aaSbS -> aabS -> aab`

c. rightmost derivations (These are the ones that, starting from the start variable, rewrite the rightmost nonterminal first.)

`S -> aSbS -> aSb -> aaSb -> aab`

`S -> aS -> aaSbS -> aaSb -> aab`

Extra Credit/Challenge: Prove that this grammar generates all and only the strings of `a`s and `b`s such that every prefix has at least as many `a`s as `b`s. **Hint: Do the readings!**

- The only terminals in the grammar rules are `a`, `b`, and `ε`; thus, the language is made up of just `a`s and `b`s.
- The only step that adds a `b` also adds the same number of `a`s (1); thus, for every `b` in a string, there's also that many `a`s.
- There's a step that just adds an `a`; thus, we have no upper bound on the number of `a`s.
- Putting our conclusions together, we can say that we always have at least as many `a`s as `b`s, since every `b` comes with an `a` and we can add `a`s by themselves.


## 4. [Optional] Play with Prolog

Read the page and download the sample files from [here](https://sites.google.com/site/focs16fall/prolog).

Warning: your instructor was unable to get these to reliably run today, and some of the instructions are from memory of when it previously worked. Your mileage may vary.
