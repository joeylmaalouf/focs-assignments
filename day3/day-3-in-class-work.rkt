#lang racket

;;;;;;;;;;;
;;; Day 3 in class work

;;;;;;;;;;;
;; 0.  Implement factorial both recursively and tail recursively.
;;     Hint:  The tail recursive version will use a helper function.
(define (my-factorial n)
  (cond
    [(< n 2) n]
    [else (* n (my-factorial (- n 1)))]
  )
)

;;;;;;;;;;;
;; 1.  Filter is built in to scheme.

;; (filter even? '(1 2 3 4 5 6))  --> '(2 4 6)  ;; using the built-in even?
;; (filter teen? '(21 17 2 13 4 42 2 16 3)) --> '(17 13 16)
                        ;; assuming (define (teen x) (and (<= 13 x) (<= x 19)))))
;; (filter list? '(3 (3 2 1) symbol (4 2) (1 (2) 3)) --> '((3 2 1) (4 2) (1 (2) 3))

;; Implement it anyway.  You might want to call it my-filter?  What arguments does it take?
(define (my-filter proc lst)
  (cond
    [(null? lst) lst]
    [(proc (first lst)) (cons (first lst) (my-filter proc (rest lst)))]
    [else (my-filter proc (rest lst))]
  )
)

;;;;;;;;;;;
;; 2.  Map is also built in to scheme.

;; (map double '(1 2 3))  --> '(4 5 6)  ;; assuming (define (double x) (* 2 x))
;; (map incr '(1 2 3)) --> '(2 3 4)     ;; assuming (define (incr x) (+ x 1))
;; (map last '((3 2 1) (4 2) (1 2 3)) --> '(1 2 3)
                                        ;; assuming (define (last lst)
                                        ;;            (if (null? (rest lst))
                                        ;;                (first lst)
                                        ;;                (last (rest lst))))

;; Implement it as well.  You might want to call it my-map.  What arguments does it take?
(define (my-map proc lst)
  (cond
    [(null? lst) lst]
    [else (cons (proc (first lst)) (my-map proc (rest lst)))]
  )
)

;;;;;;;;;;;
;; 3.  While we're reimplementing built-ins, implement my-append (just like built in append)
;;     It takes two lists and returns a list containing all of the elements of the originals, in order.
;;     Note that it is purely functional, i.e., it doesn't MODIFY either of the lists that it is passed.

;; (append '(1 2 3) '(4 5 6)) --> '(1 2 3 4 5 6)

;; You might want to draw out the box and pointer structures for the original two lists
;; as well as for the new list.  Confirm with a member of the instructional staff....
(define (my-append lst1 lst2)
  (cond
    [(null? lst1) lst2]
    [(null? lst2) lst1]
    [else (cons (first lst1) (my-append (rest lst1) lst2))]
  )
)

;;;;;;;;;;;
;; 4.  zip takes two lists, and returns a list of elements of size two, until one of the lists runs out.

;; (zip '(1 2 3) '(4 5 6)) ;; --> '((1 4) (2 5) (3 6))
;; (zip '(1 2 3) '(a b c d e f g)) ;; --> '((1 a) (2 b) (3 c))

;; Implement `zip`.
(define (my-zip lst1 lst2)
  (cond
    [(null? lst1) empty]
    [(null? lst2) empty]
    [else (cons (list (first lst1) (first lst2)) (my-zip (rest lst1) (rest lst2)))]
  )
)

;;;;;;;;;;;
;; 5.  Last built-in (for now):  (my-)reverse.
;;     Takes a list, returns a new list with the elements reversed.

;; (reverse '(1 2 3)) --> '(3 2 1)
(define (my-reverse lst)
  (my-reverse-helper lst empty)
)
(define (my-reverse-helper lst acc)
  (cond
    [(null? lst) acc]
    [else (my-reverse-helper (rest lst) (cons (first lst) acc))]
  )
)

;;;;;;;;;;;
;; Tests
(my-factorial 4)
(my-filter even? '(1 2 3 4 5 6))
(my-map (lambda (x) (+ x 1)) '(1 2 3 4))
(my-append '(1 2 3) '(4 5 6))
(my-zip '(1 2 3) '(4 5 6 7 8))
(my-reverse '(1 2 3 4))
