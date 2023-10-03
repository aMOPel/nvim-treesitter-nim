if exists("b:did_ftplugin2")
  finish
endif
let b:did_ftplugin2 = 1

" rather leave those blank
highlight link nimSugVar NONE
highlight link nimSugGlobalVar NONE
highlight link nimSugLet NONE
highlight link nimSugGlobalLet NONE

" already taken care of
highlight link nimSugResult NONE
" USELESS: only applies to declaration of label not its references
highlight link nimSugLabel NONE
" USELESS: only applies to module names in import statement,
" not module name references
" BUG: breaks when using `import std/strutils`
highlight link nimSugModule NONE

" useful to also catch calls without arguments
" but it's weir to have all operators captured as function calls
highlight link nimSugProc NONE
highlight link nimSugFunc NONE
highlight link nimSugMethod NONE
highlight link nimSugIterator NONE
highlight link nimSugConverter NONE
highlight link nimSugMacro NONE
highlight link nimSugTemplate NONE

" MISSING: has ForVar but no ExceptVar
" for references to `e` in `except Error as e:`
highlight link nimSugForVar @parameter

highlight link nimSugParam @parameter

" BUG: breaks when reference to type is accent_quoted
" BUG: captures static expression as type
highlight link nimSugType @type

" USELESS: only captures references to generic params in routine definitions,
" which is fine,
" however declarations of generic params get captured as nimSugType,
" (which overrules treesitter highlights)
highlight link nimSugGenericParam @type

highlight link nimSugField @field
highlight link nimSugConst @constant

" BUG: breaks when specifying the enum type, eg `Enum1.One`
highlight link nimSugEnumField @constant

highlight link nimSugUnknown @error
