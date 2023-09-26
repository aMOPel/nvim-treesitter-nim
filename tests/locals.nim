# var/const declaration
let `var1`*: int = 5
#   ^ definition.var
#            ^ definition.associated
discard var1
var var2: int = 5
#   ^ definition.var
#         ^ definition.associated
discard var2
const `const1`*: int = 5
#     ^ definition.constant
#                ^ definition.associated
discard const1

# scopes in stmts
for for_var1, for_var2 in 0..5:
# <- scope
#   ^ definition.var
#             ^ definition.var
  discard for_var1
while true: 
  discard
# <- scope
if true: 
#  ^ scope
  discard
elif true:
# <- scope
  discard
else:
# <- scope
  discard
when true: 
  discard
elif true:
  discard
else:
  discard
case var1:
  of 1: 
# ^ scope
    discard
  of 2: 
# ^ scope
    discard
  elif true: 
# ^ scope
    discard
  elif true: 
# ^ scope
    discard
  else: 
# ^ scope
    discard
block label:
# <- scope
  break label
try:
  discard
# ^ scope
except Error as `e`:
# <- scope
#               ^ definition.var
  discard
finally:
# <- scope
  discard

# scopes in expressions
let var3 = if true: 5 else: 4
#                  ^ scope
#                     ^ scope
let var4 = when true: 5 else: 4
let var5 = case var1:
  of 1: 5
# ^ scope
  else: 4
# ^ scope
let var6 = block:
#          ^ scope
  4
let var7 = try:
    5
  # ^ scope
  except Error as `e`:
# ^ scope
#                 ^ definition.var
    5
  finally:
# ^ scope
    discard

# scopes in object/tuple declaration
type Object1 = object
#    ^ definition.type
  prop1: int
# ^ definition.field
#        ^ definition.associated
  `prop2`*, `prop3`*: int
# ^ definition.field
#           ^ definition.field
#                     ^ definition.associated
type `Tuple1`* = tuple
#    ^ definition.type
  `prop1`: int
# ^ definition.field
#          ^ definition.associated
  prop2: int
# ^ definition.field
#        ^ definition.associated
type Enum1* = enum One, Two
#    ^ definition.type
#                  ^ definition.enum
#                       ^ definition.enum

# scopes in routines
proc `proc1`*[GenParam1: int](`param1`, param2: int) = discard
# <- scope
#    ^ definition.function
#             ^ definition.parameter
#                        ^ definition.associated
#                             ^ definition.parameter
#                                       ^ definition.parameter
#                                               ^ definition.associated
func func1() = discard
# <- scope
#    ^ definition.function
method method1(parameter1: Object1) = discard
# <- scope
#    ^ definition.function
#              ^ definition.parameter
#                          ^ definition.associated
iterator iterator1(): int = yield 5
# <- scope
#        ^ definition.function
converter converter1(parameter1: int): int = parameter1
# <- scope
#         ^ definition.function
#                    ^ definition.parameter
#                                ^ definition.associated
template template1() = discard
# <- scope
#       ^ definition.function
macro macro1() = discard
# <- scope
#     ^ definition.function

# routine expressions
let anonym_proc = proc(param1: int) =
  discard
#                 ^ scope
#                      ^ definition.parameter
let anonym_func = func(param1: int) =
  discard
#                 ^ scope
#                      ^ definition.parameter
let anonym_iterator = iterator(): int =
  yield 5
#                     ^ scope

# import declarations
import std/sets
#          ^ definition.namespace
import std/[tables, strformat]
#           ^ definition.namespace
#                   ^ definition.namespace
from std/strutils import `%`, format, addf
#        ^ definition.namespace
#                        ^ definition.import
#                             ^ definition.import
#                                     ^ definition.import

static:
# <- scope
  discard
