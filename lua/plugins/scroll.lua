return {
  "karb94/neoscroll.nvim",
  cond = not vim.g.vscode,
  event = "VeryLazy", 
  opts = {
    mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>"},

    hide_cursor = true,          
    stop_eof = true,            
    respect_scrolloff = true, 
    cursor_scrolls_alone = true,

    -- duration_multiplier scales every animation's length. Lower = snappier.
    duration_multiplier = 0.7,

    -- linear, quadratic, cubic, quartic, quintic, circular, sine
    -- 'sine' or 'quadratic' feel more natural 
    easing = "sine",

    performance_mode = false,    -- true disables syntax highlight mid-scroll on huge/slow files

    pre_hook = nil,              -- function() end to run before an animation
    post_hook = nil,             -- function() end to run after an animation
  },
}
