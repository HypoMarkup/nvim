-- Entry point inside VSCode (vscode-neovim), see init.lua.
-- Same options, keymaps and autocmds as normal nvim, but only the plugins
-- listed below load.

-- Use VSCode's clipboard, so no xclip/xsel needed
-- (vscode-neovim only does this by itself on WSL)
vim.g.clipboard = vim.g.vscode_clipboard

require("config.options")
require("config.keymaps")
require("config.autocmds")

vim.opt.timeoutlen = 600 -- Neovim's default; 300 only works natively because which-key holds the sequence
vim.opt.winbar = "" -- it shows grapple tags, and grapple doesn't load here

-- Ctrl+F opens VSCode's find. To let VSCode handle Ctrl+F directly instead,
-- leave "f" out of "vscode-neovim.ctrlKeysForNormalMode" in settings.json.
vim.keymap.set("n", "<C-f>", function() require("vscode").action("actions.find") end)
vim.keymap.set("n", "/", "<Nop>")

-- remap = true so these go through vscode-neovim's own <C-w> maps and move
-- between editor groups (the versions in keymaps.lua bypass those)
vim.keymap.set("n", "<leader>w", "<C-w>", { remap = true, desc = "Window prefix (alias for C-w)" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { remap = true, desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { remap = true, desc = "Move to down window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { remap = true, desc = "Move to up window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { remap = true, desc = "Move to right window" })

-- Native keys, pointed at the VSCode equivalents
local vscode = require("vscode")
for lhs, cmd in pairs({
  ["<leader>ff"] = "workbench.action.quickOpen",
  ["<leader>fg"] = "workbench.action.findInFiles",
  ["<leader>fb"] = "workbench.action.showAllEditors",
  ["<leader>fr"] = "workbench.action.openRecent",
  ["<leader>e"] = "workbench.view.explorer",
  ["-"] = "workbench.files.action.showActiveFileInExplorer", -- oil's key, reveals the file instead
  ["<leader>t"] = "workbench.action.terminal.toggleTerminal",
  ["<leader>rn"] = "editor.action.rename",
  ["<leader>ds"] = "workbench.action.gotoSymbol",

  ["]d"] = "editor.action.marker.next",
  ["[d"] = "editor.action.marker.prev",
  ["]h"] = "workbench.action.editor.nextChange",
  ["[h"] = "workbench.action.editor.previousChange",
  ["za"] = "editor.toggleFold",
  ["zc"] = "editor.fold",
  ["zo"] = "editor.unfold",
  ["zM"] = "editor.foldAll",
  ["zR"] = "editor.unfoldAll",
  ["gr"] = "editor.action.referenceSearch.trigger",

  ["gI"] = "editor.action.goToImplementation",
  ["gy"] = "editor.action.goToTypeDefinition",
  ["gK"] = "editor.action.triggerParameterHints",
  ["gS"] = "workbench.action.showAllSymbols",
  ["<leader>ca"] = "editor.action.quickFix",
  ["<leader>D"] = "editor.action.showHover", -- shows the error under the cursor
}) do
  vim.keymap.set("n", lhs, function() vscode.action(cmd) end)
end
vim.keymap.set("n", "<leader>fw", function()
  vscode.action("workbench.action.findInFiles", { args = { query = vim.fn.expand("<cword>") } })
end)

-- lazy reads the same plugin specs as normal nvim, but only these load. The
-- rest stay installed and in the lockfile, they just never load or map keys.
local plugins = {
  "lazy.nvim",
  "flash.nvim",
  "nvim-surround",
  "nvim-treesitter-textobjects", -- works without nvim-treesitter, the parsers are shared
  "vim-cool",
}

vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim") -- installed by normal nvim
require("lazy").setup({
  spec = {
    { import = "plugins" },
    { import = "plugins.lsp" },
  },
  defaults = {
    cond = function(plugin)
      return vim.tbl_contains(plugins, plugin.name)
    end,
  },
  checker = { enabled = false },
  change_detection = { enabled = false },
})
