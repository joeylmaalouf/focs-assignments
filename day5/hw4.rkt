#lang racket

;;; Student Name: Joey Maalouf
;;;
;;; Check one:
;;; [ ] I completed this assignment without assistance or external resources.
;;; [X] I completed this assignment with assistance from Dan
;;;     and/or using these external resources: docs.racket-lang.org

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

(define (evaluate expr vars)
  (cond
    ; number base case
    [(number? expr)
      expr
    ]
    ; boolean base case
    [(boolean? expr)
      expr
    ]
    ; variable lookup base case
    [(symbol? expr)
      (cadr (assq expr vars))
    ]
    ; define variable
    [(equal? (car expr) 'DEFINE)
      (repl (append
        (list (list (cadr expr) (evaluate (caddr expr) vars)))
        vars
      ))
    ]
    ; lambda creation
    [(equal? (car expr) 'LAMBDA)
      (list (quasiquote (unquote expr)) vars)
    ]
    ; lambda application
    [(and (pair? (car expr)) (equal? (caar expr) 'LAMBDA))
      (evaluate
        (caddar expr)
        (append
          (map list
            (cadar expr)
            (map (lambda (e) (evaluate e vars)) (cdr expr))
          )
          vars
        )
      )
    ]
    ; operator evaluation
    [(assq (car expr) operator-list)
      (apply
        (cadr (assq (car expr) operator-list))
        (map (lambda (e) (evaluate e vars)) (cdr expr))
      )
    ]
    ; function evaluation
    [else
      (evaluate
        (cons (caadr (assq (car expr) vars)) (cdr expr))
        (cadadr (assq (car expr) vars))
      )
    ]
  )
)

(run)


; Tests:

; defining variables
; > (DEFINE foo (IPH (GT 2 1) (ADD 6 7) (MUL 5 8)))
; > foo
; 13

; evaluating lambda expressions
; > ((LAMBDA (x y) (ADD (MUL x x) (MUL y y))) 2 (SUB 4 1))
; 13

; defining functions in terms of lambda expressions
; > (DEFINE a 5)
; > (DEFINE b 2)
; > (DEFINE math (LAMBDA (x y) (ADD (DIV (SUB x y) b) a)))
; > (math 20 4)
; 13
