# Day 3 in class work

## 0. Factorial

Implement factorial, both recursively and tail recursively.

Hint:  The tail-recursive version will use a helper function.


## 1.  Filter

`filter` is built in to scheme.

	(filter even? '(1 2 3 4 5 6))  --> '(2 4 6)  ;; using the built-in even?
	(filter teen? '(21 17 2 13 4 42 2 16 3)) --> '(17 13 16)
	                        ;; assuming (define (teen? x) (and (<= 13 x) (<= x 19)))))
	(filter list? '(3 (3 2 1) symbol (4 2) (1 (2) 3)) --> '((3 2 1) (4 2) (1 (2) 3))

Implement it anyway.  Implement `my-filter` that behaves the same as the built-in `filter`.

What arguments does `my-filter` take?


## 2.  Map

Map is also built in to scheme.

	(map double '(1 2 3))  --> '(4 5 6)  ;; assuming (define (double x) (* 2 x))
	(map incr '(1 2 3)) --> '(2 3 4)     ;; assuming (define (incr x) (+ x 1))
	(map last '((3 2 1) (4 2) (1 2 3)) --> '(1 2 3)
	                                        ;; assuming (define (last lst)
	                                        ;;            (if (null? (rest lst))
	                                        ;;                (first lst)
	                                        ;;                (last (rest lst))))

Implement `my-map` that behaves as built-in `map`.

What arguments does `my-map` take?


## Append
While we're reimplementing built-ins, implement `my-append` (just like built in `append`).

It takes two lists and returns a list containing all of the elements of the originals, in order.

Note that it is purely functional, *i.e.*, it doesn't *modify* either of the lists that it is passed.

	(append '(1 2 3) '(4 5 6)) ;; --> '(1 2 3 4 5 6)

You might want to draw out the box and pointer structures for the original two lists
as well as for the new list.  Confirm with a member of the instructional staff.…


## 4. Zip

`zip` takes two lists, and returns a list of elements of size two, until one of the lists runs out.

	(zip '(1 2 3) '(4 5 6)) ;; --> '((1 4) (2 5) (3 6))
	(zip '(1 2 3) '(a b c d e f g)) ;; --> '((1 a) (2 b) (3 c))

Implement `zip`.


## 5. Reverse

Last built-in (for now):  `(my-)reverse`.

`reverse` takes a list, and returns a new list with the elements in reverse order.

	(reverse '(1 2 3)) ;; --> '(3 2 1)

Implement `my-reverse`.

## More Puzzles

`(count elt lst)` returns the number of times that elt appears in lst.

`(remove-dups lst)` returns a new list that contains the elements of lst but without repeats.

`(remove-dups '(1 2 3 1 4 5 2 4 6)) ;; --> '(1 2 3 4 5 6)`

`reverse` reverses a list, but doesn't reverse sublists in a tree.  (Try it and see.)
Write `deep-reverse`, which reverses all sublists as well.

Which of the above can you implement using tail recursion?
