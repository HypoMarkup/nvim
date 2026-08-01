return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  event = "VeryLazy",
  config = function()
    require("nvim-treesitter-textobjects").setup({
      select = {
        lookahead = true,
        selection_modes = {
          ["@parameter.outer"] = "v",
          ["@function.outer"] = "V",
          ["@class.outer"] = "V",
        },
      },
      move = {
        set_jumps = true,
      },
    })

    local select = require("nvim-treesitter-textobjects.select")
    local move = require("nvim-treesitter-textobjects.move")

    local function map_select(key, capture, desc)
      vim.keymap.set({ "x", "o" }, key, function()
        select.select_textobject(capture, "textobjects")
      end, { desc = desc })
    end

    -- Select: function / class / parameter
    map_select("af", "@function.outer", "Around function")
    map_select("if", "@function.inner", "Inner function")
    map_select("ac", "@class.outer", "Around class")
    map_select("ic", "@class.inner", "Inner class")
    map_select("aa", "@parameter.outer", "Around parameter")
    map_select("ia", "@parameter.inner", "Inner parameter")

    -- Move: jump to next/previous function or class start/end
    vim.keymap.set({ "n", "x", "o" }, "]m", function()
      move.goto_next_start("@function.outer", "textobjects")
    end, { desc = "Next function start" })
    vim.keymap.set({ "n", "x", "o" }, "]]", function()
      move.goto_next_start("@class.outer", "textobjects")
    end, { desc = "Next class start" })
    vim.keymap.set({ "n", "x", "o" }, "]M", function()
      move.goto_next_end("@function.outer", "textobjects")
    end, { desc = "Next function end" })
    vim.keymap.set({ "n", "x", "o" }, "][", function()
      move.goto_next_end("@class.outer", "textobjects")
    end, { desc = "Next class end" })
    vim.keymap.set({ "n", "x", "o" }, "[m", function()
      move.goto_previous_start("@function.outer", "textobjects")
    end, { desc = "Previous function start" })
    vim.keymap.set({ "n", "x", "o" }, "[[", function()
      move.goto_previous_start("@class.outer", "textobjects")
    end, { desc = "Previous class start" })
    vim.keymap.set({ "n", "x", "o" }, "[M", function()
      move.goto_previous_end("@function.outer", "textobjects")
    end, { desc = "Previous function end" })
    vim.keymap.set({ "n", "x", "o" }, "[]", function()
      move.goto_previous_end("@class.outer", "textobjects")
    end, { desc = "Previous class end" })

    -- Repeat textobject moves with ; and , (also keeps f/t/F/T repeatable)
    local ts_repeat = require("nvim-treesitter-textobjects.repeatable_move")
    vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat.repeat_last_move)
    vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat.repeat_last_move_opposite)
    vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat.builtin_f_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat.builtin_F_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat.builtin_t_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat.builtin_T_expr, { expr = true })

    -- Repeat } / { with ; and ,
    local para_move = ts_repeat.make_repeatable_move(function(opts)
      if opts.forward then
        vim.cmd.normal({ vim.v.count1 .. "}", bang = true })
      else
        vim.cmd.normal({ vim.v.count1 .. "{", bang = true })
      end
    end)
    vim.keymap.set({ "n", "x", "o" }, "}", function() para_move({ forward = true }) end, { desc = "Next paragraph" })
    vim.keymap.set({ "n", "x", "o" }, "{", function() para_move({ forward = false }) end, { desc = "Previous paragraph" })
  end,
}
