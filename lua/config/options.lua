-- General options

-- Leader key (must be set before any <leader> keymaps)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.clipboard = "unnamedplus" -- use system clipboard for yank/paste

-- Indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Store undos across sessions
vim.opt.undofile = true

-- Mouse mode
vim.opt.mouse = "a"

-- Search
vim.opt.ignorecase = true -- case-insensitive search...
vim.opt.smartcase = true -- ...unless the search has an uppercase letter

-- Wrapped lines keep the indent of the original line
vim.opt.breakindent = true

-- Keep 8 lines of context above/below the cursor when scrolling
vim.opt.scrolloff = 8

-- Always show the sign column so text doesn't shift
vim.opt.signcolumn = "yes"

-- Split windows to the right and below
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Faster completion / CursorHold events, snappy hover detection
vim.opt.updatetime = 250

-- Faster mapped-sequence timeout
vim.opt.timeoutlen = 300

-- True color support
vim.opt.termguicolors = true

-- Rounded borders on every floating window (LSP hover/signature-help/
-- diagnostics, :help, completion menu, etc.) -- replaces the old per-handler
-- `vim.lsp.with(handler, { border = "rounded" })` wrapping (deprecated in 0.11+)
vim.opt.winborder = "rounded"

-- Prompt to save instead of erroring on unsaved buffer close
vim.opt.confirm = true

-- Show whitespace: tabs, trailing spaces, and invisible/nbsp chars that
-- silently break things (non-breaking space, zero-width space)
vim.opt.list = true
vim.opt.listchars = {
  tab = "» ",
  -- trail = "·",
  nbsp = "␣",
  extends = "…",
  precedes = "…",
}

-- Folding: start with everything open (folds are computed but not collapsed)
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

-- Statusline: native with Grapple tag indicators
vim.opt.statusline = " %f %m%r%= %{%v:lua.require'grapple'.statusline()%} %l:%c "
vim.opt.laststatus = 3
