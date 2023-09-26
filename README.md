## nvim-treesitter-nim

[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) support for [Nim](https://nim-lang.org).

### Why is it not integrated into `nvim-treesitter`?

**TL;DR:** The parser doesn't work on macOS.

**Long version:** read the comments in the [rejected PR](https://github.com/nvim-treesitter/nvim-treesitter/pull/5437).

### Features

* [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
    * [x] Highlighting 
    * [x] Language Injection
      * SQL and RegEx strings
      * `std/strformat` strings, including debugging `=` and other 
        [quirks](https://nim-lang.org/docs/strformat.html#standard-format-specifiers-for-strings-integers-and-floats)
      * MarkDown in doc comments
      * C/Cpp/ObjC/JavaScript in emit pragma 
    * [x] Folds
    * [x] Locals
    * [ ] Indents (probably not coming any time soon).
* [x] [nvim-treesitter-refactor](https://github.com/nvim-treesitter/nvim-treesitter-refactor)
* [x] [nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context)
* [ ] [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) (coming soon)
* [ ] [vim-matchup](https://github.com/andymass/vim-matchup) (coming soon)

**NOTE:** 
In format strings `{`/`}` have to be escaped, which breaks the nim parser,
thus expressions in format strings containing `\{`/`\}` will intentionally not be parsed.

**NOTE:** 
Parsing in the emit pragma requires the language name in comment on the preceding line.
E.g.:
```nim
# cpp           <- necessary
{.emit: """
...
<cpp code>
...
""".}
```


### Installation

**Tested with Nvim 0.9.1**

**Dependencies:**

* [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

**Optional Dependencies:**

* [nvim-treesitter-refactor](https://github.com/nvim-treesitter/nvim-treesitter-refactor)
* [nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context)
* [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
* [vim-matchup](https://github.com/andymass/vim-matchup)

Like any other plugin.

E.g. with Packer:

```lua
use { "aMOPel/nvim-treesitter-nim" }
```

This plugin just registers the 
[nim Parser](https://github.com/alaviss/tree-sitter-nim) 
and the
[nim-format-string Parser](https://github.com/aMOPel/tree-sitter-nim-format-string)
with nvim-treesitter and provides the queries.

Don't forget to run

```
:TSInstall nim
:TSInstall nim_format_string
```

to actually install the Parsers.

