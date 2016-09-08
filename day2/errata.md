# Errata

This line in `hw1.rkt`:

``` scheme
(display (fact 2)) (newline) ;; -> 1
```

should read:

``` scheme
(display (fact 2)) (newline) ;; -> 2
```

That is, `(fact 1)` is indeed 1, but `(fact 2)` should evaluate to 2 * 1 = 2.

We're leaving the error in this file in order, to prevent you from having to deal with a git file merge when you pull again.
