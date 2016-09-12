#lang racket

;;; Student Name: Solution Set
;;;
;;; Check one:
;;; [ ] I completed this assignment without assistance or external resources.
;;; [X] I completed this assignment with assistance from ALL COURSE STAFF
;;;     and/or using these external resources: ___

;;     NOTE:  You need not worry about error checking in the programs below.

;; 1.  WRITE SQUARE:  given n, returns n^2.  Hint:  use *
(define (square x)
  (* x x))

(display (square 2)) (newline)  ;; -> 4


;; 2.  WRITE is-right-triangle:  given three numbers, returns true iff the third
;;     could be the hypotenuse of a right triangle with the specified three side lengths
;;     Hint:  use = to compare numeric values

(define (is-right-triangle a b c)  ;; note that you had to supply these parameters
  (= (+ (square a)
        (square b))                ;; auto-indentation lines up arguments to the same operation
     (square c)))

(display (is-right-triangle 3 4 5)) (newline)  ;; -> #t
(display (is-right-triangle 4 5 6)) (newline)  ;; -> #f

;; 3.  WRITE FACTORIAL:  given n, returns n!
;;     Hint:  recursion is your friend
(define (fact n)
  (if (= n 1)                  ;; Base case
      1                        ;; Base answer
      (* n (fact (- n 1)))))   ;; Recursive case
;; This is a typical recursive function.
;; It is called n times.

(display (fact 1)) (newline) ;; -> 1
(display (fact 2)) (newline) ;; -> 2 [[Corrected from assignment]]

;; 4.  WRITE FIBONACCI:  given n, returns the nth fibonacci number as shown below
;;     Hint:  don't run this on really big numbers!
(define (fib n)
   (if (= n 1)
       1
       (if (= n 2)                      ;; Two base cases
           1
           (+ (fib (- n 1)) (fib (- n 2))))))      ;; and a double recursion
;; Fib is called twice in each recursion, so it is actually called 2^n times.*
;; That grows QUICKLY!
;; [* Technically, it is called 2^(n-1) times, still large!]
;; Also:  the cascading ifs make the program large.  Cond would keep it more compact.

(define (fib-with-cond n)
  (cond [(= n 1) 1]
        [(= n 2) 1]
        [else (+ [fib (- n 1)] [fib (- n 2)])]))

;; Alternately, you can use OR:
(define (fib-with-or n)
   (if (or (= n 1) (= n 2))   ;; Note NOT (= n (or 1 2)); OR requires boolean arguments.
       1
       (+ (fib (- n 1)) (fib (- n 2)))))

(display (fib 1)) (newline) ;; -> 1
(display (fib 2)) (newline) ;; -> 1
(display (fib 3)) (newline) ;; -> 2
(display (fib 4)) (newline) ;; -> 3
(display (fib 5)) (newline) ;; -> 5
(display (fib 6)) (newline) ;; -> 8

;; 5.  WRITE a procedure that takes a list of numbers and returns the sum of those numbers
;;     Hint:  first, rest, cons
(define (sum lst)
  (if (null? lst)            ;; Base case
      0                      ;; Base answer
      (+ (first lst) (sum (rest lst)))))        ;; Compose answer using recursive call
;; This is a typical "cdr down the list" recursion.
;; It behaves very much like fact, but cdrs down a list instead of subtracting one from n.

(display (sum '(1 2 3 4))) (newline) ;; -> 10
(display (sum '(1 20 300))) (newline) ;; -> 321

;; 6.  WRITE a procedure that takes a list of numbers and returns the largest one.
;;     While there are solutions using scheme's built-in max, we were actually hoping you'd do something else...

;; Here's a straightforward recursive solution:
(define (my-max lst)
  (if (null? (rest lst))    ;; Base case -- note not null?, but just-one-left
      (first lst)           ;; Base answer -- if there's only one element, it's largest!
      (if (> (first lst) (my-max (rest lst)))   ;; Recursive case has two choices:
          (first lst)             ;; first element is larger than max rest, so return it.
          (my-max (rest lst)))))  ;; OR first element is smaller, so return max rest.


;; And here's another solution, using a helper function to keep track of the largest value seen so far:
(define (my-max-variant lst)
    (max-lst (first lst) (rest lst)))    ;; So far, the first element is the largest we've seen...

(define (max-lst max-so-far lst)      ;; Keep track of the max seen so far
  (if (null? lst)        ;; Base case
      max-so-far         ;; Base answer
      (if (> max-so-far (first lst))     ;; Recursive case has two parts:
          (max-lst max-so-far (rest lst))   ;; first is smaller than max-so-far, so ignore it.
          (max-lst (first lst) (rest lst)))))    ;; OR first is larger, so remember it instead.

(display (my-max '(1 10 2 20 3))) (newline) ;; -> 20
