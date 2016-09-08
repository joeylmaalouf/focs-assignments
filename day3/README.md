# FOCS Day 3 Homework

In this homework, we are going to ask you to produce a calculator in scheme.  There are multiple stages of roughly increasing difficulty.  We’re hoping that everyone can get through at least part of this, and that you’ll challenge yourself to go a little further.

To begin, we’ll use operations like `'ADD` `'SUB` `'MUL` `'DIV`.  Note that these are scheme [symbols](https://docs.racket-lang.org/reference/symbols.html), so they should begin with a single quotation mark `'`.

You should not need to use any scheme beyond what we’ve taught you/included on the scheme in one page handout.

You should not use `set!`, or any other functions whose names contain an exclamation point `!`.

## 1. Single-expression Calculator
Create a calculator – call it `calculate` – that takes one argument, a list that looks sort-of like scheme, and computes the expression that is represented.  We suggest operations `ADD`, `SUB`, `MUL`, `DIV`.  For example:

	`(calculate '(ADD 3 4))` ;; --> 7

[Note that this is the same as `(calculate-1 (list 'ADD 3 4))`]

You may assume (for now) that expressions are well-formed, that each begins with an operator and has exactly two arguments, both numbers.

You may create additional helper functions if you would find it useful.

## 2. Recursive Calculator

The calculator in number 1 assumes that the arguments to each operation are numbers.  Expand its operation to allow for arguments that are themselves well-formed arithmetic expressions.  For example:

	(calculate '(ADD 3 (MUL 4 5))) ;; --> 23   ;; what is the equivalent construction using list?
	(calculate '(SUB (ADD 3 4) (MUL 5 6))) ;; --> -23   

## 3. Comparators

Your calculator support numeric operations.  Add comparators returning booleans (*e.g.*, greater than, less than, …).  Note that each of these takes numeric arguments (or expressions that evaluate to produce numeric values), but returns a boolean.  We suggest operators `GT`, `LT`, `GE`, `LE`, `EQ`, `NEQ`.

	(calculate '(GT (ADD 3 4) (MUL 5 6))) ;; --> #f   
	(calculate '(LE (ADD 3 (MUL 4 5)) (SUB 0 (SUB (ADD 3 4) (MUL 5 6))))) ;; --> #t

## 4. Boolean operations

You can’t use the boolean returned in the above calculations to do additional numeric operations, but you can add boolean operations `ANND`, `ORR`, `NOTT`

	(calculate '(AND (GT (ADD 3 4) (MUL 5 6))) (LE (ADD 3 (MUL 4 5)) (SUB 0 (SUB (ADD 3 4) (MUL 5 6)))))) ;; --> #f

## 5. (`IPH`) “IF”

Finally, add the conditional `IPH` ("if").  Like `if`, `IPH` takes three arguments – a *test*, a *then*-clause, and an *else*-clause – and evaluates only one of the *then*- or *else*-clauses, depending on the value of the *test* clause.  Note that the value of the test should be boolean, but the values of then- and else-clauses may be of any type.  This means that `IPH` itself can be embedded….

	(calculate '(IPH (GT (ADD 3 4) 7) (ADD 1 2) (ADD 1 3))) ;; -> 4

## 6. Obscure challenges

Modify your interpreter to allow any of the following:

* Unary minus
* One or more arguments to the binary operations above (`ADD` …, `GT` …, `ANND`…)
* Spellings that look more like scheme’s (`+` … , `>` … , and … ).  You can even look up scheme’s apply, but note that it can’t be used with and/or/not.
  * Extra special obscure challenge:  figure out why not.
