#lang racket

;;; Student Name: Solution Set
;;;
;;; Check one:
;;; [ ] I completed this assignment without assistance or external resources.
;;; [X] I completed this assignment with assistance from ALL COURSE STAFF
;;;     and/or using these external resources: ___

(define operator-association-list
  (list (list 'ADD +)
	(list 'SUB -)
	(list 'MUL *)
	(list 'DIV /)
	(list 'GT >)
	(list 'LT <)
	(list 'GE >=)
	(list 'LE <=)
	(list 'EQ =)
	(list 'NEQ  (lambda args (not (apply = args))))
	(list 'ANND (lambda (x y) (and x y)))
	(list 'ORR  (lambda (x y) (or x y)))
	(list 'NOTT not)))


(define (run-repl)
  (display "Welcome to my repl.")
  (newline)
  (display "Type some scheme-ish at the prompt.")
  (newline)
  (display "Type <return> after each expression:")
  (newline)
  (repl operator-association-list))   ;; start repl with built-in procedure names defined

(define (repl env)
  (display "mini-eval>> ")
  (display (evaluate (read) env))
  (newline)
  (repl env))


(define (lookup-variable var env)
  (let ((binding (assq var env)))  ;; look up var in the env association list
    (if binding
        (second binding)
        (error "lookup-variable: unbound variable " var))))

(define (apply-proc proc args)
  (cond [(procedure? proc) (apply proc args)]   ;; Handle built-in (primitive, native) procs.
        [(and (list? proc)                      ;; Else it's user-defined (via a lambda)
              (eq? (first proc) 'CLOSURE)) (evaluate (third proc)  ;; so eval proc body
                                                ;; in the (CLOSURE) environment PLUS param-arg bindings
                                                     (extend-environment (second proc) ;; (params)
                                                                         args
                                                                         (fourth proc)))]))
                                                                         ;; (closure env)

(define (extend-environment params args env)
  (cond [(and (null? params) (null? args)) env]  ;; Nothing more to add; return the current environment.
        [(or (null? params) (null? args)) (error "extend-environment: mismatch of parameters and arguments" (list 'params params 'args 'args))]
        [else (extend-environment (rest params)
                                  (rest args)    ;; Recursively cdr down the param-arg lists,
                                  (cons (list (first params) (first args))
                                        env))])) ;; using the environment extended with the
                                                 ;; first param-arg pairing.

(define (evaluate expr env)
  (cond [(null? expr) expr]                       ;; Base cases:  self-evaluating empty list,
        [(number? expr) expr]                     ;;              self-evaluating numbers
        [(boolean? expr) expr]                    ;;              and booleans;
        [(symbol? expr) (lookup-variable expr env)]  ;;        Symbols (names) need looking up.

        ;; Otherwise the expression begins with (.  Check special forms first:

        ;; IPH is a conditional
        [(eq? (first expr) 'IPH) (if (evaluate (second expr) env)    ;; if the TEST is true
                                     (evaluate (third expr) env)     ;; evaluate the THEN
                                     (evaluate (fourth expr) env))]  ;; otherwise the ELSE

        ;; DEFINE causes us to evaluate in a different environment (with an added binding)
        [(eq? (first expr) 'DEFINE) (repl (cons (list (second expr)  ;; invoke REPL w/
                                                      (evaluate (third expr) env)) ;; extended env
                                                env))]   ;; (now includes this definition)
        ;; QUOTE doesn't evaluate its argument
        [(eq? (first expr) 'QUOTE) (second expr)]

        ;; LAMBDA creates a closure -- the procedure parameters, body, and current environment
        [(eq? (first expr) 'LAMBDA) (list 'CLOSURE (second expr) (third expr) env)]

        ;; Otherwise it's a "regular" procedure -- built-in or lambda.  Evaluate it and all args,
        ;;   then apply the value of the procedure to the value of the arguments.
        [(list? expr) (apply-proc (evaluate (first expr) env)
                                  (map (lambda (expr) (evaluate expr env))
                                       (rest expr)))]

        ;; Otherwise oops!
        [else (error "evaluate:  not sure what to do with expr" expr)]))


(define (mini-eval sexpr)
  sexpr)

(run-repl)
