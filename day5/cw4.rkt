#lang racket

(define (lst)
  '(-2 -1 0 1 2)
)

(define (list-length xs)
  (foldl (lambda (x s) (+ s 1)) 0 xs)
)

(define (count-evens xs)
  (foldl (lambda (x s) (if (even? x) (+ s 1) s)) 0 xs)
)

(define (list-square xs)
  (map (lambda (x) (expt x 2)) xs)
)

(define (list-addn n xs)
  (map (lambda (x) (+ x n)) xs)
)
(define (filter-even xs)
  (filter even? xs)
)

(define (filter-positive xs)
  (filter positive? xs)
)

(define (filter-gt n xs)
  (filter (lambda (x) (>= x n)) xs)
)

(list-length (lst))
(count-evens (lst))
(list-square (lst))
(list-addn 1 (lst))
(list-addn 10 (lst))
(filter-even (lst))
(filter-positive (lst))
(filter-gt 0 (lst))
