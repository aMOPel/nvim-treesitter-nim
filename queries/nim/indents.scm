

(if
  alternative: (elif_branch)* @indent.begin @indent.dedent
  alternative: (else_branch)? @indent.begin @indent.dedent) @indent.begin

(when
  alternative: (elif_branch)* @indent.begin @indent.dedent
  alternative: (else_branch)? @indent.begin @indent.dedent) @indent.begin

(case
  (of_branch)+ @indent.begin
  (elif_branch)* @indent.begin
  (else_branch)? @indent.begin)

(variant_declaration
  (of_branch)+ @indent.begin
  (else_branch)? @indent.begin)

(try
  (except_branch) @indent.begin @indent.dedent
  (finally_branch)? @indent.begin @indent.dedent) @indent.begin

[
  (const_section)
  (let_section)
  (var_section)
  (type_section)
  (using_section)

  (for)
  (while)
  (block)
  (static_statement)

  (do_block)
  ; (call
  ;   (argument_list
  ;     (statement_list)))


  (proc_declaration)
  (func_declaration)
  (method_declaration)
  (iterator_declaration)
  (converter_declaration)
  (template_declaration)
  (macro_declaration)

  (proc_expression)
  (func_expression)
  (iterator_expression)
] @indent.begin

; [
;   (generic_parameter_list)
; ] @indent.dedent

; [
;   (ERROR "(")
;   (ERROR "[")
;   (ERROR "{")
;   (_ "(")
;   (_ "[")
;   (_ "{")
; ] @indent.begin

; (ERROR "(" @indent.align
;   (#set! indent.open_delimiter "(")
;   (#set! indent.close_delimiter ")"))
; (ERROR "[" @indent.align
;   (#set! indent.open_delimiter "[")
;   (#set! indent.close_delimiter "]"))
; (ERROR "{" @indent.align
;   (#set! indent.open_delimiter "{")
;   (#set! indent.close_delimiter "}"))

; (_ "(" @indent.align
;   (#set! indent.open_delimiter "(")
;   (#set! indent.close_delimiter ")"))
; (_ "[" @indent.align
;   (#set! indent.open_delimiter "[")
;   (#set! indent.close_delimiter "]"))
; (_ "{" @indent.align
;   (#set! indent.open_delimiter "{")
;   (#set! indent.close_delimiter "}"))

; ([
;   (object_declaration)
;   (tuple_type)
;   (enum_declaration)
; ] @indent.begin (#set! indent.immediate 1))

; [
;   ")"
;   "]"
;   "}"
; ] @indent.branch

((var_type "var") @indent.begin
  (#set! indent.immediate 1))

(ERROR [
  "let"
  "var" ; BUG: not working
  "const"
  "type"
  "using"
] ":" @indent.begin (#set! indent.immediate 1))

(ERROR [
  "for"
  "while"
  "block"
  "static"
  "if"
  "when"
  "case"
  "of"
  "elif"
  "else"
  "else"
  "try"
  "except"
  "finally"
] ":" @indent.begin (#set! indent.immediate 1))

(call
  function: (identifier) 
  (argument_list ":" (statement_list)) 
  ) @indent.branch
