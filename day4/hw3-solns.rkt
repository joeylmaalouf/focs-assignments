#lang racket


; Homework:
;
; An association list is scheme's version of a dictionary.
; Each element in the association list consists of a key/value pair (or key/value list).
; Assq is a function that takes a key and an association list;
;   it returns the corresponding key/value pair from the list.
;   (i.e., the pair whose key is eq? to the one it is given)
; If the key is not found in the list, assq returns #f.
;
; For example
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
;         (list 'NEQ (lambda (x y) (not (= x y))))
;         (list 'ANND (lambda (x y) (and x y)))
;         (list 'ORR (lambda (x y) (or x y)))
;         (list 'NOTT not)))
;
; (assq 'ADD operator-list) --> '(ADD #<procedure:+>)
; (assq 'ANND operator-list) --> '(ANND #<procedure>)
; (assq 'FOO operator-list) --> #f
;
;
; Build your own version of assq.


;;myassq takes a key and a list of entries (key-value associations).
;; If the given key matches the key of one of the entries, myassq returns that entry.
;; If no entry matches, myassq returns false.

(define (myassq key alist)
  (if (empty? alist)                  ;; base case:  no more entries to consider
      #f
      (if (entry-matches? key (first alist))  ;; check first entry for match;
          (first alist)                       ;;   return entry if matched,
          (myassq key (rest alist)))))        ;;  else cdr on down....

;; an abstraction for entries:
;;   entry-matches? key entry -> true iff the given key matches the entry
;;   entry-key entry -> the key in the entry
;;   entry-value entry -> the value in the entry

(define (entry-matches? key entry)
  (eq? key (entry-key entry)))

(define (entry-key entry)
  (first entry))

(define (entry-value entry)
  (second entry))




; Problem 2:
;
; We can give our evaluation program an association list for variables (names, symbols).
; Then, we can use those variables in expressions.
;   (evaluate 'foo lookup-list) should return whatever 'foo is associated with in lookup-list.
; Add the lookup-list argument to your evaluator (or ours, from the solution set).
; Add the ability to look up symbols to your evaluator.
; [Note that you will have to give it a lookup-list.  You might try '((x 3) (y 12) (z 2))]
;



;;  look up a variable using (my)assq
(define (lookup-variable var env)
  (if (myassq var env)                ;; look up var in the env association list
      (entry-value (myassq var env))  ;;   If found, retrieve its associated value [*]
      (error "lookup-variable: unbound variable " var)))
                  ;; [*] Yes, there is a more efficient way to do this -- not calling myassq
                  ;;     twice -- using let.  We didn't teach you this, but you are welcome
                  ;;     to look it up.  It's a purely functional construct that allows us
                  ;;     to temporarily hold on to a value, without assignment.
                  ;;     [Roughly, it creates a new parameter binding.]


;;  This is mostly the old code for evaluate, but (a) it includes an additional parameter and
;;      (b) it uses that parameter in handling variables (new code) (plus in the recursive call).
(define (evaluate expr lookup-list)
  (cond [(null? expr) expr]     ;; base cases:  empty list, numbers, boolean
        [(number? expr) expr]   ;;     are "self-evaluating"
        [(boolean? expr) expr]  ;;

        ;; THIS IS THE NEW ENTRY TO HANDLE VARIABLES/NAMES/LOOKUP
        [(symbol? expr) (lookup-variable expr lookup-list)]

        ;; The rest of this is almost unchanged recursive cases;
        ;;    the one change is to add the lookup-list argument to the recursive calls
        ;; Special forms:
        [(eq? (first expr) 'IPH) (if (evaluate (second expr) lookup-list)    ;; if the TEST is true
                                     (evaluate (third expr) lookup-list)     ;; evaluate the THEN
                                     (evaluate (fourth expr) lookup-list))]  ;; otherwise the ELSE


        ;; and then standard scheme expressions:  use MAP to allow variable length args
        [(list? expr) (apply-operator (first expr)
                                      (map (lambda (e)
                                             (evaluate e lookup-list))
                                           (rest expr)))]
        [else (error `(evaluate:  not sure what to do with expr ,expr))]))



; Recommended Problem:
;
; Finish up and turn in any problems you didn't complete in class.  You can ignore the extras,
; but try to get through 1-5.
;
;


;;  The code below is necessary to run some of the code above.
;;  It was part of an earlier homework set.
;;  There's an even nicer version -- using assq -- in the solution to the *next* hw set.

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
