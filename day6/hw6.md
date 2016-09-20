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
| _q<sub>1</sub>_ | _q<sub>2</sub>_ | _q<sub>1</sub>_ |
| _q<sub>2</sub>_ | _q<sub>0</sub>_ | _q<sub>3</sub>_ |
| _q<sub>3</sub>_ | _q<sub>0</sub>_ | _q<sub>4</sub>_ |
| _q<sub>4</sub>_ | _q<sub>4</sub>_ | _q<sub>4</sub>_ |


## 3.


## 4.


## 5.


## 6.

