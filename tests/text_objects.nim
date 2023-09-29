
# functions

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

# loops and conditionals
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
          discard

case var1:
of 5:
  discard

# parameters
proc a[t: int, x:int](a,b: int = 5, c:int) = discard
let b = proc (a,b: int = 5, c:int) = discard

type O = object
  a: int
  b: int
let c = (
  [0, 1],
  [0:0, 1:1],
  @[0, 1],
  (0, 1),
  (a:0, b:1),
  {0, 1},
  {0:0, 1:1},
  O(a: 1, b: 1),
)

discard c[0]
a[int, int](5,5,c=5)
b 5,5,5
b 5,5:
  5

type x = array[0..1, int]

import std/[re, strutils]
import std/re, std/strutils

import std/strutils except `%`, toUpperAscii
from std/strutils import `%`, toUpperAscii

include fileA, fileB, fileC

bind a,a
mixin a,a

let x = 5
case x:
of 4,5: discard
else: discard

try:discard
except Error, Berror: discard

{.asdf: asdf, asdf.}

# comments

# normal comment
#[ block 
comment
]#

## doc comment
##[ block doc
comment
]##

# assignments

var
  x = 1
  y:int {.asdf.} = 1
x = 5
type 
  O[T]{.asd.} = object of RootObj
    a: int = 5
    b: T
  T = tuple
    a: int = 5
    b: int
  E = enum
    A = "a"
    B = "b"

let c = (
  [0:0, 1:1],
  (a:0, b:1),
  {0:0, 1:1},
  O(a: 1, b: 1),
)
