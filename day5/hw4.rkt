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

(define (run)
  (display "Welcome to my repl.") (newline)
  (display "Type some scheme-ish at the prompt.") (newline)
  (display "Type <return> after each expression:") (newline)
  (repl empty)
)

(define (repl vars)
  (display "> ")
  (display (evaluate (read) vars))
  (newline)
  (repl vars)
)

(define (assq key l-list)
  (cond
    [(null? l-list) #f]
    [(not (list? l-list)) #f]
    [(equal? key (caar l-list)) (car l-list)]
    [else (assq key (cdr l-list))]
  )
)

(define (evaluate expr vars)
  (cond
    [(number? expr) expr]
    [(boolean? expr) expr]
    [(symbol? expr) (cadr (assq expr vars))]
    [(equal? (car expr) 'DEFINE) (repl (append vars (list (list (cadr expr) (evaluate (caddr expr) vars)))))]
    [else (apply
      (cadr (assq (car expr) operator-list))
      (map (lambda (e) (evaluate e vars)) (cdr expr))
    )]
  )
)

(run)
