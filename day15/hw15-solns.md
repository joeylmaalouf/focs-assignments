

# FOCS Homework 15 SOLUTION


## I. Binary search tree ordering


Assume that the following tree structures are all properly constructed binary search trees, preserving the binary search property that any (internal) node's left child is smaller than the internal node and its right child is larger (or of equal value).  

Anything labeled with a T can be assumed to be a (possibly empty) subtree (i.e., may contain zero or more nodes); anything labeled with a lower case letter is a single node.

What inequalities must hold in each of these trees?

### 0.
```
        a
       / \
      /   \
    T1     T2
```

Ans:  all elements of TI <= x <= all elements of T2

### 1.
```
        b
       / \
      /   \
     c     T3
    / \
   /   \
 T1    T2
```

Ans:  T1 <= c <= T2 <= b <= T3



### 2.
```
        d
       / \
      /   \
    T1     e
          / \
         /   \
       T2    T3
```

Ans:  T1 <= d <= T2 <= e <= T3



### 3.
```
        f
       / \
      /   \
     g     T4
    / \
   /   \
 T1     h
       / \
      /   \
    T2     T3
```

Ans:  T1 <= g <= T2 <= h <= T3 <= f <= T4



## II.  Extending this analogy:  drawing trees.

### 4. 

What other tree structures containing three internal nodes -- x, y, and z -- can exist?  Draw these and describe the inequalities that exist among the internal nodes and their subtrees.  
[Hint:  There should be four more shapes.]  
The relationship among x, y, and z doesn't matter.  For convenience, we've arbitrarily labeled them top to bottom and the subtrees left to right.


```
          i
         / \
        /   \
       j     T4
      / \
     /   \
    k     T3
   / \   
  /   \ 
T1     T2     
```

T1 <= k <= T2 <= j <= T3 <= i <= T4


```
          l
         / \
        /   \
      T1     m
            / \
           /   \
          n     T4
         / \   
        /   \ 
      T2     T3     
```

T1 <= l <= T2 <= n <= T3 <= m <= T4



```
          o
         / \
        /   \
      T1     p
            / \
           /   \
         T2     q
               / \
              /   \
            T3     T4
```

T1 <= o <= T2 <= p <= T3 <= q <= T4



```
          r
         / \
        /   \
       s     t
      /\     /\
     /  \   /  \
   T1   T2 T3   T4
```

T1 <= s <= T2 <= r <= T3 <= t <= T4





## III.  Observing balance

It is desirable for binary search trees to be balanced (or close).  If we assume that each of the T structures has the same depth, the two-internal-node trees have the following property:

For EVERY internal node (x and y), the depth of the internal node's left subtree and the depth of the internal node's right subtree differ by at most 1.  We call these trees almost-balanced.  

 
### 5. 

Does this property hold for any of the three-internal-node trees?  Which ones?  Which ones are NOT almost-balanced?  (We call these unbalanced.)

ANS:  This holds for the last one (with root r), but it might not hold for the others.  For example, in the tree in #3, it would not hold if the depth of T1 and the depth of T4 were the same (call it z), because then l would have subtrees of depth z and z+2.  This could be the case for any of the three-internal-node trees except the one with root r.


## IV.  Maintaining balance


Observe the following:

If you are given a binary tree of the form in question 1, you can transform them into the form in question 2 (and vice versa) while preserving the binary search property.  
[Since they are both almost-balanced, this doesn't help, but it also doesn't hurt.]  

### 6. 

Use this insight to show how to modify each of the unbalanced tree forms with three internal nodes into an almost-balanced tree that preserves the binary search property.

```
ANS:  We did this in class.  

If you have a tree like the one with root i, rotate the top of this tree  from the form with root b to the form with root d, i.e., make j the root:


          i
         / \
        /   \
       j     T4
      / \
     /   \
    k     T3
   / \   
  /   \ 
T1     T2     

          j
         / \
        /   \
       k     i
      /\     /\
     /  \   /  \
   T1   T2 T3   T4


Note that this preserves the inequalities and the property that the left subtree is <= the parent <= the right subtree, while restoring balance.

Similarly with the form with root o, where p becomes the root (rotating from the d form to the b form):


          o
         / \
        /   \
      T1     p
            / \
           /   \
         T2     q
               / \
              /   \
            T3     T4

          p
         / \
        /   \
       o     q
      /\     /\
     /  \   /  \
   T1   T2 T3   T4


For the final form in #3 (with root f), two rotations are necessary.  First rotate the subtree rooted at g (from the d-form to the b-form), making h the root and giving the whole tree the form of the tree with root i; then proceed as above:

        f
       / \
      /   \
     g     T4
    / \
   /   \
 T1     h
       / \
      /   \
    T2     T3



          f
         / \
        /   \
       h     T4
      / \
     /   \
    g     T3
   / \   
  /   \ 
T1     T2     


          h
         / \
        /   \
       g     f
      /\     /\
     /  \   /  \
   T1   T2 T3   T4



The form with root l is symmetric, first with a b-to-d rotation on the subtree rooted at j, and then a d-to-b rotation at the top of the tree to produce the balanced form.


          l
         / \
        /   \
      T1     m
            / \
           /   \
          n     T4
         / \   
        /   \ 
      T2     T3     


          l
         / \
        /   \
      T1     n
            / \
           /   \
         T2     m
               / \
              /   \
            T3     T4


          n
         / \
        /   \
       l     m
      /\     /\
     /  \   /  \
   T1   T2 T3  T4

```

## V.  Rebalancing

### 7. 

Verify that the following tree is almost-balanced:

For EVERY internal node (x and y), the depth of the internal node's left subtree and the depth of the internal node's right subtree differ by at most 1. 

```
         8
        / \
       /   \
      6     14
     /\      /\  
    /  \    /  \ 
   3   7   12   16  
  /\       /    /\ 
 /  \     /    /  \ 
2    5   10   15   20
                   /
                  /
                 18
```


```
Pairs indicate the depths of the left and right subtrees.  The node labeled 12 would have subtree labels (1,0).  Note that each pair has a difference of 1.  

                 8(3,4)
                / \
               /   \
         (2,1)6     14(2,3)
             /\      /\  
            /  \    /  \ 
      (1,1)3   7   12   16(1,0)  
          /\ (0,0) /    /\ 
         /  \     /    /  \ 
        2    5   10   15   20(1,0)
      (0,0)(0,0)(0,0)(0,0) /
                          /
                         18(0,0)
```


### 8. 

Insert the value 13 into this tree.  Where does it go?  Is the resulting tree almost-balanced?  If not, see #11.

```
         8
        / \
       /   \
      6     14
     /\      /\  
    /  \    /  \ 
   3   7   12   16  
  /\      /\    /\ 
 /  \    /  \  /  \ 
2    5  10 13 15  20

This only makes the tree more balanced.
```


### 9. 

Insert the value 17 into the tree.  Where does it go?  Is the resulting tree almost-balanced?  If not, see #11.

```
         8
        / \
       /   \
      6     14
     /\      /\  
    /  \    /  \ 
   3   7   12   16  
  /\      /\    /\ 
 /  \    /  \  /  \ 
2    5  10 13 15  20
                  /
                 /
                17

Still almost-balanced.
```


### 10. 

Insert the value 4 into the tree.  Where does it go?  Is the resulting tree almost-balanced?  If not, see #11.


```
         8
        / \
       /   \
      6     14
     /\      /\  
    /  \    /  \ 
   3   7   12   16  
  /\      /\    /\ 
 /  \    /  \  /  \ 
2    5  10 13 15  20
    /             /
   /             /
  4             17

No longer almost-balanced.  3 is OK (1,2), but 6 is not almost-balanced (3,1) [Note also that 8 is almost-balanced, at least before we start messing around:  (4,4)]

See next question for more.

```

### 11. 

Use the work you've done above to rebalance the tree.  Start at the newly inserted value; work up until you find an internal node that has left and right children whose depth differs by more than one.  Rebalance that subtree using the processes you created in #6.  Continue to climb the tree, rebalancing any unbalanced (not almost-balanced) nodes as you go up.

```
The subtree rooted at 6 is a problem, and it has the form described above with root f (but with an empty T3).  So following the work we did in #6, 

        6
       / \
      /   \
     3     7
    / \
   /   \
  2     5
       / 
      /   
     4    



          6
         / \
        /   \
       5     7
      / 
     /   
    3     
   / \   
  /   \ 
 2     4  
   

          5
         / \
        /   \
       3     6
      /\      \
     /  \      \
    2    4      7


Now we can stick this almost-balanced subtree back into the original tree:

          8
         / \
       /     \
      5       14
     /\        /\  
    /  \      /  \ 
   3   6     12   16  
  /\   \     /\    /\ 
 /  \   \   /  \  /  \ 
2    4   7 10 13 15  20
                     /
                    /
                  17


Climbing the tree, 8 remains almost-balanced (3,4), so we are all done.  In the general case, we might have to fix some other imbalances on the path to the root, though.

```



### 12. 

[Challenge] Assuming that a tree is almost-balanced when you make an insertion, and that that insertion may violate the almost-balanced property, can almost-balance always be restored solely by climbing the path from the newly inserted node to the root?  Will you ever have to descend another branch?  Why or why not?


```
Only the path to the root can be affected, because the children of other nodes are not changing and so their relative depths aren't changing.  The rotations described above always result in more-balanced (and shorter/lower depth) trees, so the only trouble they can cause is to one of their ancestors:  if rebalancing makes one subtree shorter by one, it is possible that a parent (i.e., a node on the path to the root) had another subtree that was already longer by one and is now longer by two.  That subtree may need rebalancing, but the process will not unbalance any of its children, only its parents.
```











