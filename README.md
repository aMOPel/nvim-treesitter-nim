## nvim-treesitter-nim

[**nvim-treesitter**](https://github.com/nvim-treesitter/nvim-treesitter) support for [**Nim**](https://nim-lang.org).

### Why is it not part of `nvim-treesitter`?

**TL;DR:** The `scanner.cc` in the [**Nim Parser**](https://github.com/alaviss/tree-sitter-nim)
uses `C++14` Standard,
which creates problems on `macOS` due to the way `nvim-treesitter` handles
parser compilation. A special compiler flag is needed in that case,
for which support is going to be dropped in the upcoming release of `nvim-treesitter`.

With `nvim-treesitter < v1.0.0` this plugin should work fine on `macOS`.

**UPDATE:** The `scanner.cc` will be rewritten eventually and another PR
to `nvim-treesitter` will follow. So this plugin remains a temporary measure.

**Long version:** read the comments in the [rejected PR](https://github.com/nvim-treesitter/nvim-treesitter/pull/5437).

---

### Features

- [**nvim-treesitter**](https://github.com/nvim-treesitter/nvim-treesitter)
  - [x] Highlighting
  - [x] Language Injection
    - `SQL` and `RegEx` strings
    - `std/strformat` strings, including debugging `=` and other
      [quirks](https://nim-lang.org/docs/strformat.html#standard-format-specifiers-for-strings-integers-and-floats) (see [Notes](#format-strings))
    - `MarkDown` in documentation comments
    - `C/Cpp/ObjC/JavaScript` in emit pragma (see [Notes](#emit-pragma))
  - [x] Folds
  - [x] Locals
  - [ ] Indents (probably not coming any time soon).
- [x] [**nvim-treesitter-refactor**](https://github.com/nvim-treesitter/nvim-treesitter-refactor)
- [x] [**nvim-treesitter-context**](https://github.com/nvim-treesitter/nvim-treesitter-context)
- [x] [**nvim-treesitter-textobjects**](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) (see [Notes](#nvim-treesitter-textobjects))
- [x] [**vim-matchup**](https://github.com/andymass/vim-matchup) (see [Notes](#vim-matchup))
- [x] [**rainbow-delimiters.nvim**](https://github.com/HiPhish/rainbow-delimiters.nvim)
- [x] [**nim.nvim**](https://github.com/alaviss/nim.nvim) synergy with semantic highlights (see [Notes](#nimnvim))

See [`tests/`](./tests/) for explicit examples of supported features.

---

### Installation

**Tested with `NeoVim 0.9.1`**

#### Step 0

**Dependencies:**

- [**nvim-treesitter**](https://github.com/nvim-treesitter/nvim-treesitter)

**Optional Dependencies:**

- [**nvim-treesitter-refactor**](https://github.com/nvim-treesitter/nvim-treesitter-refactor)
- [**nvim-treesitter-context**](https://github.com/nvim-treesitter/nvim-treesitter-context)
- [**nvim-treesitter-textobjects**](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
- [**vim-matchup**](https://github.com/andymass/vim-matchup)
- [**rainbow-delimiters.nvim**](https://github.com/HiPhish/rainbow-delimiters.nvim)

**Recommended:**

- [**nim.nvim**](https://github.com/alaviss/nim.nvim)
  (for semantic highlights and indents)

#### Step 1

Install the plugin like any other.

E.g. with `Packer`:

```lua
use {
  "aMOPel/nvim-treesitter-nim",
  -- install/update parsers
  run = {
    ':TSUpdate nim',
    ':TSUpdate nim_format_string',
  },
}
```

#### (Step 2)

This plugin just registers the
[**Nim Parser**](https://github.com/alaviss/tree-sitter-nim)
and the
[**nim-format-string Parser**](https://github.com/aMOPel/tree-sitter-nim-format-string)
with `nvim-treesitter` and provides the queries.

You still need to run

```vim
:TSInstall nim
" for `std/strformat` format strings
:TSInstall nim_format_string
```

manually to actually install the parsers,
if it doesn't happen via your package manager hook.

---

### NOTES

#### Format Strings

**Requires** `:TSInstall nim_format_string`.

In format strings `{`/`}` have to be escaped, which breaks the `Nim parser`,
thus expressions in format strings containing `\{`/`\}` will intentionally not be parsed.

#### Emit Pragma

Parsing in the emit pragma requires the language name in comment with a space on the preceding line.
E.g.:

```nim
# cpp           <- necessary
{.emit: """
...
<cpp code>
...
""".}
```

#### nvim-treesitter-textobjects

Support for

```scheme
@function.inner
@function.outer
@conditional.inner
@conditional.outer
@loop.inner
@loop.outer
@call.inner
@call.outer
@parameter.inner
@parameter.outer
@comment.inner
@comment.outer
@assignment.inner
@assignment.outer
@assignment.lhs
@assignment.rhs
@return.inner
@return.outer
@statement.outer
@number.inner
```

NO support for

```scheme
@attribute.inner
@attribute.outer
@class.inner
@class.outer
@block.inner
@block.outer
@regex.inner
@regex.outer
@scopename.inner
```

#### vim-matchup

It's recommended to disable the virtual text for the closing scope, since it
will not be accurate.

```lua
require 'nvim-treesitter.configs'.setup {
-- ...
  matchup = {
    enable = true,
    disable_virtual_text = {"nim"},
  },
-- ...
}
```

#### nim.nvim

This plugin relinks and disables some semantic highlights from `nim.nvim`
to harmonize with the `Tree-sitter` highlights. (See [./ftplugin/nim.vim](./ftplugin/nim.vim))
