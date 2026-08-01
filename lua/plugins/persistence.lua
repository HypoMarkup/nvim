return {
  {
    "folke/persistence.nvim",
    cond = not vim.g.vscode,
    event = "BufReadPre",
    opts = {},
  },
}
