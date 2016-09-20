# FOCS Day 7 Homework

## Part 1: Finite Automata

You may use any of the following to answer these questions:

 - JFLAP
 - The DFA and NFA machines introduced in _Understanding Computation_ chapter 3 (in Ruby or translated into a language of your choice)
 - Your own home brew code (but please give us a heads up if you plan to do this, so we are prepared) 
 - Pencil and paper (in which case you should also use a scanner, please)

Upload the results to GitHub.

### 1. Nondeterministic automaton

Build an automaton to recognize the following language:

All and only strings containing the substring 1011.

### 2. Conversion to deterministic automaton

Convert the automaton you created for problem 1 into a deterministic automaton.  Provide the transition table explicitly.  (You may use JFLAP or Stuart's code to help, but you will likely learn more doing the translation by hand.  We picked a small enough machine that it shouldn't be painful.)

### 3. Larger alphabet

The automata we have considered so far accept only strings over the alphabet {0,1}.  Consider a machine that could accept strings over a larger alphabet, such as the English alphabet (`a` through `z`, at least; we'll ignore case and punctuation for the moment).  Would such a machine be more powerful?  Why or why not?  Try to construct a formal proof for your answer, at least for the alphabet {`a`,`b`,`c`,`d`}.

### 4. [*] Challenge: Reverse

Assume that you have a deterministic finite automaton A that recognizes a language L.  Show how to construct an automaton that recognizes L_reverse, that is, s is a string in L_reverse iff s_reverse -- s spelled backwards -- is in L.

Hint for prover types:  You may assume that A has a set of states Q = {q0, ... qn} and operates over the alphabet {0,1}; that A's start state is q0; that F, a subset of Q, is the set of A's accepting states; and that you have a transition table delta with rules of the form qi, x --> qj for x in {0,1}. 

Hint for coder types:  You may assume that A was created by calling (your favorite language's equivalent of) DFA.new(q, qlist, DFARulebook.new(RuleList)), where q is an integer, qlist is a list of integers, and RuleList is a list of FARules.  Write a translation program that will produce an automaton that recognizes the reversed language.

Hint for everyone:  This problem is easier if your answer is nondeterministic.

[* You are strongly encouraged to try this problem.  You are also encouraged not to get caught up in it if you are going around in circles.]

### Part 2: Regular expressions

<Oliver insert anything you want as a pre-assignment here, possibly including reading Sipser section 1.3 Regular Expressions (and/or 1.4 Nonregular Languages) or Stuart pp.79-103).>

### 5. Reading

Read Sipser section 1.3 “Regular Expressions”.

Optionally, read Stuart pp.79-103.

### 6. Regular Expression Practice

Construct a regular expression that matches *all* and *only* those strings that contain exactly one `1` (and any number of `0`s). For example, `1`, `0010`, `100`; but not `0` or `101`.
