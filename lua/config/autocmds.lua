-- Briefly highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Auto-detect file changes from outside Neovim (like lazyvim)
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave", "CursorHold" }, {
  desc = "Check for file changes outside Neovim",
  group = vim.api.nvim_create_augroup("checktime", { clear = true }),
  command = "checktime",
})

-- Hide relative numbers while typing
-- restore them on leaving insert mode
local numbertoggle = vim.api.nvim_create_augroup("numbertoggle", { clear = true })
vim.api.nvim_create_autocmd("InsertEnter", {
  desc = "Disable relative numbers in insert mode",
  group = numbertoggle,
  callback = function()
    vim.opt.relativenumber = false
  end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
  desc = "Re-enable relative numbers on leaving insert mode",
  group = numbertoggle,
  callback = function()
    vim.opt.relativenumber = true
  end,
})

-- Close popup/read-only windows with q (help, quickfix, man, etc.)
vim.api.nvim_create_autocmd("FileType", {
  desc = "Map q to close popup windows",
  group = vim.api.nvim_create_augroup("close-with-q", { clear = true }),
  pattern = {
    "help",
    "qf",
    "man",
    "notify",
    "lspinfo",
    "checkhealth",
    "startuptime",
    "spectre_panel",
    "tsplayground",
    "PlenaryTestPopup",
    "oil",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_augroup('SearchHighlights', { clear = true })
vim.api.nvim_create_autocmd('CursorMoved', {
  group = 'SearchHighlights',
  callback = function()
    if vim.v.hlsearch == 1 and vim.fn.mode() ~= 'n' then
      vim.cmd('nohlsearch')
    end
  end,
})


-- Any directory entered with neovim is registered manually as a project
vim.api.nvim_create_autocmd("VimEnter", {
  desc = "Register cwd in project history",
  group = vim.api.nvim_create_augroup("register-project", { clear = true }),
  callback = function()
    local cwd = vim.uv.cwd()
    if not cwd then return end
    local data_dir = vim.fn.stdpath("data") .. "/project_nvim"
    local history_file = data_dir .. "/project_history"
    vim.fn.mkdir(data_dir, "p")
    local lines = {}
    local f = io.open(history_file, "r")
    if f then
      for line in f:lines() do
        if line ~= "" then
          table.insert(lines, line)
        end
      end
      f:close()
    end
    for _, l in ipairs(lines) do
      if l == cwd then return end
    end
    table.insert(lines, 1, cwd)
    f = io.open(history_file, "w")
    if f then
      for _, l in ipairs(lines) do
        f:write(l .. "\n")
      end
      f:close()
    end
  end,
})

-- Force statusline redraw when Grapple tags change (tag/untag/reorder)
vim.api.nvim_create_autocmd("User", {
  desc = "Redraw statusline on Grapple update",
  group = vim.api.nvim_create_augroup("grapple-statusline", { clear = true }),
  pattern = "GrappleUpdate",
  callback = function()
    vim.cmd.redrawstatus()
  end,
})

-- Restore cursor to the last edit position when reopening a file
-- (uses the '"' mark; skips commit messages and unknown/invalid positions)
-- vim.api.nvim_create_autocmd("BufReadPost", {
--   desc = "Restore last cursor position",
--   group = vim.api.nvim_create_augroup("restore-cursor", { clear = true }),
--   callback = function(event)
--     local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
--     local line_count = vim.api.nvim_buf_line_count(event.buf)
--     if mark[1] > 0 and mark[1] <= line_count and vim.bo[event.buf].filetype ~= "gitcommit" then
--       vim.api.nvim_win_set_cursor(0, mark)
--     end
--   end,
-- })
