#lang racket

(define (tree-add1 tree)
  (cond
    [(null? tree) tree]
    [(number? tree) (+ tree 1)]
    [(null? (rest tree)) (tree-add1 (first tree))]
    [else (list (tree-add1 (first tree)) (tree-add1 (rest tree)))]
  )
)
(display '(3 (1 4))) (newline)
(display (tree-add1 '(3 (1 4)))) (newline) (newline)
