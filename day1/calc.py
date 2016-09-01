def calc_simple(l):
  res = None
  op = None
  for i in l:
    if type(i) == int or type(i) == float:
      if res is None:
        res = i
      else:
        res = eval(str(res) + op + str(i))
    elif type(i) == str:
      op = i
  return res

def calc_rpn(l):
  stack = []
  for i in l:
    if type(i) == int or type(i) == float:
      stack.append(i)
    elif type(i) == str:
      a, b = stack.pop(), stack.pop()
      stack.append(eval(str(b) + i + str(a)))
  return stack[0]

if __name__ == "__main__":
  l = [3, "+", 4, "*", 2]
  print(calc_simple(l))
  l = [3, 4, "+", 2, "*"]
  print(calc_rpn(l))
  l = [2, 3, 4, "+", "*"]
  print(calc_rpn(l))
