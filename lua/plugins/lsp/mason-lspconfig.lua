-- Bridges mason.nvim <-> nvim-lspconfig for Neovim 0.11+'s native LSP API.
-- It installs the servers below via Mason and then automatically calls
-- `vim.lsp.enable()` for each one that's installed -- no manual
-- `require('lspconfig').xxx.setup{}` calls needed.
--
-- Per-server settings (cmd, filetypes, settings, etc.) live in
-- after/lsp/<server>.lua at the config root, not here. See :h lsp-config.
return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    "mason-org/mason.nvim",
    "neovim/nvim-lspconfig",
  },
  opts = {
    -- Guaranteed-installed servers: cpp, markdown, yaml, json, python
    ensure_installed = {
      "clangd", -- C / C++
      "basedpyright", -- Python
      "yamlls", -- YAML
      "jsonls", -- JSON
      "marksman", -- Markdown
      "rust_analyzer", -- Rust duh
    },
    automatic_enable = {
      "clangd",
      "basedpyright",
      "yamlls",
      "jsonls",
      "marksman",
      "rust_analyzer",
    },
  },
}
