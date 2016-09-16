#lang racket

;;; Student Name: Joey Maalouf
;;; Check one:
;;; [X] I completed this assignment without assistance or external resources.
;;; [ ] I completed this assignment with assistance from ___
;;;     and/or using these external resources: ___

(define (calculate x)
  (cond
    [(number?  x            ) x                                                                         ]
    [(boolean? x            ) x                                                                         ]
    [(equal?   (car x) 'ADD ) (+      (calculate (cadr x)) (calculate (caddr x))                       )]
    [(equal?   (car x) 'SUB ) (-      (calculate (cadr x)) (calculate (caddr x))                       )]
    [(equal?   (car x) 'MUL ) (*      (calculate (cadr x)) (calculate (caddr x))                       )]
    [(equal?   (car x) 'DIV ) (/      (calculate (cadr x)) (calculate (caddr x))                       )]
    [(equal?   (car x) 'EQ  ) (=      (calculate (cadr x)) (calculate (caddr x))                       )]
    [(equal?   (car x) 'NEQ ) (not (= (calculate (cadr x)) (calculate (caddr x)))                      )]
    [(equal?   (car x) 'GT  ) (>      (calculate (cadr x)) (calculate (caddr x))                       )]
    [(equal?   (car x) 'LT  ) (<      (calculate (cadr x)) (calculate (caddr x))                       )]
    [(equal?   (car x) 'GE  ) (>=     (calculate (cadr x)) (calculate (caddr x))                       )]
    [(equal?   (car x) 'LE  ) (<=     (calculate (cadr x)) (calculate (caddr x))                       )]
    [(equal?   (car x) 'ANND) (and    (calculate (cadr x)) (calculate (caddr x))                       )]
    [(equal?   (car x) 'ORR ) (or     (calculate (cadr x)) (calculate (caddr x))                       )]
    [(equal?   (car x) 'NOTT) (not    (calculate (cadr x))                                             )]
    [(equal?   (car x) 'IPH ) (if     (calculate (cadr x)) (calculate (caddr x)) (calculate (cadddr x)))]
  )
)

;;; 1. Create a calculator that takes one argument: a list that represents an expression.
(calculate '(ADD 3 4)) ;; --> 7
(calculate '(SUB 3 4)) ;; --> -1
(calculate '(MUL 3 4)) ;; --> 12
(calculate '(DIV 3 4)) ;; --> 3/4

;;; 2. Expand the calculator's operation to allow for arguments that are themselves well-formed arithmetic expressions.
(calculate '(ADD 3 (MUL 4 5))) ;; --> 23   ;; what is the equivalent construction using list?
(calculate '(SUB (ADD 3 4) (MUL 5 6))) ;; --> -23

;;; 3. Add comparators returning booleans (*e.g.*, greater than, less than, …).
;; Note that each of these takes numeric arguments (or expressions that evaluate to produce numeric values),
;; but returns a boolean.  We suggest operators `GT`, `LT`, `GE`, `LE`, `EQ`, `NEQ`.
(calculate '(GT (ADD 3 4) (MUL 5 6))) ;; --> #f
(calculate '(LE (ADD 3 (MUL 4 5)) (SUB 0 (SUB (ADD 3 4) (MUL 5 6))))) ;; --> #t

;;; 4. Add boolean operations AND, OR, NOT
(calculate '(ANND (GT (ADD 3 4) (MUL 5 6)) (LE (ADD 3 (MUL 4 5)) (SUB 0 (SUB (ADD 3 4) (MUL 5 6)))))) ;; --> #f

;;; 5. Add IPH
(calculate '(IPH (GT (ADD 3 4) 7) (ADD 1 2) (ADD 1 3))) ;; -> 4
