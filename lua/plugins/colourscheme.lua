return {
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_background = "medium"
      vim.g.gruvbox_material_foreground = "material"
      vim.cmd.colorscheme("gruvbox-material")
    end,
  },
}

-- return {
--   {
--     "ellisonleao/gruvbox.nvim",
--     lazy = false,
--     priority = 1000,
--     opts = {
--       contrast = "medium",
--     },
--     config = function(_, opts)
--       require("gruvbox").setup(opts)
--       vim.o.background = "dark"
--       vim.cmd.colorscheme("gruvbox")
--     end,
--   },
-- }
