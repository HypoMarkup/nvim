-- Disable arrow keys to force hjkl usage in all but insert
local arrows = { "<Up>", "<Down>", "<Left>", "<Right>" }
for _, key in ipairs(arrows) do
  vim.keymap.set({ "n", "v" }, key, "<Nop>", { desc = "Disabled arrow key" })
end

-- Space is the leader key, don't let it move the cursor
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Window management: <leader>w as <C-w> alias, plus direct <C-h/j/k/l> navigation
vim.keymap.set("n", "<leader>w", "<C-w>", { desc = "Window prefix (alias for C-w)" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to down window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to up window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Treesitter incremental selection (built into Neovim core via vim.treesitter._select,
-- replaces the old nvim-treesitter `incremental_selection` module removed on the `main` branch)
vim.keymap.set("n", "<CR>", function()
  vim.cmd.normal({ "v", bang = true })
  require("vim.treesitter._select").select_child(vim.v.count1)
end, { desc = "Init treesitter incremental selection" })

vim.keymap.set("x", "<CR>", function()
  require("vim.treesitter._select").select_parent(vim.v.count1)
end, { desc = "Expand treesitter selection to parent node" })

vim.keymap.set("x", "<BS>", function()
  require("vim.treesitter._select").select_child(vim.v.count1)
end, { desc = "Shrink treesitter selection to child node" })

-- Alias :W to :w
vim.api.nvim_create_user_command("W", "w", {})

-- Code actions from lsp for generating stubs
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "Code Actions" })



-- ; and , repeat textobject moves (]m, [m, etc.) -- defined in plugins/textobjects.lua

-- Tab indenting like vscode in visual mode, with reselection of visual block after
vim.keymap.set("x", "<Tab>",   ">gv", { desc = "Indent and keep selection" })
vim.keymap.set("x", "<S-Tab>", "<gv", { desc = "Outdent and keep selection" })

vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "X", '"_X')

vim.keymap.set("n", "c", '"_c')
vim.keymap.set("n", "C", '"_C')
vim.keymap.set("n", "cc", '"_cc')

-- Pasting over a visual selection won't change the yank register
vim.keymap.set("x", "p", '"_dP')

-- Anti J
vim.keymap.set('n', '<leader><CR>', 'i<CR><Esc>', { desc = 'Split line at cursor, opposite of J' })

vim.keymap.set({ "n", "x", "o" }, "L", "g_", { desc = "Last non-blank" })
vim.keymap.set({ "n", "x", "o" }, "H", "^", { desc = "First non-blank" })

-- Easy substitiute bind, g = global, c = confim, I = case must match
vim.keymap.set("n", "<leader>s",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gcI<Left><Left><Left><Left>]],
  { desc = "Substitute word under cursor" })

-- save file
vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<cmd>write<CR><Esc>", { desc = "Save file" })

-- yank whole file, magic to not mess with the cursor
vim.keymap.set("n", "<leader>y", function()
  local view = vim.fn.winsaveview()
  vim.cmd('keepjumps normal! ggVG"+y')
  vim.fn.winrestview(view)
end, { desc = "Yank whole file" })

vim.keymap.set('n', '<leader>=', '`[=`]', { desc = 'Reindent last paste/change' })

vim.keymap.set('n', 'gp', '`[v`]', { desc = 'Select last paste' })

-- Normal mode: move line, reindent, select
vim.keymap.set("n", "<leader>J", "<cmd>m .+1<CR>==V", { desc = "Move line down and select" })
vim.keymap.set("n", "<leader>K", "<cmd>m .-2<CR>==V", { desc = "Move line up and select" })

-- Visual mode: move selection, reindent, reselect
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Make current file executable
vim.keymap.set("n", "<leader>cx", "<cmd>!chmod +x %<CR>", { desc = "Make file executable" })

-- Open project root (cwd) in VS Code
vim.keymap.set("n", "<leader>c.", function()
  vim.cmd("silent !code " .. vim.fn.fnameescape(vim.uv.cwd()))
end, { desc = "Open project root in VS Code" })

-- Open Neovim config in VS Code
vim.keymap.set("n", "<leader>cc", function()
  vim.cmd("silent !code " .. vim.fn.fnameescape(vim.fn.stdpath("config")))
end, { desc = "Open Neovim config in VS Code" })

-- Copy current file name and full path to clipboard
vim.keymap.set(
  "n",
  "<leader>cpf",
  '<cmd>let @+ = expand("%:p")<CR><cmd>lua print("Copied path to: " .. vim.fn.expand("%:p"))<CR>',
  { desc = "Copy current file name and path", silent = false }
)

-- Paste blocks copied from outside nvim below or above with a break blockwise rather than on curor pos
vim.keymap.set("n", "<leader>p", "o<Esc>o<Esc>]p", { desc = "Paste external block below" })
vim.keymap.set("n", "<leader>P", "O<Esc>O<Esc>[p", { desc = "Paste external block above" })

-- Insert blank lines like ] space but move with
vim.keymap.set("n", "<leader>o", "o<esc>", { desc = "Blank line below and move down" })
vim.keymap.set("n", "<leader>O", "O<esc>", { desc = "Blank line above and move up" })
