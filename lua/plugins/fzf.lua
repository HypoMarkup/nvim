return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  -- dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  dependencies = { "nvim-mini/mini.icons" },
  ---@module "fzf-lua"
  ---@type fzf-lua.Config|{}
  ---@diagnostic disable: missing-fields
  ---@diagnostic enable: missing-fields
  keys = {
    -- swap: require("fzf-lua").files()      -> Snacks.picker.files()
    { "<leader>ff", function() require("fzf-lua").files() end, desc = "Find Files" },
    -- swap: require("fzf-lua").live_grep()  -> Snacks.picker.grep()
    { "<leader>fg", function() require("fzf-lua").live_grep() end, desc = "Live Grep" },
    -- swap: require("fzf-lua").buffers()    -> Snacks.picker.buffers()
    { "<leader>fb", function() require("fzf-lua").buffers() end, desc = "Buffers" },
    -- swap: require("fzf-lua").oldfiles()   -> Snacks.picker.recent()
    { "<leader>fr", function() require("fzf-lua").oldfiles() end, desc = "Recent Files" },
    -- swap: require("fzf-lua").grep_cword() -> Snacks.picker.grep_word()
    { "<leader>fw", function() require("fzf-lua").grep_cword() end, desc = "Grep Word Under Cursor" },
    -- swap: require("fzf-lua").helptags()   -> Snacks.picker.help()
    { "<leader>fh", function() require("fzf-lua").helptags() end, desc = "Help Tags" },
    -- swap: require("fzf-lua").files({cwd=...}) -> Snacks.picker.files({cwd=...})
    {
      "<leader>fc",
      function()
        require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "Find Config File",
    },
  },
}

-- NOTE: snacks.nvim ships its own built-in fuzzy picker (Snacks.picker), enabled
-- via `picker = {}` in plugins/snacks.lua. It does everything in Lua (no external
-- binary needed) and is already wired into the dashboard (see plugins/snacks.lua).
-- Each keymap above has a "swap:" comment showing its Snacks.picker equivalent.
-- To fully revert: replace each fzf-lua call with its Snacks.picker equivalent
-- (or remove this file's `keys` table entirely and rely on the dashboard +
-- your own Snacks.picker keymaps instead).
