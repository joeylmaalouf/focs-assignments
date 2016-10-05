# FOCS Day 10 In Class

## 1.

Consider the following context-free grammar G:

```
E -> E + E | T         # <- added "| T"
T -> T x T | (E) | a
```

a. What are its terminals?

b. What are its variables?

c. How many rules does it have?

d. What is its start variable? (Assume this grammar's presentation follows the usual conventions)?

e. List three strings that in this grammar's language.

f. List three strings not in this grammar's language.

## 2.

Convert the grammar in (1) to a PDA.

## 3.

Convert the grammar in (1) to Chomsky Normal Form.

## 4.

Is the language in (1) a regular language? If yes, produce a FSA or regular expression for this language. If not, show this. 

## 5.

The language {a^n b^n c^n} is not a context-free language. (Challenge: use the pumping lemma for context-free languages to show this.)

[Edit: "Context Free Pumping Lemma" -> "pumping lemma for context-free grammars".]

Use this fact and the languages {a^i b^i c^j} and {a^i b^j c^j} to show that the set of context-free languages is not closed under intersection.

## 6.

Consider the context-free grammar G:

```
S   -> NP VP
NP  -> NP PP
NP  -> DET N
VP  -> V NP
VP  -> VP PP
DET -> a | the
N   -> boy | girl | flowers | binoculars
V   -> touches | sees
PP  -> P NP
P   -> in | from | with
```

a. Show that the string "the girl touches the boy with the flower" has two
different leftmost derivations.

b. Describe in English the two different meanings of this sentence.

c. Use G to generate another ambiguous sentence.

d. Modify G so that it generates strings with adjectives: `the girl saw the tall boy`, `the girl touches the boy with a purple flower`.

You don't need to know this, but here's how the variable names relate to linguistics.

Variable | meaning
---------|---
S        | sentence
DET      | determiner (article)
N        | noun
NP       | noun phrase
P        | preposition
PP       | prepositional phrase
V        | verb
VP       | verb phrase

[Adapted from Sipser 2.8.]
