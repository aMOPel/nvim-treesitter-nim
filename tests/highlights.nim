# many of these code snippets come from
# https://nim-lang.org/docs/manual.html
# Authors: Andreas Rumpf, Zahary Karadjov

const literals* = (true, false, on, off,
  5, 5.0, 5e5, 5i32, 5.0d, 0xadf,
  'c', '\n',
  "asdf\n",
  r"asdf\n",
  """
  asdf\n
  """,
  r"""asdf
  \n""",
  )

type X = ref object
var a*: X = nil
# enum
type 
  `Enum1`* {.pure.} = enum one, two, three
  Enum2* = enum 
    one="hi", two=4, three=(5,"test")

discard `Enum1`.one

# array
type 
  Array1* = array[0..1, seq[array[`Enum1`, int]]]
  Array2* = array[`Enum1`.one..`Enum1`.two, int]
const arr1*: Array1 = [@[], @[[`Enum1`.one:1,`Enum1`.two:2,3]]]
discard arr1[0]
const test = 3
let arr2* = [1:"hi", 2:"bye", test:"shy"]
let arr3* = [1..5, 6..8]

discard arr3[test..6]

# varargs
# BUG: `$` falsly highlighted as @type, but impossible to distinguish
proc myWriteln*(f: File, a: varargs[string, `$`]) = discard

# tuple
type
  # BUG: nimsuggest inconsistent, 
  # doesn't capture tuple field definition but references
  # and does capture object field definition and references
  Person = tuple[name: string, age: int]
  OneField* = tuple
    name: string

let one_field*: (int,) = (name:5,)
var person*: Person
person = (name: "Peter", age: 30)
assert person.name == "Peter"
person = ("Peter", 30)
assert person[0] == "Peter"
assert Person is (string, int)
assert (string, int) is Person
assert person is Person
assert person isnot Person
assert Person isnot tuple[other: string, age: int]

proc returnsNestedTuple(): (int, (int, int), int, int) = (4, (5, 7), 2, 3)
let (t1*, (_, t2*), _, t3*) = returnsNestedTuple()

const (const1*, (`const2`*)) = (1,(2,))

# object
type
  Person1* = object of RootObj
    name*: string = "default"
    age: int = 5
  Pref* = ref Person1
  GenObj[T] = object
    a, b, c*: T
  `12`* = object
    a: int

discard `12`(a:5)

import 
  std/strutils as su,
  std/sequtils as qu
import lib/pure/strutils as strutils
import dir / [moduleA, moduleB]
from std/strutils import `%`
import B
export B.MyObject
import foo/bar/baz
export baz

import external_module
let
  p1 = Person1(name:"a", age:5)
  # BUG: not recognized as constructor
  A* = GenObj[int](a:5)

  # BUG: nimsuggest doesn't capture quantified type
  B* = external_module.ExternalGenObj[int](a:5)

assert B is external_module.ExternalGenObj[seq[seq[int]]]
discard sizeof(5)

type
  NodeKind = enum  # the different node types
    nkInt,          # a leaf with an integer value
    nkFloat,        # a leaf with a float value
    nkString,       # a leaf with a string value
    nkAdd,          # an addition
    nkSub,          # a subtraction
    nkIf            # an if statement
  Node = ref NodeObj
  NodeObj = object
    # BUG: nimsuggest these are definitions and should not be captured 
    # BUG: nimsuggest fails to capture discriminator field, if it is accent_quoted
    case `kind`*: NodeKind  # the `kind` field is the discriminator
    of nkInt: `intVal`*: int
    of nkFloat: floatVal: float
    of nkString: strVal: string
    of nkAdd, nkSub:
      leftOp, rightOp: seq[Node]
    of nkIf:
      condition*, thenPart, elsePart: Node
    else:
      b: int
  # BUG: nimsuggest should not capture definition
  NodeObj1* = object
    # BUG: nimsuggest only catches path that will happen.
    # it should instead capture everything that's not gonna happen 
    when false:
      a: int
    elif false:
      b: int
    else:
      b: int

var x* = Node(kind: nkAdd, 
  leftOp: @[
    Node(kind: nkAdd, leftOp: @[Node(kind: nkInt, intVal: 2)],
                      rightOp: @[Node(kind: nkInt, intVal: 2)])
    ],
  rightOp: @[Node(kind: nkInt, intVal: 2)])

x.leftOp[0].leftOp[0].kind = nkInt

# BUG: nimsuggest should not capture definition, as it doesn't with anything else
proc getIdentity(x: var Node): var Node =
  result = x

x.getIdentity().kind = nkInt

# generics
let
  # BUG: that's where the nesting gets too much
  C* = GenObj[seq[array[Enum1.one..Enum1.two, seq[array[(-5*10).. -1,
  seq[seq[array[test..test, int]]]]]]]](a: @[])
  unknownKindBounded* = range[Enum1.one..Enum1.two](Enum1.one)
  D* = GenObj[array[(-5*0).. 0, int]](a: [1])

# sets
var set1*: set[char]
set1 = {'a'..'z', '0'..'9'}
discard 'a' in set1

# pointer and refs
var p2 = (ref Person1)(name:"a", age:5)
p2[] = p1 # ref accessor
p2[] = p2[] # ref accessor
p2 = nil
var d* = cast[ptr Person1](alloc0(sizeof(Person1)))

# procs
type Proc1* = proc(a, b: var int, c: GenObj[seq[array[0..5, int]]]): void {.nimcall.}
type Proc2* = proc(
  a,
  b: proc(a, b: proc(a, b: GenObj[seq[array[0..test, int]]]) {.nimcall.}) {.nimcall.},
  c: GenObj[seq[array[0..5, int]]]
): void {.nimcall.}
proc proc1*[T: int|float, S](a, b: T, _: seq[S]): var GenObj[int] {.nimcall.} = 
  var x = GenObj[int](a:5,b:5,c:5)
  result = x
discard proc1(5, 1, @["hi"])
discard proc1[int, string](a=5, b=1, @["hi"])

# BUG: nimsuggest captures quantified function call with generic argument 4 times
external_module.externalGenProc1[int](5)
external_module.externalGenProc1[:seq[seq[int]]](5)
external_module.externalGenProc2()

discard 5+5 {.test.}

5.echo("abc")
5.0.echo
'a'.echo
"a".echo
"""a""".echo
[5].echo
@[5].echo
(5,).echo
{5..10}.echo
{"hi":5}.echo

# type qualifiers
type 
  TypeQualifiers*[T] = distinct ref ptr T
  Dollar = distinct int
  Euro* {.borrow: `.`.} = distinct Dollar

proc `+` (x, y: Dollar): Dollar =
  result = Dollar(int(x) + int(y))

let cash = 15.Dollar
discard cash + 12.Dollar

# BUG: nimsuggest inconsistent, doesn't capture template definition but references
# but does capture macro definition and references
# template
template additive*(typ: typedesc) =
  # BUG: nimsuggest captures break down in template
  proc `+` *(x, y: typ): typ {.borrow.}

# iterator
iterator iota*(n: int): int =
  for i in 0..<n: yield i

for (i,j) in pairs([0..10]):
  discard i
  discard j

# statement list expression
let stmtList* = (( discard; 
discard; 5 ))

# static
static:
  discard

echo static(123)

# const
const roundPi* = 3.1415

# generalized string
proc `0`(`a`: string) = discard
`0`"hi"

# try except

try:
  discard
except external_module.ExternalRefGenObj[seq[seq[int]]] as e:
  discard e

try:
  discard
except 
  external_module.ExternalRefGenObj[seq[seq[int]]], 
  external_module.ExternalRefGenObj[seq[seq[int]]]:
  discard e

const xxx = [1,2,3]
const `yyy` = [2,3]
let arr4* = [`yyy`[xxx[0]]: 1]

let choice = 3
case choice:
of xxx[0]:
  discard
of xxx[1]:
  discard
of xxx[2]:
  discard
else:
  block label:
    break label

discard 5
discard 5.0
discard nil
discard 'a'
discard "hi"
discard """hi
"""
discard []
discard @[]
discard (5,)
discard {}
discard {:}
discard {:}

template optMul{`*`(a, 2)}(a: int): int = a + a
template canonMul{`*`(a, b)}(a: int{lit}, b: int): int = b * a
template t{(0|1|2){x}}(x: untyped): untyped = x + 1
template t{x = (~x){y} and (~x){z}}(x, y, z: bool) =
proc somefunc(s: static[string])

type
  Comparable = concept x, y
    discard
  Stack[T] = concept s, var v
    discard
  MyConcept = concept x, var v, ref r, ptr p, static s, type T
    discard
  Graph = concept g, type G of MyConcept, Stack[int]
    discard
