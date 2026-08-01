return {
  "nvim-treesitter/nvim-treesitter",
  cond = not vim.g.vscode,
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    -- Ensure these parsers are installed
    require("nvim-treesitter").install({
      "c",
      "cpp",
      "rust",
      "go",
      "python",
      "markdown",
      "markdown_inline",
      "typst",
      "json",
      "yaml",
      "toml",
      "xml",
    })

    -- Auto-install missing parsers and enable highlighting for any filetype
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local treesitter = require("nvim-treesitter")
        local lang = vim.treesitter.language.get_lang(args.match)
        if not lang then
          return
        end
        if not vim.list_contains(treesitter.get_available(), lang) then
          return
        end
        if not vim.list_contains(treesitter.get_installed(), lang) then
          treesitter.install(lang):wait()
        end
        vim.treesitter.start(args.buf)

        -- Indentation based on the syntax tree (experimental)
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
      desc = "Enable treesitter highlighting, folding, indentation, auto-installing missing parsers",
    })
  end,
}
