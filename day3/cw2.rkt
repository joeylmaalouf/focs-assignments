#lang racket

(define (my-factorial n)
  (cond
    [(< n 2) n]
    [else (* n (my-factorial (- n 1)))]
  )
)

(define (my-filter proc lst)
  (cond
    [(null? lst) lst]
    [(proc (first lst)) (cons (first lst) (my-filter proc (rest lst)))]
    [else (my-filter proc (rest lst))]
  )
)

(define (my-map proc lst)
  (cond
    [(null? lst) lst]
    [else (cons (proc (first lst)) (my-map proc (rest lst)))]
  )
)

(define (my-append lst1 lst2)
  (cond
    [(null? lst1) lst2]
    [(null? lst2) lst1]
    [else (cons (first lst1) (my-append (rest lst1) lst2))]
  )
)

(define (my-zip lst1 lst2)
  (cond
    [(null? lst1) empty]
    [(null? lst2) empty]
    [else (cons (list (first lst1) (first lst2)) (my-zip (rest lst1) (rest lst2)))]
  )
)

(define (my-reverse lst)
  (cond
    [(null? lst) lst]
    [else (cons (first lst) (my-reverse (rest lst)))]
  )
)

(my-factorial 4)
(my-filter even? '(1 2 3 4 5 6))
(my-map (lambda (x) (+ x 1)) '(1 2 3 4))
(my-append '(1 2 3) '(4 5 6))
(my-zip '(1 2 3) '(4 5 6 7 8))
(my-reverse '(1 2 3 4))
