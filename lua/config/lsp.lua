-- Global LSP behavior: diagnostics UI and buffer-local keymaps shared by
-- every language server. This is a plain Lua module (require("config.lsp")),
-- NOT the special Neovim runtime `lsp/` directory used for server configs --
-- that one lives at the config root: see lsp/ and after/lsp/ for
-- per-server overrides (settings, cmd, filetypes), auto-merged by
-- vim.lsp.config()/vim.lsp.enable(). See :h lsp-config.

-- Diagnostics: sorted by severity, rounded floating windows, gutter icons
vim.diagnostic.config({
  severity_sort = true,
  underline = true,
  virtual_text = { spacing = 4, source = "if_many" },
  float = { border = "rounded", source = true },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
  },
})

-- NOTE: hover/signature-help/diagnostic float borders are handled globally
-- by `vim.o.winborder` in config/options.lua (0.11+), not per-handler here
-- (the old `vim.lsp.with(handler, {border=...})` wrapper is deprecated).

-- Buffer-local keymaps, wired up once per buffer an LSP client attaches to
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Configure buffer-local LSP keymaps",
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local bufnr = event.buf
    local fzf = require("fzf-lua")

    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
    end

    map("n", "gd", fzf.lsp_definitions, "Goto Definition")
    map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
    map("n", "gr", fzf.lsp_references, "Goto References")
    map("n", "gI", fzf.lsp_implementations, "Goto Implementation")
    map("n", "gy", fzf.lsp_typedefs, "Goto Type Definition")
    map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
    map("n", "gK", vim.lsp.buf.signature_help, "Function Signature Help (just K is hover btw)")
    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
    map("n", "<leader>ds", fzf.lsp_document_symbols, "Document Symbols")
    map("n", "<leader>ws", fzf.lsp_workspace_symbols, "Workspace Symbols")
    map("n", "]d", function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, "Next Diagnostic")
    map("n", "[d", function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, "Prev Diagnostic")

    -- Toggle inlay hints on servers that support them (clangd, basedpyright, ...)
    if client and client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      map("n", "<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
      end, "Toggle Inlay Hints")
    end
  end,
})
