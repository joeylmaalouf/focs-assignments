#lang racket

;;; Student Name: Joey Maalouf
;;;
;;; Check one:
;;; [X] I completed this assignment without assistance or external resources.
;;; [ ] I completed this assignment with assistance from ___
;;;     and/or using these external resources: ___

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
    (list 'IPH  (lambda (x y z) (if x y z) ))
  )
)

(define variable-list
  (list
    (list 'x  3 )
    (list 'y  2 )
    (list 'z  -5)
  )
)

(define (run)
  (display "Welcome to my repl.") (newline)
  (display "Type some scheme-ish at the prompt.") (newline)
  (display "Type <return> after each expression:") (newline)
  (repl)
)

(define (repl)
  (display "> ")
  (display (evaluate (read)))
  (newline)
  (repl)
)

(define (evaluate expr)
  (cond
    [(number? expr) expr]
    [(boolean? expr) expr]
    [(symbol? expr) (cadr (assq expr variable-list))]
    [else (apply
      (cadr (assq (car expr) operator-list))
      (map evaluate (cdr expr))
    )]
  )
)

(run)
