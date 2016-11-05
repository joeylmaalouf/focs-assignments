# Course : Olin ENGR3520
# Author : Oliver Steele
# Date   : 2016-11-03
# License: MIT

##
# This implementation uses a nested function. It is more compact and efficient, but
# drawing its recursion graph and applying memoization is less straightforward.

def binary_search_array_1(x, xs):
    """Return the index of x within the sorted list xs.
    Similar to `xs.index(x)` where xs is sorted.

    Warning: This implementation contains a bug."""
    def h(left, right):
        if left == right: return None
        middle = int((left + right) / 2)
        if x < xs[middle]:
            return h(left, middle)
        elif xs[middle] < x:
            return h(middle, right)
        else:
            return middle
    return h(0, len(xs))

assert binary_search_array_1(3, [1, 3, 4, 6, 7, 8, 10, 13, 14]) == 1
assert binary_search_array_1(8, [1, 3, 4, 6, 7, 8, 10, 13, 14]) == 5
assert binary_search_array_1(0, [1, 3, 4, 6, 7, 8, 10, 13, 14]) == None
assert binary_search_array_1(14, [1, 3, 4, 6, 7, 8, 10, 13, 14]) == 8


##
# This implementation uses a helper function instead of a nested function.

def binary_search_array_2(x, xs):
    """Return the index of x within the sorted list xs.
    Similar to `xs.index(x)` where xs is sorted.

    Warning: This implementation contains a bug."""
    return binary_search_array_helper(x, xs, 0, len(xs))


def binary_search_array_helper(x, xs, left, right):
    """Return the index of x within the sorted list slice xs[left:right].
    This function is a helper for binary_search_array below."""

    if left == right: return None
    middle = int((left + right) / 2)
    if x < xs[middle]:
        return binary_search_array_helper(x, xs, left, middle)
    elif xs[middle] < x:
        return binary_search_array_helper(x, xs, middle, right)
    else:
        return middle

assert binary_search_array_2(3, [1, 3, 4, 6, 7, 8, 10, 13, 14]) == 1
assert binary_search_array_2(8, [1, 3, 4, 6, 7, 8, 10, 13, 14]) == 5
assert binary_search_array_2(0, [1, 3, 4, 6, 7, 8, 10, 13, 14]) == None
assert binary_search_array_2(14, [1, 3, 4, 6, 7, 8, 10, 13, 14]) == 8

##
# This implementation memoizes the helper function.

def memoized_binary_search_array(x, xs):
    """Return the index of x within the sorted list xs.
    Similar to `xs.index(x)` where xs is sorted.

    Warning: This implementation contains a bug."""
    return memoized_binary_search_array_helper(x, xs, 0, len(xs))

MEMOIZED_BINARY_SEARCH_ARRAY_HELPER_HASH = {}

def memoized_binary_search_array_helper(x, xs, left, right):
    key = (x, tuple(xs), left, right)
    if key in MEMOIZED_BINARY_SEARCH_ARRAY_HELPER_HASH:
        return MEMOIZED_BINARY_SEARCH_ARRAY_HELPER_HASH[key]
    value = binary_search_array_helper_for_memoization(x, xs, left, right)
    MEMOIZED_BINARY_SEARCH_ARRAY_HELPER_HASH[key] = value
    return value

def binary_search_array_helper_for_memoization(x, xs, left, right):
    """Return the index of x within the sorted list slice xs[left:right].
    This function is a helper for binary_search_array below."""

    if left == right: return None
    middle = int((left + right) / 2)
    if x < xs[middle]:
        return memoized_binary_search_array_helper(x, xs, left, middle)
    elif xs[middle] < x:
        return memoized_binary_search_array_helper(x, xs, middle, right)
    else:
        return middle

assert memoized_binary_search_array(3, [1, 3, 4, 6, 7, 8, 10, 13, 14]) == 1
assert memoized_binary_search_array(8, [1, 3, 4, 6, 7, 8, 10, 13, 14]) == 5
assert memoized_binary_search_array(0, [1, 3, 4, 6, 7, 8, 10, 13, 14]) == None
assert memoized_binary_search_array(14, [1, 3, 4, 6, 7, 8, 10, 13, 14]) == 8
