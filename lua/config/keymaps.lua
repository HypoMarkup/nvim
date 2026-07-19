-- Disable arrow keys to force hjkl usage in all but insert
local arrows = { "<Up>", "<Down>", "<Left>", "<Right>" }
for _, key in ipairs(arrows) do
  vim.keymap.set({ "n", "v" }, key, "<Nop>", { desc = "Disabled arrow key" })
end

-- Space is the leader key, don't let it move the cursor
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Open the dashboard (warn if current buffer has unsaved changes)
vim.keymap.set("n", "<leader>q", function()
  if vim.bo.modified then
    local choice = vim.fn.confirm("Save changes before opening dashboard?", "&Yes\n&No\n&Cancel", 1)
    if choice == 1 then
      vim.cmd("write")
    elseif choice == 0 or choice == 3 then
      return -- cancelled, stay in the current buffer
    end
  end
  Snacks.dashboard.open()
end, { desc = "Open Dashboard" })

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

-- File explorer sidebar
vim.keymap.set("n", "<leader>e", function() Snacks.explorer() end, { desc = "Toggle Explorer" })

-- Tab indenting like vscode in visual mode, with reselection of visual block after
vim.keymap.set("x", "<Tab>",   ">gv", { desc = "Indent and keep selection" })
vim.keymap.set("x", "<S-Tab>", "<gv", { desc = "Outdent and keep selection" })
