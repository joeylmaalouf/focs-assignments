# FOCS Day 5 Homework

## Part 1: Scheme

### 1. Turn your evaluator into an interpreter

A REPL ([**R**ead-**e**val-**p**rint **L**oop](https://en.wikipedia.org/wiki/Read–eval–print_loop)) is a program that repeatedly reads expressions from standard input (typically a keyboard), evaluates them, and prints them to standard output (typically a screen).

You're probably familiar with REPLs, aka interactive shells. The [the Python interpreter's interactive mode](https://docs.python.org/2/tutorial/interpreter.html#interactive-mode) is a REPL for Python. The unix command line is a REPL for a "shell language" such as `bash` or `zsh`. The Lisp family of languages pioneered the REPL. (Scheme is a dialect of Lisp. Racket is a dialect of Scheme.)

Scheme’s read is a function that takes no arguments and returns what the user types (ending with <return>.  You can see it working here:

``` scheme
(define (print-square x)
  (display "the square of ")
  (display x)
  (display " is ")
  (display (* x x)))

(display “enter a number”)
(print-square (read))
```

[Try running this code, then typing in a number followed by &lt;return&gt; when asked.]

A typical read-eval-print loop reads an expression, evaluates it (using a mechanism like your calculator), and prints the result.  Here’s a really simple read-eval-print loop that doesn’t actually do any evaluation.  This is a REPL for the “identity language” that simply echoes, without interpretation, any valid Scheme value that is entered into it: enter `5` and it prints `5`; enter `(PLUS 1 2)` and it prints `(PLUS 1 2)`.

``` scheme
(define (run-repl)
  (display "welcome to my repl.  type some scheme-ish")
  (repl))

(define (repl)
  (display "> ")
  (display (myeval (read)))
  (newline)
  (repl))

(define (myeval sexpr)
  sexpr)

;; Run this by typing (run-repl)  at scheme.
;; Note that you do not need to quote what you type in; 
;;   it is read as though it were quoted already.
```

You should modify the code above to call the calculator / evaluator you wrote for the previous homework rather than `mini-eval`.
(Alternately, you can modify the definition of `mini-eval` to do what your calculator/evaluator does.)
This will turn your one-shot calculation / evaluation program into a REPL.
Note that you will have to modify your REPL to account for the environment – the `lookup-list` – that your latest version of `evaluate` expects. 

Running your REPL should now look something like the following.
In this transcript, everything that follows a `mini-eval>> ` is typed by the user; everything else is printed by your program.
Also note the absence of quotes. 

``` scheme
(run-repl)
Welcome to my repl.
Type some scheme-ish at the prompt.
Type <return> after each expression:
mini-eval>> (ADD 3 (MUL 4 5)))
23
mini-eval>> (SUB (ADD 3 4) (MUL 5 6)))
-23
mini-eval>> (ANND (GT (ADD 3 4) (MUL 5 6)) (LE (ADD 3 (MUL 4 5)) (SUB 0 (SUB (ADD 3 4) (MUL 5 6))))))
#f
mini-eval>> (ORR (NOTT (GT (ADD 3 4) (MUL 5 6))) (NEQ (ADD 3 (MUL 4 5)) (SUB 0 (SUB (ADD 3 4) (MUL 5 6))))))
#f
mini-eval>> (IPH (GT (ADD 3 4) 7) (ADD 1 2) (ADD 1 3)))
4
```


### 2. Implement `DEFINE`


The special form `define`, like every special form, has a unique evaluation rule.  In this case, we are only going to use the simple form of `define` -- `(define foo 3)` -- and not the kind that creates a function.  Of course, if you want to create a function, you know how that is spelled (`lambda`).

This kind of `define` has two parts:  the variable name, and the body.  `define` evaluates its body in the current environment, and then calls the REPL with an appropriately extended environment:  *i.e.*, one containing the pairing of the variable name and the body, so that `assq` can find it (along with all of the prior bindings).

```
mini-eval>> (ADD 3 (MUL 4 5)))
23
mini-eval>> (DEFINE x (ADD 1 2))  ;; adds a binding x --> 3
mini-eval>> (SUB 10 x)
7
mini-eval>> x
3
```

You may find it helpful to create a helper function `DEFINE?`, that recognizes whether a value is list of the form `(DEFINE var expr)`.



### 3. Implement `LAMBDA`

Extend your REPL to recognize `LAMBDA`. `LAMBDA` returns a closure:  the parameters and body of the original lambda along with the current environment.  Implementing `LAMBDA` is pretty straightforward; the fun comes when we invoke (apply) it.

```
mini-eval>> (LAMBDA (a b) (SUM a b))
(lambda (a b) (SUM a b) ((x 3) (y 2))) ;; see note 1
mini-eval>> (DEFINE a 6)
mini-eval>> (DEFINE incr (LAMBDA (n) (SUM n 1)))
mini-eval>> incr
(lambda (n) (SUM n 1) ((a 6) (x 3) (y 2)))
```

Note 1: The printed value of a lambda expression such as `(lambda (a b) (SUM a b))` depends on the implementation of your interpreter. This is an example from my implementation, which represents a function as the lambda form that defined it plus the lookup list at that time.  I assumed that the lookup list already contained x --> 3 and y --> 2 before the first LAMBDA is evaluated.  By the time the second LAMBDA is evaluated (in the DEFINE incr line), the lookup list also contains a binding for a —> 6 (but not yet incr --> LAMBDA... 

### Intermezzo: Implementation Hints

(a) You should use the `operator-association-list` as your initial environment [This was in the solution set to the second homework, if you don’t want to create it yourself.] This creates bindings for things like `'ADD` (to scheme’s plus procedure) in the global environment.

(b) In `evaluate`, if the thing you are handed is a list, you should evaluate the first thing (the operator) and the rest of the things (the arguments), then apply the value of the operator (which might, *e.g.*, be scheme’s plussing thing, but is not `'ADD` any more, since you looked it up) to the values of the arguments. This probably means changing your apply-operator to *not* do the lookup-in-the-lookup-list step, since it happened in `evaluate`. [Again, feel free to use what was in the prior solution, but remove the lookup/assq bit.]

(c) In later stages, when you might also have a value that is a closure (*i.e.*, what you get from evaluating a LAMBDA), you can follow the instructions in the current pset for applying those….
You will do that by extending `apply-operator` to handle the closure case as described there (rather than by creating a new `apply-proc` procedure).

### 4.  Allow your user to apply `LAMBDA`s 

Finally, add the ability to invoke user-defined procedures (generated by evaluating LAMBDA).

To evaluate an expression like

```
((LAMBDA (x y) (ADD (MUL x x) (MUL y y))) 2 (SUB 4 1))
```

you will:

1. evaluate the LAMBDA, producing a closure 
2. evaluate the arguments, producing the list `(2 3)`, since `(SUB 4 1)` evaluates to 3 
3. hand off the closure and evaluated arguments to a procedure called, *e.g.*, `apply-proc`.

It is the job of `apply-proc` to pull out the parameter list – `(x y)` – and the evaluated argument list — `(2 3)` — and make them into bindings that can be added to the lookup list (in this case `(x 2)` and `(y 3)`).  Hint: `zip`. 

You’ve already developed the mechanism to add bindings to the lookup list as a part of define.  In this case, though, you’re actually creating a *new* environment -- the scope of the LAMBDA -- and that is where you will evaluate the LAMBDA body.  Now, if only you had a procedure that could evaluate an expression in a given environment....Ah, yes!


### 5. [Optional] Add list functions and expressions

Add `QUOTE`, `CONS`, `CAR`, `CDR`, and `EQ?` to your interpreter:

```
mini-eval>> (QUOTE (SUM a b))
(SUM a b)
mini-eval>> (CAR (QUOTE (SUM a b)))
SUM
mini-eval>> (CDR (QUOTE (SUM a b)))
(a b)
mini-eval>> (CONS 1 (QUOTE (2)))
(1 2)
```

Now you have a complete Scheme interpreter, that is itself written in Scheme.

In fact, if you supplied your definitions of `zip` and other functions that you used (which is totally doable), you could use your interpreter to run a copy of your interpreter.

This is called a [meta-circular evaluator](https://en.wikipedia.org/wiki/Meta-circular_evaluator).

How difficult would it be to write a meta-circular evaluator for another languages that you know?


## Part 2: JFLAP

1. Download and install JFLAP.
2. Open the interface and see what you can discover.  If you can’t figure anything out and it confuses you, never mind and we’ll talk about it in class.
3. If you can get JFLAP to draw some stuff, you might see whether you can solve the following problem:

Build a finite state machine that recognizes *all* and *only* those strings that contain exactly one `1` (and any number of `0`s). For example, `1`, `0010`, `100`; but not `0` or `101`.

Again, it’s fine if you can’t get this to work. Don’t spend time being frustrated.
