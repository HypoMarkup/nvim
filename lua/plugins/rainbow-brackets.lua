return {
  "HiPhish/rainbow-delimiters.nvim",
  event = "BufReadPost",
  config = function()
    local rainbow = require("rainbow-delimiters")

    ---@type rainbow_delimiters.config
    vim.g.rainbow_delimiters = {
      -- query to use for finding delimiters 
      -- "rainbow-delimiters" (default), "rainbow-parens" (parens only), "rainbow-blocks" (blocks)
      query = {
        [""] = "rainbow-delimiters", -- default for all languages
        -- lua = "rainbow-blocks",   -- use block-level delimiters for lua
      },

      --   rainbow.strategy["global"]    -- highlight entire buffer (default)
      --   rainbow.strategy["local"]     -- only highlight around cursor (better perf for large files)
      strategy = {
        [""] = rainbow.strategy["global"],
        -- in large files, switch specific languages to local:
        -- c = rainbow.strategy["local"],
        -- cpp = rainbow.strategy["local"],
      },

      -- highlights priority (higher = wins over other highlights)
      priority = {
        [""] = 110,
      },

      highlight = {
        "RainbowDelimiterRed",
        "RainbowDelimiterYellow",
        "RainbowDelimiterBlue",
        "RainbowDelimiterOrange",
        "RainbowDelimiterGreen",
        "RainbowDelimiterViolet",
        "RainbowDelimiterCyan",
      },

      -- disable for specific filetypes
      blacklist = {
        -- "html",
      },
    }
  end,
}
