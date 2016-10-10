#lang racket

;;;;;;;;;;
;;; Day 3 in class work

;;;;;;;;;;
;; 0.  Implement factorial both recursively and tail recursively.
;;     Hint:  The tail recursive version will use a helper function.


;;;;;;;;;;;
;; 1.  Filter is built in to scheme.

;; (filter even? '(1 2 3 4 5 6))  --> '(2 4 6)  ;; using the built-in even?
;; (filter teen? '(21 17 2 13 4 42 2 16 3)) --> '(17 13 16)
                        ;; assuming (define (teen x) (and (<= 13 x) (<= x 19)))))
;; (filter list? '(3 (3 2 1) symbol (4 2) (1 (2) 3)) --> '((3 2 1) (4 2) (1 (2) 3))

;; Implement it anyway.  You might want to call it my-filter?  What arguments does it take?


(define (my-filter pred lst)
  (if (empty? lst)                 ;; base case (end of list)
      null
      (if (pred (first lst))       ;; recursive case, cdring down the list, 
          (cons (first lst) (my-filter pred (rest lst)))  ;; with 
          (my-filter pred (rest lst)))))  ;; or without (first lst) depending on the filter




;;;;;;;;;;;
;; 2.  Map is also built in to scheme.

;; (map double '(1 2 3))  --> '(4 5 6)  ;; assuming (define (double x) (* 2 x))
;; (map incr '(1 2 3)) --> '(2 3 4)     ;; assuming (define (incr x) (+ x 1))
;; (map last '((3 2 1) (4 2) (1 2 3)) --> '(1 2 3)
                                        ;; assuming (define (last lst)
                                        ;;            (if (null? (rest lst))
                                        ;;                (first lst)
                                        ;;                (last (rest lst))))

;; Implement it as well.  You might want to call it my-map.  What arguments does it take?


(define (my-map fn lst)
  (if (empty? lst)       ;; base case
      null
      (cons (fn (first lst)) (my-map fn (rest lst)))))  ;; recursive case; cdr down lst



;;;;;;;;;;;
;; 3.  While we're reimplementing built-ins, implement my-append (just like built in append)
;;     It takes two lists and returns a list containing all of the elements of the originals, in order.
;;     Note that it is purely functional, i.e., it doesn't MODIFY either of the lists that it is passed.

;; (append '(1 2 3) '(4 5 6)) --> '(1 2 3 4 5 6)

;; You might want to draw out the box and pointer structures for the original two lists
;; as well as for the new list.  Confirm with a member of the instructional staff....


(define (my-append l1 l2)
  (if (empty? l1)       ;; base case
      l2
      (cons (first l1) (my-append (rest l1) l2))))  ;; recursive case; cdr down l1


;;;;;;;;;;;
;; 4.  zip takes two lists, and returns a list of elements of size two, until one of the lists runs out.

;; (zip '(1 2 3) '(4 5 6)) ;; --> '((1 4) (2 5) (3 6))
;; (zip '(1 2 3) '(a b c d e f g)) ;; --> '((1 a) (2 b) (3 c))

;; Implement `zip`.


(define (my-zip l1 l2)
  (if (or (empty? l1) (empty? l2))  ;; base case
      null
      (cons (first l1)              ;; recursive case -- add firsts of both lists
            (cons (first l2)
                  (my-zip (rest l1) (rest l2))))))  ;; and keep cdr'ing
          
          

;;;;;;;;;;;;
;; 5.  Last built-in (for now):  (my-)reverse.
;;     Takes a list, returns a new list with the elements reversed.

;; (reverse '(1 2 3)) --> '(3 2 1)

(define (my-reverse lst)
  (reverse-helper lst null))

;; this one is easier with a helper function and an extra parameter to accumulate the reversed list.

(define (reverse-helper lst so-far)
  (if (empty? lst)  ;; base case -- 
      so-far             ;; return the accumulated (reversed) list
      (reverse-helper (rest lst) (cons (first lst) so-far))))  ;; pull the first off the input...
                         ;; ...and add it to the accumulation argument



;;;;;;;;;;;;
;; More puzzles:
;;
;;  - (count elt lst) returns the number of times that elt appears in lst

(define (count elt lst)
  (count-helper elt lst 0))

;; again, a helper with an accumulator parameter (to count the number of times elt occurs)
(define (count-helper elt lst so-far)
  (if (empty? lst)  ;; base case
      so-far            ;; return accumulator
      (if (eq? elt (first lst))    ;; else recurse, counting this one if it matches
          (count-helper elt (rest lst) (+ so-far 1))
          (count-helper elt (rest lst) so-far))))

;; here's another version that takes advantage of the fact that if is an expression, not a statement.
(define (count-helper2 elt lst so-far)
  (if (empty? lst)  ;; base case
      so-far            ;; return accumulator
      ;; else recurse, 
      (count-helper2 elt (rest lst) (if (eq? elt (first lst))
                                        (+ so-far 1)  ;; counting this one if it matches
                                        so-far))))


;;  - (remove-dups lst) returns a new list that contains the elements of lst but without repeats
;;       (remove-dups '(1 2 3 1 4 5 2 4 6)) --> '(1 2 3 4 5 6)

;; The logic here is a bit convoluted.
;;   For efficiency, it is important to remove-dups from (remove (first lst) (rest lst))
;;      rather than the other way around.
(define (remove-dups lst)
  (if (empty? lst)  ;; base case
      null
      (cons (first lst)  ;; recursive case:  keep first element, but remove it from the rest
            (remove-dups (remove (first lst)  ;; and then remove dups from the result
                                 (rest lst))))))

(define (remove elt lst)
  (if (empty? lst)  ;; base case
      null
      (if (eq? elt (first lst))  ;; if the first element is the one we're removing,
          (remove elt (rest lst))            ;;    ignore first and keep gong
          (cons (first lst) (remove elt (rest lst))))))  ;; else keep it and remove elt from the rest.


      
;;  - reverse reverses a list, but doesn't reverse sublists in a tree.  (Try it and see.)
;;    Write deep-reverse, which reverses all sublists as well.



;; Note that this uses pair? which is true of cons cells.
;; Also, it does not work for non-list structures ["dotted pairs"]
(define (deep-reverse tree)
  (if (not (pair? tree))  ;; base case:  includes null, number, symbol, etc. -- atoms
      tree
      (append (deep-reverse (rest tree)) (list (deep-reverse (first tree))))))
;; recursive case has two recursive calls -- first and rest -- and requires some trickiness
;;   to reconstruct the list.  Draw the box-and-pointer-diagram if you aren't convinced.


          
;;  - Which of these can you implement using tail recursion?

;; The implementations of reverse and count are already tail recursive above.
;; (Reverse is actually tricky to implement non-tail-recursively...)
;; Here are tail-recursive implementations of the rest.

(define (tr-filter pred? lst)
  (tr-filter-helper pred? lst null))

(define (tr-filter-helper pred? lst so-far)
  (if (empty? lst) ;; base case returns accumulated answer
      (reverse so-far)    ;; note that we have to reverse the accumulator argument at the end
      (if (pred? (first lst))  ;; recursive case as before, but cons onto the accumulator
          (tr-filter-helper pred? (rest lst) (cons (first lst) so-far))
          (tr-filter-helper pred? (rest lst) so-far))))
          



(define (tr-map fn lst)
  (tr-map-helper fn lst null))

(define (tr-map-helper fn lst so-far)
  (if (empty? lst) ;; base case returns accumulated answer
      (reverse so-far)    ;; note that we have to reverse the accumulator argument at the end
      (tr-map-helper fn (rest lst) (cons (fn (first lst))  ;; and again recurse consing onto
                                         so-far))))          ;; accumulator





(define (tr-append l1 l2)
  (tr-append-helper (reverse l2) (reverse l1)))
;; the trick here is to reverse both list and accumulate from the middle to the (original) end,
;;   moving one element from l2 to what grows from l1.
;; Re-reverse at the end...

(define (tr-append-helper to-append already-appended)
  (if (empty? to-append)  ;; base case returns REVERSED accumulation
      (reverse already-appended)
      (tr-append-helper (rest to-append) (cons (first to-append) already-appended))))




(define (tr-zip l1 l2)
  (tr-zip-helper l1 l2 null))

(define (tr-zip-helper l1 l2 so-far)
  (if (or (empty? l1) (empty? l2))  ;; base case -- 
      (reverse so-far)              ;; again, REVERSE accumulation
      (tr-zip-helper (rest l1)              ;; recursive case -- cdr down both
                     (rest l2)
                     (cons (first l2)       ;; accumulating firsts
                           (cons (first l1)
                                 so-far)))))
          




(define (tr-remove-dups lst)
  (tr-remove-dups-helper lst null))

(define (tr-remove-dups-helper lst so-far)
  (if (empty? lst)  ;; base case
      (reverse so-far)    ;; reversing result
      (tr-remove-dups-helper (tr-remove (first lst) (rest lst) null)  ;; recurse, removing this elt
                             (cons (first lst) so-far))))     ;; and adding it once to accumulator

(define (tr-remove elt lst so-far)
  (if (empty? lst)  ;; base case
      (reverse so-far)
      (if (eq? elt (first lst))  ;; if the first element is the one we're removing,
          (tr-remove elt (rest lst) so-far)            ;;    ignore first and keep going
          (tr-remove elt (rest lst) (cons (first lst) so-far)))))  ;; else save first to so-far


;;; for deep-reverse, the double recursive call makes true tail recursion impossible.


