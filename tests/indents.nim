# if true:
#   discard
#   when true:
#     discard
#   elif true:
#     discard
#   else:
#     case x:
#     of 5:
#       discard
#     elif true:
#       discard
#     else:
#       try:
#         discard
#       except:
#         discard
#       finally:
#         discard
# elif true:
#   discard
# else:
#   discard
#
# type O = object
#   case kind: int:
#   of 5:
#     yay: int
#   of 6:
#     nay: int
#   else:
#     piip: int
#   when true:
#     pipe: int
#   elif true:
#     pipo: int
#   else:
#     pipa: int
#
# let
#   x = 5
# var
#   y = 5
# const
#   z = 5
# type
#   T = object
#     x: int
#   U = tuple
#     x: int
#   V = enum
#     X
# using
#   c: int
#
# for x in 0..5:
#   discard
#   while true:
#     discard
#     block label:
#       discard
#       static:
#         discard
#
#
# proc `proc1`*[
#   GenParam1: int,
#   T
# ](
#   `param1`: int,
#   param2: int
# ): int {.
#   test
# .} =
#   discard
# func func1() =
#   discard
# method method1(parameter1: Object1) =
#   discard
# iterator iterator1(): int =
#   yield 5
# converter converter1(parameter1: int): int =
#   parameter1
# template template1() =
#   discard
# macro macro1() =
#   discard
#
let
  anonym_proc = proc( a: int, b: int,) =

#
# let anonym_func = func(param1: int) =
#   discard
# let anonym_iterator = iterator(): int =
#   yield 5
#
# sort(cities) do (x, y: string) -> int:
#   cmp(x.len, y.len)
#
# call:
#   discard
#
# if true:
#   discard (
#     echo """
#   hi
#   oh wow
#   ayaya
# """
#   )
