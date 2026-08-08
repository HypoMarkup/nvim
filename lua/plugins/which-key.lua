return {
  "folke/which-key.nvim",
  cond = not vim.g.vscode,
  event = "VeryLazy",
opts = {
    spec = {
      { "<leader>g",  group = "Git" },
      { "<leader>gh", group = "Hunk" },
      { "<leader>gt", group = "Git Toggle" },
      { "<leader>r",  group = "Refactor/Restart LSP" },
    },
  },  
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
