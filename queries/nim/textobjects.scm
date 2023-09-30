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

[
  (if)
  (when)
  (case)
] @conditional.outer

(if 
  consequence: 
    (statement_list
      . (_)? @_start
      (_) @_end .)
    (#make-range! "conditional.inner" @_start @_end))
(when 
  consequence: 
    (statement_list
      . (_)? @_start
      (_) @_end .)
    (#make-range! "conditional.inner" @_start @_end))
(elif_branch 
  "elif" @_outer_start
  consequence: 
    (statement_list
      . (_)? @_start
      (_) @_end .)
    (#make-range! "conditional.inner" @_start @_end)
    (#make-range! "conditional.outer" @_outer_start @_end))
(else_branch 
  "else" @_outer_start
  (statement_list
    . (_)? @_start
    (_) @_end .)
  (#make-range! "conditional.inner" @_start @_end)
  (#make-range! "conditional.outer" @_outer_start @_end))
((case
  ":" . (_) @_start (_)? @_end .)
  (#make-range! "conditional.inner" @_start @_end))
(of_branch 
  "of" @_outer_start
  (statement_list
    . (_)? @_start
    (_) @_end .)
  (#make-range! "conditional.inner" @_start @_end)
  (#make-range! "conditional.outer" @_outer_start @_end))

; ==============================================================================
; @loop.inner
; @loop.outer

(for body: (statement_list) @loop.inner) @loop.outer
(while body: (statement_list) @loop.inner) @loop.outer

; ==============================================================================
; @call.inner
; @call.outer

(call (argument_list) @call.inner) @call.outer
; NOTE: parenthesis are included in @call.inner, but there are problems
; when excluding them, since there is also the cmd call syntax

; ==============================================================================
; @block.inner
; @block.outer

; NOTE: there is a (block) statement but this capture is about indentation blocks
; NOTE: no easy way to catch all "blocks", also there is just the indent text object

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

(variable_declaration
  (symbol_declaration_list) @_symbols
  type: (_)? @_type
  value: "="
  value: (_) @assignment.rhs @assignment.inner
  (#make-range! "assignment.lhs" @_symbols @_type)) @assignment.outer

(type_declaration
  (type_symbol_declaration) @assignment.lhs
  . "="
  . (_  (_) @_end .) @_start
  (#make-range! "assignment.rhs" @_start @_end)
  (#make-range! "assignment.inner" @_start @_end)
  (#make-range! "assignment.outer" @assignment.lhs @_end))
; NOTE: ranges are necessary, so multiline types don't reach until next line

(assignment
  left: (_) @assignment.lhs 
  right: (_) @assignment.rhs @assignment.inner) @assignment.outer

; default parameter in proc decl
; keyword argument in call
; array construction
(colon_expression
  left: (_) @assignment.lhs 
  right: (_) @assignment.rhs @assignment.inner) @assignment.outer

; object construction
; tuple construction
; table construction
(equal_expression
  left: (_) @assignment.lhs 
  right: (_) @assignment.rhs @assignment.inner) @assignment.outer

; object types
; tuple types
(field_declaration
  (symbol_declaration_list) @_symbols
  type: (_)? @_type
  value: "="?
  value: (_)? @assignment.rhs @assignment.inner
  (#make-range! "assignment.lhs" @_symbols @_type)) @assignment.outer

; enum types
(enum_field_declaration
  (symbol_declaration) @assignment.lhs
  "="?
  value: (_)? @assignment.rhs @assignment.inner) @assignment.outer


; ==============================================================================
; @return.inner
; @return.outer

(return_statement (_) @return.inner) @return.outer

; ==============================================================================
; @statement.outer

[
  ; simple
  (import_statement)
  (import_from_statement)
  (export_statement)
  (include_statement)
  (discard_statement)
  (return_statement)
  (raise_statement)
  (yield_statement)
  (break_statement)
  (continue_statement)
  (assembly_statement)
  (bind_statement)
  (mixin_statement)
  (pragma_statement)

  ; complex
  (while)
  (static_statement)
  (defer)

  ; declarations
  (proc_declaration)
  (func_declaration)
  (method_declaration)
  (iterator_declaration)
  (macro_declaration)
  (template_declaration)
  (converter_declaration)
  (using_section)
  (const_section)
  (let_section)
  (var_section)
  (type_section)

  ; expression statements
  (block)
  (if)
  (when)
  (case)
  (try)
  (for)
  (assignment)
  ; NOTE: not including 
  ; simple_expression, call, infix_expression, prefix_expression
  ; because it would confusing 
] @statement.outer

; ==============================================================================
; @scopename.inner

; ==============================================================================
; @number.inner

[
  (integer_literal)
  (float_literal)
] @number.inner
