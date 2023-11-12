const
  C1 = 5
const C2 = 5
var 
  v1 = 5
  v2 = 5
var v3 = 5
let 
  L1 = 5
  L2 = 5
let L3 = 5
type
  O = object
    f1: int
    f2: int
  T = int
  T = tuple
    f1: int
    f2: int
  T = int
  E = enum
    One
    Two
using
  c: int
  d: int

for for_var1, for_var2 in 0..5:
  while true: 
    if true: 
      discard
    elif true:
      discard
    else:
      when true: 
        discard
      elif true:
        discard
      else:
        case var1:
        of 1: 
          discard
        of 2: 
          discard
        elif true: 
          discard
        elif true: 
          discard
          discard
          discard
          discard
        else: 
          block label:
            break label

proc `proc1`*[GenParam1: int](`param1`, param2: int) =
  discard
func func1() =
  discard
method method1(parameter1: Object1) =
  discard
iterator iterator1(): int =
  yield 5
converter converter1(parameter1: int): int =
  parameter1
template template1() =
  discard
  discard
  discard
  discard
macro macro1() =
  discard

let anonym_proc = proc(param1: int) =
  discard
let anonym_func = func(param1: int) =
  discard
let anonym_iterator = iterator(): int =
  yield 5

static:
  let a = 5
  discard a
  {.test.}:
    discard a


sort(cities) do (x, y: string) -> int:
  cmp(x.len, y.len)

call:
  discard

try:
  discard
except error as e:
  discard
finally:
  discard

type
  Comparable = concept x, y
    discard
  Stack[T] = concept s, var v
    discard
  MyConcept = concept x, var v, ref r, ptr p, static s, type T
    discard
  Graph = concept g, type G of MyConcept, Stack[int]
    discard
