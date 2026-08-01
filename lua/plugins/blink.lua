return
{
  'saghen/blink.cmp',
  -- blink.cmp v2 requires blink.lib as an explicit dependency
  -- optional: provides snippets for the snippet source
  dependencies = { 'saghen/blink.lib', 'rafamadriz/friendly-snippets' },
  cond = not vim.g.vscode,

  -- use a release tag to download pre-built binaries
  -- version = '2.*',
  -- v2's new build/download system for the native library (:h blink-cmp-installation)
  build = function() require("blink.cmp").build():pwait() end,
  -- AND/OR build from source
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = {
      preset = 'default',
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },
      ["<C-d>"] = { "show_documentation", "hide_documentation", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono'
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = {
      menu = { auto_show = true },
      list = {
        selection = { preselect = true, auto_insert = true },
      },
      accept = {
        auto_brackets = { enabled = true },
      },
      documentation = { auto_show = false },
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 
          'lsp', 
          'path', 
          'snippets', 
          'buffer' 
        },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" },

    -- Enable blink.cmp autocompletion in the : command line
    cmdline = {
      keymap = {
        preset = 'cmdline',
        ['<CR>']    = { 'accept', 'fallback' },
        -- ['<CR>'] = { 'select_accept_and_enter', 'fallback' },

        ['<Tab>']   = { 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
      },
      completion = {
        menu = { auto_show = true },
        -- cmdline needs its OWN preselect
        list = {
          selection = { preselect = false, auto_insert = false },
        },
      },
    },
  },
  opts_extend = { "sources.default" }
}
