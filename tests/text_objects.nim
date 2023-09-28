

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
