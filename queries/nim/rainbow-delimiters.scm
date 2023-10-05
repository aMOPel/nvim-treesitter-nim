(array_construction "[" @opening "]" @closing) @container
(tuple_construction "(" @opening ")" @closing) @container
(tuple_deconstruct_declaration "(" @opening ")" @closing) @container
(curly_construction "{" @opening ":"? @intermediate "}" @closing) @container

(parenthesized "(" @opening ")" @closing) @container

(argument_list "(" @opening ")" @closing) @container
(parameter_declaration_list "(" @opening ")" @closing) @container

(bracket_expression "[" @opening "]" @closing) @container
(field_declaration_list "[" @opening "]" @closing) @container
(generic_parameter_list "[" @opening "]" @closing) @container

(cast type: "[" @opening type: "]" @closing) @container
(cast value: "(" @opening value: ")" @closing) @container

(term_rewriting_pattern "{" @opening "}" @closing) @container
(curly_expression "{" @opening "}" @closing) @container
