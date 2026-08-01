return {
  "nvim-treesitter/nvim-treesitter-context",
  cond = not vim.g.vscode,
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  event = "BufReadPost",
  opts = {
    max_lines = 3,           -- max number of context lines to show
    min_window_height = 20,  -- disable in small windows
    mode = "cursor",         -- "cursor" or "topline"
    separator = nil,         -- set to "─" for a separator line
    multiline_threshold = 1, -- prevents { under the func using a line
  },
  keys = {
    { "[c", function() require("treesitter-context").go_to_context() end, desc = "Jump to context" },
  },
}
