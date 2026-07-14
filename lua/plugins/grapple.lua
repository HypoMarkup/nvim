return {
    "cbochs/grapple.nvim",
    dependencies = {
        { "nvim-tree/nvim-web-devicons", lazy = true },
    },
    opts = {
        scope = "cwd",
    },
    event = { "BufReadPost", "BufNewFile" },
    cmd = "Grapple",
    keys = {
        { "<leader>a", "<cmd>Grapple toggle<cr>", desc = "Grapple toggle tag" },
        { "<leader>A", "<cmd>Grapple toggle_tags<cr>", desc = "Grapple open tags menu" },
        { "<leader>j", "<cmd>Grapple select index=1<cr>", desc = "Grapple select 1" },
        { "<leader>k", "<cmd>Grapple select index=2<cr>", desc = "Grapple select 2" },
        { "<leader>l", "<cmd>Grapple select index=3<cr>", desc = "Grapple select 3" },
        { "<leader>;", "<cmd>Grapple select index=4<cr>", desc = "Grapple select 4" },
    },
}