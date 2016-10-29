# FOCS Day 1 Activity

## 1. RPN Calculator

[Reverse Polish Notation](https://en.wikipedia.org/wiki/Reverse_Polish_notation) is a mathematical notation where the *operator* (*e.g.* `+`, `*`) follows the *operands*.

| Algebraic (Infix) Notation | RPN | Value |
| --- | --- | --- |
| 1 + 2 | 1 2 + | 3 |
| (2 + 3) * 4 | 2 3 + 4 * | 20
| 2 * (3 + 4) | 2 3 4 + * | 14
| 2 + (3 + 4) | 2 3 4 + + | 9

Write a Python[^1] function that accepts an RPN list of numbers and operator names (strings), and returns a number that is the value of the list, interpreted as RPN.

``` python
def eval_rpn(tokens):
  ...
 
>>> eval_rpn([1, 2, '+'])
3
>>> eval_rpn([2, 3, '+', 4, '*'])
20
```

[^1]: Or another language of your choice. You are only guaranteed NINJA support for work in Python.


## 2. Four-Function Calculator
A four-function calculator uses [Simple Immediate Execution Mode (Simple IEM)](https://en.wikipedia.org/wiki/Calculator_input_methods#Immediate_execution). It applies each operation to the previous value that was entered or calculated, and the next value.

Simple IEM is confusing because it doesn't take into account [operator precedence](https://en.wikipedia.org/wiki/Order_of_operations). `2 + 3 * 4` in Simple IEM is the same as `(2 + 3) * 4` in algebraic notation, because each operator is applied as soon as the next number is entered.

| Four-Function Calculator | Algebraic Notation | Value |
| --- | --- | --- |
| 1 + 2 | 1 + 2 | 3 |
| 2 * 3 + 4 | (2 * 3) + 4 | 10 |
| 2 + 3 * 4 | (2 + 3) * 4 | 20 |

Write a Python function that implements a four-function calculator: it accepts a list of numbers and operator names, and returns the value of the string interpreted in simple IEM.

``` python
def eval_4fn(tokens):
   ...

>>> eval_4fn([1, '+', 2])
3
>>> eval_4fn([2, '*', 3, '+', 4])
10
>>> eval_4fn([2, '+', 3, '*', 4])
20
```

## 3. Algebraic Calculator with Trees

Graphing calculators generally support [algebraic (infix) notation](https://en.wikipedia.org/wiki/Calculator_input_methods#Infix_notation), with *parentheses* and *operator precedence*.

**Parentheses**: Material inside parentheses is evaluated first. Example: `(2 + 3) * 4` is distinct from `2 + (3 * 4)`

**Operator precedence**: Within the same parenthesis group or outside all of them, '*' and '/' are applied before '+' and '-'. Example: `2 + 3 * 4` is equivalent to `2 + (3 * 4)`, not `(2 + 3) * 4`.

This assignment is to implement the first of these (Algebraic Entry System with Parentheses), but not the second. The input is a list of lists.

| Algebraic Notation | Python Representation | Value |
| --- | --- | --- |
| 1 + 2 | [1, '+', 2] | 3 |
| 1 + 2 + 3 | [1, '+', 2, '+', 3] | 6 |
| 2 * (3 + 4) | [2, '*', [3, '+', 4]] | 14 |
| (2 + 3) * 4 | [[2, '+', 3], '*', 4] | 20 |

``` python
def eval_parens(tree):
  ...

>>> eval_parens([2, '*', [3, '+', 4]])
14
```

## 4. Algebraic Calculator with List

| Algebraic Notation | Python Representation | Value |
| --- | --- | --- |
| 1 + 2 | [1, '+', 2] | 3 |
| 2 * (3 + 4) | [2, '*', '(', '+', 4, ')'] | 14 |
| (2 + 3) * 4 | ['(', 2, '+', 3, ')', '*', 4] | 20 |

``` python
def eval_tree(tree):
  ...

>>> eval_tree([2, '*', '(', 3, '+', 4, ')'])
14
```

## Going Beyond

These are challenge problems if you finish up with extra time or wish to work on these outside of class. No formal credit, but admiration and kudos, will be give.

* Implement operator precedence. Hint and example TBD
* Parse an input string. Hint: use a regular expression that captures digit sequences, and the `findall` function from the Python [re](https://docs.python.org/2/library/re.html) library.
* Write a function that takes an algebraic tree, and prints it with parentheses. Example TBD
* Write a function that takes an algebra tree, and prints it with only minimal parentheses. Hint and example TBD