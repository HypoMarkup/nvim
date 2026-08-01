-- We don't use project.nvim's auto-detection; instead a VimEnter autocmd
-- in config/autocmds.lua registers the cwd every time Neovim starts.
-- The Snacks projects picker reads/writes the same history file directly.
-- This plugin is kept only as a dependency placeholder (the history file
-- format is compatible if you ever want to enable detection later).
return {
  "ahmedkhalf/project.nvim",
  cond = not vim.g.vscode,
  lazy = false,
  config = function()
    require("project_nvim").setup({
      manual_mode = true,
      silent_chdir = true,
    })
  end,
}
