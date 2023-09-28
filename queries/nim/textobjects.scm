; ==============================================================================
; @attribute.inner
; @attribute.outer

; ==============================================================================
; @function.inner
; @function.outer

(proc_declaration body: (statement_list) @function.inner) @function.outer
(func_declaration body: (statement_list) @function.inner) @function.outer
(method_declaration body: (statement_list) @function.inner) @function.outer
(iterator_declaration body: (statement_list) @function.inner) @function.outer
(converter_declaration body: (statement_list) @function.inner) @function.outer
(template_declaration body: (statement_list) @function.inner) @function.outer
(macro_declaration body: (statement_list) @function.inner) @function.outer

(proc_expression body: (statement_list) @function.inner) @function.outer
(func_expression body: (statement_list) @function.inner) @function.outer
(iterator_expression body: (statement_list) @function.inner) @function.outer

; ==============================================================================
; @class.inner
; @class.outer

; ==============================================================================
; @conditional.inner
; @conditional.outer

(if consequence: (statement_list) @conditional.inner) @conditional.outer
(when consequence: (statement_list) @conditional.inner) @conditional.outer
(elif_branch
  consequence: (statement_list) @conditional.inner) @conditional.outer
(else_branch
  (statement_list) @conditional.inner) @conditional.outer
(case) @conditional.outer
(of_branch
  (statement_list) @conditional.inner) @conditional.outer

; ==============================================================================
; @loop.inner
; @loop.outer

(for body: (statement_list) @loop.inner) @loop.outer
(while body: (statement_list) @loop.inner) @loop.outer

; ==============================================================================
; @call.inner
; @call.outer

(call (argument_list) @call.inner) @call.outer

; ==============================================================================
; @block.inner
; @block.outer

; NOTE: there is a (block) statement but this capture is about indentation blocks

; ==============================================================================
; @parameter.inner
; @parameter.outer

; parameters when declaring
(parameter_declaration_list
  "," @_start .
  (parameter_declaration) @parameter.inner
  (#make-range! "parameter.outer" @_start @parameter.inner))

(parameter_declaration_list
  . (parameter_declaration) @parameter.inner
  . ","? @_end
(#make-range! "parameter.outer" @parameter.inner @_end))

; generic parameters when declaring
(generic_parameter_list
  "," @_start .
  (parameter_declaration) @parameter.inner
  (#make-range! "parameter.outer" @_start @parameter.inner))

(generic_parameter_list
  . (parameter_declaration) @parameter.inner
  . ","? @_end
(#make-range! "parameter.outer" @parameter.inner @_end))

; arguments when calling
(call 
  (argument_list 
    "," @_start .
    (_) @parameter.inner)
  (#make-range! "parameter.outer" @_start @parameter.inner))

(call 
  (argument_list 
    . (_) @parameter.inner
    . ","? @_end)
  (#make-range! "parameter.outer" @parameter.inner @_end))
; NOTE: intentionally not including the post-statement block (after `:`)

; containers

(array_construction 
  "," @_start .
  (_) @parameter.inner
  (#make-range! "parameter.outer" @_start @parameter.inner))

(array_construction 
  . (_) @parameter.inner
  . ","? @_end
  (#make-range! "parameter.outer" @parameter.inner @_end))

(tuple_construction 
  "," @_start .
  (_) @parameter.inner
  (#make-range! "parameter.outer" @_start @parameter.inner))

(tuple_construction 
  . (_) @parameter.inner
  . ","? @_end
  (#make-range! "parameter.outer" @parameter.inner @_end))

(curly_construction 
  "," @_start .
  (_) @parameter.inner
  (#make-range! "parameter.outer" @_start @parameter.inner))

(curly_construction 
  . (_) @parameter.inner
  . ","? @_end
  (#make-range! "parameter.outer" @parameter.inner @_end))

; generic arguments when calling
; subscript operator
; generic types
(bracket_expression
  right: 
    (argument_list 
    "," @_start .
    (_) @parameter.inner)
  (#make-range! "parameter.outer" @_start @parameter.inner))

(bracket_expression
  right: 
    (argument_list 
    . (_) @parameter.inner
    . ","? @_end)
  (#make-range! "parameter.outer" @parameter.inner @_end))

; import x,x
; import except x,x
; include x,x
; from import x,x
; bind x,x
; mixin x,x
; case of x,x
; try except x,x
(expression_list 
  "," @_start .
  (_) @parameter.inner
(#make-range! "parameter.outer" @_start @parameter.inner))

(expression_list 
  . (_) @parameter.inner
  . ","? @_end
(#make-range! "parameter.outer" @parameter.inner @_end))

; pragmas
(pragma_list 
  "," @_start .
  (_) @parameter.inner
(#make-range! "parameter.outer" @_start @parameter.inner))

(pragma_list 
  . (_) @parameter.inner
  . ","? @_end
(#make-range! "parameter.outer" @parameter.inner @_end))

; ==============================================================================
; @regex.inner
; @regex.outer

; ==============================================================================
; @comment.inner
; @comment.outer

((comment) @comment.outer @comment.inner
  (#offset! @comment.inner 0 1 0 0))

((block_comment) @comment.outer @comment.inner
  (#offset! @comment.inner 0 2 0 -2))

((documentation_comment) @comment.outer @comment.inner
  (#offset! @comment.inner 0 2 0 0))

((block_documentation_comment) @comment.outer @comment.inner
  (#offset! @comment.inner 0 3 0 -3))

; ==============================================================================
; @assignment.inner
; @assignment.outer
; @assignment.lhs
; @assignment.rhs

; ==============================================================================
; @return.inner
; @return.outer


; ==============================================================================
; @statement.outer

; ==============================================================================
; @scopename.inner

; ==============================================================================
; @number.inner
