# FOCS Day 4 Homework

## 1. assq

An **association list** is scheme's version of a dictionary.

Each element in the association list consists of a key/value pair (or key/value list).

`assq` is a function that takes a key and an association list.
It returns the corresponding key/value pair from the list
(*i.e.*, the pair whose key is *eq?* to the one it is given).
If the key is not found in the list, `assq` returns `#f`.

For example:

	(define operator-list
	  (list (list 'ADD +)
	        (list 'SUB -)
	        (list 'MUL *)
	        (list 'DIV /)
	        (list 'GT >)
	        (list 'LT <)
	        (list 'GE >=)
	        (list 'LE <=)
	        (list 'EQ =)
	        (list 'NEQ (lambda (x y) (not (= x y))))
	        (list 'ANND (lambda (x y) (and x y)))
	        (list 'ORR (lambda (x y) (or x y)))
	        (list 'NOTT not)))

	(assq 'ADD operator-list) --> '(ADD #<procedure:+>)
	(assq 'ANND operator-list) --> '(ANND #<procedure>)
	(assq 'FOO operator-list) --> #f


Build your own version of `assq`.



## 2. lookup-list

We can give our evaluation program an association list for variables (names, symbols).

Then, we can use those variables in expressions.

`(evaluate 'foo lookup-list)` should return whatever `'foo` is associated with in `lookup-list`.

Add the `lookup-list` argument to your evaluator (or ours, from the solution set).

Add the ability to look up symbols to your evaluator.

[Note that you will have to give it a lookup-list.  You might try `'((x 3) (y 12) (z 2))`.]



## Recommended Problem

Finish up and turn in any problems you didn't complete in class.  You can ignore the extras,
but try to get through 1-5.
