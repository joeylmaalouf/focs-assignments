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


## 3.


## 4.


## 5. Reading

Done.


## 6. Regular Expression Practice

`0*10*`

The first `0*` matches any number of 0s, then the `1` matches just one 1, then the other `0*` matches any number of 0s. This lets us catch anything from a 1 surrounded by no 0s to a 1 surrounded by infinitely many 0s, but it will not accept anything that has more or less than exactly one 1.

