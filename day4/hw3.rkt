#lang racket

;;; Student Name: Joey Maalouf
;;;
;;; Check one:
;;; [X] I completed this assignment without assistance or external resources.
;;; [ ] I completed this assignment with assistance from ___
;;;     and/or using these external resources: ___


;;;;;;;;;;;
;; 1. assq
;; `assq` is a function that takes a key and an association list.
;; It returns the corresponding key/value pair from the list
;; (*i.e.*, the pair whose key is *eq?* to the one it is given).
;; If the key is not found in the list, `assq` returns `#f`.

(define (assq key l-list)
  (cond
    [(null? l-list) #f]
    [(equal? key (caar l-list)) (car l-list)]
    [else (assq key (cdr l-list))]
  )
)


;;;;;;;;;;;
;; 2. evaluate
;; Add the ability to look up symbols to your evaluator.
;; Add the `lookup-list` argument to your hw2 evaluator (or ours, from the solution set).
;; `(evaluate 'foo lookup-list)` should return whatever `'foo` is associated with in `lookup-list`.

(define (evaluate expr l-list)
  expr ; TODO
)


;;;;;;;;;;;
;; Tests

(define operator-list
  (list
    (list 'ADD +                           )
    (list 'SUB -                           )
    (list 'MUL *                           )
    (list 'DIV /                           )
    (list 'GT  >                           )
    (list 'LT  <                           )
    (list 'GE  >=                          )
    (list 'LE  <=                          )
    (list 'EQ  =                           )
    (list 'NEQ (lambda (x y) (not (= x y))))
    (list 'AND (lambda (x y) (and x y    )))
    (list 'OR  (lambda (x y) (or  x y    )))
    (list 'NOT not                         )
  )
)

(assq 'ADD operator-list) ; --> '(ADD #<procedure:+>)
(assq 'FOO operator-list) ; --> #f
