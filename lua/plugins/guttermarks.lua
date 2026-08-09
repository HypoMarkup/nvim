return {
  {
    "dimtion/guttermarks.nvim",
    event = { "BufReadPost", "BufNewFile"},
    opts = {
      local_mark = {priority = 1},
      global_mark = {priority = 1},
      local_mark = {priority = 1},
    },
  },
}
