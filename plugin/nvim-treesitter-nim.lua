if not pcall(require, "nvim-treesitter") then
  vim.notify(
    [[nvim-treesitter-nim: ERROR: Could not find nvim-treesitter module.]],
    vim.log.levels.ERROR
  )
  return
end

local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

parser_configs.nim = {
  install_info = {
    url = "https://github.com/alaviss/tree-sitter-nim",
    files = { "src/parser.c", "src/scanner.cc" },
    revision = "e0c246a87af7882da791970011e900a21e245e5e",
    cxx_standard = "c++14",
    use_makefile = true,
  },
  maintainers = { "@aMOPel" },
}

parser_configs.nim_format_string = {
  install_info = {
    url = "https://github.com/aMOPel/tree-sitter-nim-format-string",
    files = { "src/parser.c" },
    revision = "b60f0e982a74fb5df93d26a468120cfe67e7e1af",
  },
  maintainers = { "@aMOPel" },
}
