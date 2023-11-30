# =============================================================================
# generalized strings

# regex
import std/re
let
  regex1 = re"([a-z]*\s{5})"
  regex2 = re"""([a-z]*
  \s{5})"""
  regex3 = rex"([a-z]*\s{5})"
  regex4 = rex"""([a-z]*\s{5}
  )"""
  regex5 = prex"""([a-z]*\s{5}
  )"""

# sql
import db_connector/db_sqlite
let
  sql1 = sql"INSERT INTO my_table (colA, colB, colC) VALUES (?, ?, ?)"
  sql2 = sql"""
  INSERT INTO my_table (colA, colB, colC) VALUES (?, ?, ?);
  INSERT INTO my_table (colA, colB, colC) VALUES (?, ?, ?);
  """

import std/strformat
# format strings
let
  format1 = &"asdf{{{(5,5) = :w^+#04321.12X}asdf{{}}"
  format2 = &""" {{{ \{5,4\} }}}
  """
  format3 = fmt"{{{ \{5,4\} }}}"
  format4 = fmt"""asdf{{
  {(5,5) = :w^+#04321.12X}
  asdf{{}}
  """

# define your own generalized strings and get injection
proc html(s: string) =
  discard

let html1 = html"""
<!DOCTYPE html>
<html>
  <body>
  <div>Hello World</div>
  </body>
</html>
"""

# =============================================================================
# emit pragma

# BUG: previous block swallows (comment) and breaks injections
#javascript
{.emit: """
function addInt(a_33557050, b_33557051) {
  var result = a_33557050 + b_33557051;
  checkOverflowInt(result);
  return result;
}
""".}

#javascript
{.emit: """
function addInt(a_33557050, b_33557051) {
  var result = a_33557050 + b_33557051;
  checkOverflowInt(result);
  return result;
}
""".}

#javascript
{.emit: r"""
function addInt(a_33557050, b_33557051) {
  var result = a_33557050 + b_33557051;
  checkOverflowInt(result);
  return result;
}
""".}

#javascript
{.emit: R"""
function addInt(a_33557050, b_33557051) {
  var result = a_33557050 + b_33557051;
  checkOverflowInt(result);
  return result;
}
""".}

#javascript
{.emit: "checkOverflowInt(result);".}

#javascript
{.emit: r"checkOverflowInt(result);".}

#javascript
{.emit: R"checkOverflowInt(result);".}

#objc
{.emit: """
#include <objc/Object.h>
@interface Greeter:Object
{
}

- (void)greet:(long)x y:(long)dummy;
@end

#include <stdio.h>
@implementation Greeter

- (void)greet:(long)x y:(long)dummy
{
  printf("Hello, World!\n");
}
@end

#include <stdlib.h>
""".}

#objc
{.emit: "checkOverflowInt(result);".}

#cpp
{.emit: """/*TYPESECTION*/
struct Vector3 {
public:
  Vector3(): x(5) {}
  Vector3(float x_): x(x_) {}
  float x;
};
""".}

#cpp
{.emit: "checkOverflowInt(result);".}

# =============================================================================
# asm statement

#javascript
asm """
function addInt(a_33557050, b_33557051) {
  var result = a_33557050 + b_33557051;
  checkOverflowInt(result);
  return result;
}
"""

# =============================================================================
# markdown in doc comments

## `code` ~~strikethrough~~  **fat** *thin* 

##[
# header
## header2
```nim
import std/re
let
  regex1 = re"([a-z]*\s{5})"
  regex2 = re"""([a-z]*
  \s{5})"""
  regex3 = rex"([a-z]*\s{5})"
  regex4 = rex"""([a-z]*\s{5}
  )"""
```

]##

