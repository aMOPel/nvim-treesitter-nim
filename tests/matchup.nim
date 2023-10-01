for for_var1, for_var2 in 0..5:
  continue
  break

while true: 
  continue
  break

block label:
  break label

if true: 
  discard
elif true:
  discard
elif true:
  discard
else:
  discard
when true: 
  discard
elif true:
  discard
elif true:
  discard
else:
  discard

case var1:
of 1: 
  if true: 
    discard
  elif true:
    discard
  elif true:
    discard
  else:
    when true: 
      discard
    elif true:
      discard
    elif true:
      discard
    else:
      discard
of 2: 
  discard
elif true: 
  discard
elif true: 
  discard
else: 
  discard

type 
  O = object
    case x: int:
    of 5:
      a:int
    of 6:
      b:int
    else:
      d:int
  P = object
    when true:
      a:int
    elif true:
      b:int
    else:
      c:int

let a = if true: discard else: discard
let b = when true: discard else: discard
let c = case x: 
  of 5: discard
  else: discard

try:
  discard
except error as e:
  discard
finally:
  discard

proc `proc1`*[GenParam1: int](`param1`, param2: int) =
  return
func func1() =
  return
method method1(parameter1: Object1) =
  return
iterator iterator1(): int =
  yield 5
converter converter1(parameter1: int): int =
  return parameter1
template template1() =
  return
macro macro1() =
  return

let anonym_proc = proc(param1: int) =
  return
let anonym_func = func(param1: int) =
  return
let anonym_iterator = iterator(): int =
  yield 5

import std/strutils except `%`, toUpperAscii
from std/strutils import `%`, toUpperAscii

##[
asdf
]##
let a = "asdf"
let a = r"asdf"
let a = R"asdf"
#[
asdf
]#
{.asdf}
let a{.asdf.} = 'a'
let a = fmt"""
{5}
{{}}
"""
let a = r""" """
let a = R""" """

