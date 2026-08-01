local banner = require("config.art").turtle2

return {
  {
    "folke/snacks.nvim",
    cond = not vim.g.vscode,
    lazy = false,
    priority = 1000,
    opts = {
      explorer = { enabled = false },
      dashboard = {
        -- width = banner.width,
        preset = {
          -- header = banner.art,

          -- Find File / Find Text / Recent Files / Config use fzf-lua (our chosen picker,
          -- see plugins/fzf.lua). Projects still uses Snacks' own picker (`picker = {}`
          -- below) since fzf-lua has no built-in "projects" source. Each entry below
          -- has a "swap:" comment showing its Snacks.dashboard.pick(...) equivalent.
          keys = {
            -- swap: require("fzf-lua").files() -> ":lua Snacks.dashboard.pick('files')"
            { icon = vim.fn.nr2char(0xf502, 1) .. " ", key = "p", desc = "Projects", action = ":lua Snacks.dashboard.pick('projects')" },
            {
              icon = vim.fn.nr2char(0xeede, 1) .. "",
              key = "f",
              desc = "Find File",
              action = function()
                require("fzf-lua").files()
              end,
            },
            { icon = vim.fn.nr2char(0xf15b, 1) .. " ", key = "n", desc = "New File", action = ":ene | startinsert" }, 
            { icon = vim.fn.nr2char(0xe348, 1) .. " ", key = "s", desc = "Restore Session", action = ":lua require('persistence').load({ last = true })" },
            -- swap: require("fzf-lua").live_grep() -> ":lua Snacks.dashboard.pick('live_grep')"
            {
              icon = vim.fn.nr2char(0xf022, 1) .. " ",
              key = "g",
              desc = "Find Text",
              action = function()
                require("fzf-lua").live_grep()
              end,
            },
            -- swap: require("fzf-lua").oldfiles() -> ":lua Snacks.dashboard.pick('oldfiles')"
            {
              icon = vim.fn.nr2char(0xf0c5, 1) .. " ",
              key = "r",
              desc = "Recent Files",
              action = function()
                require("fzf-lua").oldfiles()
              end,
            },
            -- swap: require("fzf-lua").files({ cwd = ... }) -> ":lua Snacks.dashboard.pick('files', { cwd = vim.fn.stdpath('config') })"
            {
              icon = vim.fn.nr2char(0xf423, 1) .. " ",
              key = "c",
              desc = "Config",
              action = function()
                require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
              end,
            },
            { icon = vim.fn.nr2char(0xf04b2, 1) .. " ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = vim.fn.nr2char(0xf426, 1) .. " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
        sections = {
          { section = "header"},
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
      },
      picker = {
        sources = {
          projects = {
            -- Read project list from the history file managed by our
            -- VimEnter autocmd (every dir you open nvim from is a project)
            finder = function(_, _)
              local history_file = vim.fn.stdpath("data") .. "/project_nvim/project_history"
              return function(cb)
                local f = io.open(history_file, "r")
                if not f then return end
                for line in f:lines() do
                  if line ~= "" then
                    cb({ file = line, text = line, dir = true })
                  end
                end
                f:close()
              end
            end,
            confirm = "load_session",
            actions = {
              delete_project = function(picker, item)
                if not item then return end
                local history_file = vim.fn.stdpath("data") .. "/project_nvim/project_history"
                local lines = {}
                local f = io.open(history_file, "r")
                if f then
                  for line in f:lines() do
                    if line ~= "" and line ~= item.file then
                      table.insert(lines, line)
                    end
                  end
                  f:close()
                end
                f = io.open(history_file, "w")
                if f then
                  for _, l in ipairs(lines) do
                    f:write(l .. "\n")
                  end
                  f:close()
                end
                Snacks.notify("Removed: " .. item.file)
                picker:find()
              end,
            },
            win = {
              input = {
                keys = {
                  ["<c-x>"] = { "delete_project", mode = { "n", "i" }, desc = "Remove project" },
                },
              },
            },
          },
        },
      },
    },
    keys = {
      {
        "<leader>t",
        function()
          Snacks.terminal.toggle(nil, {
            win = {
              position = "bottom",
              height = 0.3,
            },
          })
        end,
        desc = "Toggle Terminal",
        mode = { "n", "t" },
      },
    },
  },
}
