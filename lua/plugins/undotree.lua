-- return {
--   "mbbill/undotree",
--   keys = {
--     { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undo Tree" },
--   },
--   init = function ()
--     vim.g.undotree_SetFocusWhenToggle = 1
--     vim.g.undotree_WindowLayout = 1         -- left tree + bottom diff (wider)
--   end
-- }

-- built in and has live preview

vim.cmd("packadd nvim.undotree")
vim.keymap.set("n", "<leader>u", function()
  require("undotree").open({ command = "topleft 30vnew" })
end, { desc = "Toggle Undo Tree" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "nvim-undotree",
  callback = function(ev)
    vim.keymap.set("n", "<Esc>", "<cmd>close<CR>", { buffer = ev.buf, desc = "Quit Undo Tree" })
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = ev.buf, desc = "Quit Undo Tree" })
    vim.keymap.set("n", "<CR>", "<cmd>close<CR>", { buffer = ev.buf, desc = "Confirm and close Undo Tree" })
  end,
})

return {}

-- alternative to original undo tree

-- return {
--   "jiaoshijie/undotree",
--   dependencies = "nvim-lua/plenary.nvim",
--   keys = {
--     { "<leader>u", function() require("undotree").toggle() end, desc = "Toggle Undo Tree" },
--   },
--   opts = {
--     float_diff = true,         -- floating diff panel
--     window = {
--       border = "rounded",
--     },
--     keymaps = {
--       ["J"] = "move_change_next",  -- move + apply (live preview)
--       ["K"] = "move_change_prev",
--     },
--   },
-- }
