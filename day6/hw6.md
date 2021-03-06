# FSM and RegEx Homework

## 1. Nondeterministic automaton

![](1.png)

[(JFLAP file here)](1.jff)

Transition table:

|                 | __0__           | __1__                            |
|-----------------|-----------------|----------------------------------|
| _q<sub>0</sub>_ | _q<sub>0</sub>_ | _q<sub>0</sub>_, _q<sub>1</sub>_ |
| _q<sub>1</sub>_ | _q<sub>2</sub>_ | _q<sub>*</sub>_                  |
| _q<sub>2</sub>_ | _q<sub>*</sub>_ | _q<sub>3</sub>_                  |
| _q<sub>3</sub>_ | _q<sub>*</sub>_ | _q<sub>4</sub>_                  |
| _q<sub>4</sub>_ | _q<sub>4</sub>_ | _q<sub>4</sub>_                  |


## 2. Conversion to deterministic automaton

![](2.png)

[(JFLAP file here)](2.jff)

Transition table:

|                 | __0__           | __1__           |
|-----------------|-----------------|-----------------|
| _q<sub>0</sub>_ | _q<sub>0</sub>_ | _q<sub>1</sub>_ |
| _q<sub>1</sub>_ | _q<sub>2</sub>_ | _q<sub>0</sub>_ |
| _q<sub>2</sub>_ | _q<sub>0</sub>_ | _q<sub>3</sub>_ |
| _q<sub>3</sub>_ | _q<sub>0</sub>_ | _q<sub>4</sub>_ |
| _q<sub>4</sub>_ | _q<sub>4</sub>_ | _q<sub>4</sub>_ |


## 3. Larger alphabet

Yes, a machine that can accept strings over `{a, b, c, d}` is more powerful than a machine that can accept strings over `{0, 1}`. This is because the `abcd` machine can do everything that the `01` machine can, and more; it can perfectly mimic the `01` machine by swapping `0` for `a` and `1` for `b`, but it can also accept more complex cases (or the same cases in a simpler manner) by also using `c` and `d`.


## 4. Reverse

To make an automaton that recognizes L_reverse, you should be able to just reverse everything in the automaton that recognizes L. Make the initial state into the final state, make the final state into the initial state, and flip all of the transitions to go the other way.

The example that made me get it:

![](4.png)


## 5. Reading

Done.


## 6. Regular Expression Practice

`0*10*`

The first `0*` matches any number of 0s, then the `1` matches just one 1, then the other `0*` matches any number of 0s. This lets us catch anything from a 1 surrounded by no 0s to a 1 surrounded by infinitely many 0s, but it will not accept anything that has more or less than exactly one 1.

