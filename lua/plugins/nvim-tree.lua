-- snacks file tree doesnt support flattening dirs
return {
  "nvim-tree/nvim-tree.lua",
  cond = not vim.g.vscode,
  -- closes tree on any buffer quit, pcall makes silent error
  init = function()
    vim.api.nvim_create_autocmd("QuitPre", {
      callback = function() pcall(vim.cmd, "NvimTreeClose") end,
    })
  end,
  keys = {
    { "<leader>e", "<Cmd>NvimTreeToggle<CR>", desc = "Toggle Explorer" },
  },
  opts = {
    sync_root_with_cwd = true,
    -- Single click to toggle/open folders
    on_attach = function(bufnr)
      local api = require("nvim-tree.api")
      api.map.on_attach.default(bufnr)
      vim.keymap.set("n", "<LeftRelease>", api.node.open.edit, {
        buffer = bufnr, noremap = true, silent = true, nowait = true,
        desc = "nvim-tree: Open (single click)",
      })
    end,
    view = {
      width = 40, -- default = 30
    },
    renderer = {
      group_empty = true,
    },
    update_focused_file = {
      enable = true,
    },
    actions = {
      open_file = {
        quit_on_open = true,
        resize_window = false,
      },
    },
  },
}
