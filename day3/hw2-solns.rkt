#lang racket

;;; Student Name: Solution Set
;;;
;;; Check one:
;;; [ ] I completed this assignment without assistance or external resources.
;;; [X] I completed this assignment with assistance from ALL COURSE STAFF
;;;     and/or using these external resources: ___

;;; 1.  Create a calculator that takes one argument: a list that represents an expression.

(define (calculate-1 x)
  (apply-op (first x) (second x) (third x))) ;; This simple solution
;; doesn't do any error checking and isn't very flexible.

;; Here's some straightforward code to actually carry out the operations:
(define (apply-op-1 op arg1 arg2)
  (if (eq? op 'ADD)                ;; NOTE:  use EQ? to compare symbols, NOT =
      (+ arg1 arg2)
      (if (eq? op 'SUB)
          (- arg1 arg2)
          (if (eq? op 'MUL)
              (* arg1 arg2)
              (if (eq? op 'DIV)    ;; Also NOTE the sneaky introduction of a
                  (/ arg1 arg2)    ;;    new built-in, ERROR, on the last line
                  (error "Don't know how to " op))))))

;; If we start adding more operations, this is going run off the right side of the page.
;; We could use a cond instead.  Note the very different syntax here:
(define (apply-op-2 op arg1 arg2)
  (cond [(eq? op 'ADD) (+ arg1 arg2)]
        [(eq? op 'SUB) (- arg1 arg2)]
        [(eq? op 'MUL) (* arg1 arg2)]
        [(eq? op 'DIV) (/ arg1 arg2)]
        [else (error "Don't know how to " op)]))

;; Much neater!  NB: Advanced racket also has a switch/case-like match function

;; But this is still going to get old very fast if we want to add operations.
;; Here's a version that separates the operator list from the code,
;; using some built-in features that we will explore later.

(define operator-list
  (list (list 'ADD +)
        (list 'SUB -)
        (list 'MUL *)
        (list 'DIV /)))

(define (apply-op-3 op arg1 arg2)
  (if (assq op operator-list)
      ((second (assq op operator-list)) arg1 arg2) ;; The operation is actually the
               ;; VALUE of the expression (second (assq op operator-list))!!
      (error "Don't know how to " op)))

;; Finally -- and mostly for show -- here is how I might actually write this code,
;; using a few features that we're NOT going to cover.  If you want to really learn 
;; scheme -- not just for this course, but beyond -- ask us to explain outside of class.
;; Or look them up along with lots of other interesting things!

(define op-list
  `((ADD ,+) (SUB ,-) (MUL ,*) (DIV ,/)))

(define (apply-op-4 op . args)
  (let ((binding (assq op op-list)))
    (if binding
        (apply (second binding) args)
        (error "Don't know how to " op))))    

(define apply-op apply-op-1)

(calculate-1 '(ADD 3 4)) ;; --> 7

;;; 2. Expand the calculator's operation to allow for arguments that are themselves well-formed arithmetic expressions.

;; This straightforward implementation assumes all operations take two arguments,
;; everything is well formed, etc.
(define (calculate-2 expr)
  (if (null? expr)            ;; Trees have two base cases:  list empty...
      expr
      (if (number? expr)      ;; and leaf.  [could collapse to (or (null? expr) (number? expr))]
          expr
          (apply-op (first expr)       ;; else it's an operator expression.
                    (calculate-2 (second expr))
                    (calculate-2 (third expr))))))


(calculate-2 '(ADD 3 (MUL 4 5))) ;; --> 23   ;; what is the equivalent construction using list?
(calculate-2 '(SUB (ADD 3 4) (MUL 5 6))) ;; --> -23

;;; 3. Add comparators returning booleans (*e.g.*, greater than, less than, ...).
;; Note that each of these takes numeric arguments (or expressions that evaluate to produce numeric values),
;; but returns a boolean.  We suggest operators `GT`, `LT`, `GE`, `LE`, `EQ`, `NEQ`.

;; This is sort-of a trick question, as it requires changing the application bits
;; and not the tree walking bits.

; ;; This is commented out because it directly overrides definitions above.
; ;; Replace the definition of operator-list above with this one to run the code below.
; 
; (define operator-list
;   (list (list 'ADD +)
;         (list 'SUB -)
;         (list 'MUL *)
;         (list 'DIV /)
;         (list 'GT >)
;         (list 'LT <)
;         (list 'GE >=)
;         (list 'LE <=)
;         (list 'EQ =)
;         (list 'NEQ (lambda (x y) (not (= x y)))))) ;; this one is tricky because
;                                                    ;; it is not built in
; 
; 
; 	(calculate-2 '(GT (ADD 3 4) (MUL 5 6))) ;; --> #f
; 	(calculate-2 '(LE (ADD 3 (MUL 4 5)) (SUB 0 (SUB (ADD 3 4) (MUL 5 6))))) ;; --> #t



;;; 4. Add boolean operations ANND, ORR, NOTT

;; Again, this is commented out because it directly overrides definitions above.
;; Replace the definition of operator-list above with this one to run the code below.

; (define operator-list
;   (list (list 'ADD +)
;         (list 'SUB -)
;         (list 'MUL *)
;         (list 'DIV /)
;         (list 'GT >)
;         (list 'LT <)
;         (list 'GE >=)
;         (list 'LE <=)
;         (list 'EQ =)
;         (list 'NEQ (lambda (x y) (not (= x y))))
;         (list 'ANND (lambda (x y) (and x y))) ;; although these AR built in,
;         (list 'ORR (lambda (x y) (or x y)))))   ;; they are not simply names.
; 
;  (calculate-2 '(ANND (GT (ADD 3 4) (MUL 5 6)) (LE (ADD 3 (MUL 4 5)) (SUB 0 (SUB (ADD 3 4) (MUL 5 6)))))) ;; --> #f


;; However, NOTT breaks things:  it is a unary operation, not a binary one.
;; (In other words, NOTT takes only one argument, not two.)
;; We can add a special case for this:

(define (calculate-3 expr)
  (if (null? expr)            ;; Trees have two base cases:  list empty...
      expr
      (if (number? expr)      ;; and leaf.  [could collapse to (or (null? expr) (number? expr))]
          expr
          (if (= (length expr) 3)      ;; slightly ugly but simple; see below for more.
              (apply-op (first expr)       ;; else it's an operator expression.
                        (calculate-2 (second expr))
                        (calculate-2 (third expr)))
              (apply-op (first expr)
                        (calculate-2 (second expr)))))))

;; Or, for a cleaner variable-number-of-arguments implementation, we could write
;; a version of apply-operator that takes a list of arguments:

(define (apply-operator op args)
  (cond [(eq? op 'ADD) (+ (first args) (second args))]
        [(eq? op 'SUB) (- (first args) (second args))]
        [(eq? op 'MUL) (* (first args) (second args))]
        [(eq? op 'DIV) (/ (first args) (second args))]
        [(eq? op 'GT) (> (first args) (second args))]
        [(eq? op 'LT) (< (first args) (second args))]
        [(eq? op 'GE) (>= (first args) (second args))]
        [(eq? op 'LE) (<= (first args) (second args))]
        [(eq? op 'EQ) (= (first args) (second args))]
        [(eq? op 'NEQ) (not (= (first args) (second args)))]
        [(eq? op 'ANND) (and (first args) (second args))]
        [(eq? op 'ORR) (or (first args) (second args))]
        [(eq? op 'NOTT) (not (first args))]
        [else (error "Don't know how to " op)]))

(define (calculate-4 expr)
  (if (null? expr)            ;; Trees have two base cases:  list empty...
      expr
      (if (number? expr)      ;; and leaf.  [could collapse to (or (null? expr) (number? expr))]
          expr
          (apply-operator (first expr)       ;; else it's an operator expression.
                          (map calculate-4 (rest expr))))))
 


(calculate-4 '(ANND (GT (ADD 3 4) (MUL 5 6)) (LE (ADD 3 (MUL 4 5)) (SUB 0 (SUB (ADD 3 4) (MUL 5 6)))))) ;; --> #f

(calculate-4 '(ORR (NOTT (GT (ADD 3 4) (MUL 5 6))) (NEQ (ADD 3 (MUL 4 5)) (SUB 0 (SUB (ADD 3 4) (MUL 5 6)))))) ;; --> #f

;;; 5. Add IPH

;; This is a fancier version of the cond in calculate-2.  It uses the variable-number-of-arguments
;; apply-operator from calculate-4 and a fancy set of IPH-related functions that are included below.

(define (calculate-5 expr)
  (cond [(number? expr) expr]   ;; these first three cases are sometimes called
        [(boolean? expr) expr]  ;; self-evaluating (because they are their own
        [(null? expr) expr]     ;; values and don't need explicit evaluating)
        [(IPH-expr? expr) (calculate-IPH expr)]
        [(list? expr) (apply-operator (first expr) (map calculate-5 (rest expr)))]
        [else (error `(calculate-5:  not sure what to do with expr ,expr))]))

;; I built a whole abstraction for IPH, though really the whole thing could be one clause of the cond:
;;
;; [(eq? (first expr) 'IPH) (if (calculate-5 (second expr))    ;; if the TEST is true 
;;                              (calculate-5 (third expr))     ;; evaluate the THEN
;;                              (calculate-5 (fourth expr)))]  ;; otherwise the ELSE
;; Here is the IPH abstraction:

(define (IPH-expr? sexpr)
  (and (pair? sexpr) (eq? (first sexpr) 'IPH)))

(define (IPH-TEST iph-expr)
  (second iph-expr))

(define (IPH-THEN iph-expr)
  (third iph-expr))

(define (IPH-ELSE iph-expr)
  (if (= (length iph-expr) 4)
      (fourth iph-expr)
      false))

(define (calculate-IPH sexpr)
  (if (calculate-5 (IPH-TEST sexpr))
      (calculate-5 (IPH-THEN sexpr))
      (calculate-5 (IPH-ELSE sexpr))))


(calculate-5 '(IPH (GT (ADD 3 4) 7) (ADD 1 2) (ADD 1 3))) ;; -> 4



;;  Finally, here's a more concise implementation of apply-operator that handles
;;  arbitrary length argument lists, just for kicks.

(define op-list-z
  `((ADD ,+) (SUB ,-) (MUL ,*) (DIV ,/)
             (GT ,>) (LT ,<) (GE ,>=) (LE ,<=) (EQ ,=) (NEQ ,(lambda args (not (apply = args))))
             (ANND ,(lambda (x y) (and x y))) (ORR ,(lambda (x y) (or x y)))
             (NOTT ,not)
             ))

(define (apply-operator-2 op args)
  (let ((binding (assq op op-list-z)))
    (if binding
        (apply (second binding) args)
        (error "Don't know how to " op))))    




