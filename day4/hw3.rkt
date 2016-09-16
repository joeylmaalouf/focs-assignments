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
    [(not (list? l-list)) #f]
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
  (cond
    [(number?  expr            ) expr                                                                                                 ]
    [(boolean? expr            ) expr                                                                                                 ]
    [(symbol?  expr            ) (cadr (assq expr l-list))                                                                            ]
    [(equal?   (car expr) 'ADD ) (+      (evaluate (cadr expr) l-list) (evaluate (caddr expr) l-list)                                )]
    [(equal?   (car expr) 'SUB ) (-      (evaluate (cadr expr) l-list) (evaluate (caddr expr) l-list)                                )]
    [(equal?   (car expr) 'MUL ) (*      (evaluate (cadr expr) l-list) (evaluate (caddr expr) l-list)                                )]
    [(equal?   (car expr) 'DIV ) (/      (evaluate (cadr expr) l-list) (evaluate (caddr expr) l-list)                                )]
    [(equal?   (car expr) 'EQ  ) (=      (evaluate (cadr expr) l-list) (evaluate (caddr expr) l-list)                                )]
    [(equal?   (car expr) 'NEQ ) (not (= (evaluate (cadr expr) l-list) (evaluate (caddr expr) l-list))                               )]
    [(equal?   (car expr) 'GT  ) (>      (evaluate (cadr expr) l-list) (evaluate (caddr expr) l-list)                                )]
    [(equal?   (car expr) 'LT  ) (<      (evaluate (cadr expr) l-list) (evaluate (caddr expr) l-list)                                )]
    [(equal?   (car expr) 'GE  ) (>=     (evaluate (cadr expr) l-list) (evaluate (caddr expr) l-list)                                )]
    [(equal?   (car expr) 'LE  ) (<=     (evaluate (cadr expr) l-list) (evaluate (caddr expr) l-list)                                )]
    [(equal?   (car expr) 'ANND) (and    (evaluate (cadr expr) l-list) (evaluate (caddr expr) l-list)                                )]
    [(equal?   (car expr) 'ORR ) (or     (evaluate (cadr expr) l-list) (evaluate (caddr expr) l-list)                                )]
    [(equal?   (car expr) 'NOTT) (not    (evaluate (cadr expr) l-list)                                                               )]
    [(equal?   (car expr) 'IPH ) (if     (evaluate (cadr expr) l-list) (evaluate (caddr expr) l-list) (evaluate (cadddr expr) l-list))]
  )
)


;;;;;;;;;;;
;; Tests

(define operator-list
  (list
    (list 'ADD  +                           )
    (list 'SUB  -                           )
    (list 'MUL  *                           )
    (list 'DIV  /                           )
    (list 'GT   >                           )
    (list 'LT   <                           )
    (list 'GE   >=                          )
    (list 'LE   <=                          )
    (list 'EQ   =                           )
    (list 'NEQ  (lambda (x y) (not (= x y))))
    (list 'ANND (lambda (x y) (and x y    )))
    (list 'ORR  (lambda (x y) (or  x y    )))
    (list 'NOTT not                         )
  )
)
(assq 'ADD operator-list) ; --> '(ADD #<procedure:+>)
(assq 'FOO operator-list) ; --> #f

(evaluate '(ADD x y) '((x 3) (y 2) (z -5))) ; --> 5
(evaluate '(IPH (GT x 0) x (SUB 0 x)) '((x 3) (y 2) (z -5))) ; --> 3
