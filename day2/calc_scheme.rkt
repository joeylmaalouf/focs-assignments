#lang racket

;;; Course: ENGR3520
;;; Author: Oliver Steele
;;; Date: 2016-10-01

;; helper function to do the calculation
(define (apply-op op arg1 arg2)
  (cond [(eq? op '+) (+ arg1 arg2)]
        [(eq? op '-) (- arg1 arg2)]
        [(eq? op '*) (* arg1 arg2)]
        [(eq? op '/) (/ arg1 arg2)]))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; infix as-you-go calculator
;; uses a helper function after the first input is read
(define (calc-as-you-go-helper arg1 input)
  (if (null? input)
    arg1
    (calc-as-you-go-helper (apply-op (first input) arg1 (second input)) (list-tail input 2))))

(define (calc-as-you-go input)
  (calc-as-you-go-helper (first input) (rest input)))

(write (calc-as-you-go '(1 + 2))) (newline)
(write (calc-as-you-go '(1 + 2 * 3))) (newline)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Full RPN calculator
;; uses a helper function after the first input is read
(define (calc-rpn-helper input stack)
  (if (null? input)
      (first stack)
      (if (number? (first input))
          (calc-rpn-helper (rest input) (cons (first input) stack))
          (calc-rpn-helper (rest input) (cons (apply-op (first input) (second stack) (first stack)) (list-tail stack 2))))))

(define (calc-rpn input)
  (calc-rpn-helper input '()))

(write (calc-rpn '(1 2 +))) (newline)
(write (calc-rpn '(1 2 + 3 *))) (newline)
(write (calc-rpn '(1 2 3 + *))) (newline)
