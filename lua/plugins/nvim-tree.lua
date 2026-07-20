-- snacks file tree doesnt support flattening dirs
return {
  "nvim-tree/nvim-tree.lua",
  cond = not vim.g.vscode,
  keys = {
    { "<leader>e", "<Cmd>NvimTreeToggle<CR>", desc = "Toggle Explorer" },
  },
  opts = {
    renderer = {
      group_empty = true,
    },
    update_focused_file = {
      enable = true,
    },
  },
}
