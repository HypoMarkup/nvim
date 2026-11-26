-- We don't use project.nvim's auto-detection; instead the VimEnter autocmd
-- below registers the cwd every time Neovim starts.
-- The Snacks projects picker reads/writes the same history file directly.
-- This plugin is kept only as a dependency placeholder (the history file
-- format is compatible if you ever want to enable detection later).
return {
  "ahmedkhalf/project.nvim",
  lazy = false,
  init = function()
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
  end,
  config = function()
    require("project_nvim").setup({
      manual_mode = true,
      silent_chdir = true,
    })
  end,
}
