-- JSON/YAML schema catalog (package.json, tsconfig.json, GitHub Actions, etc.)
-- consumed by after/lsp/jsonls.lua and after/lsp/yamlls.lua. `lazy = true`
-- with no other trigger just means: don't eagerly load it, but let lazy.nvim's
-- require() hook load it the first time `require("schemastore")` is called.
return {
  "b0o/schemastore.nvim",
  cond = not vim.g.vscode,
  lazy = true,
}
