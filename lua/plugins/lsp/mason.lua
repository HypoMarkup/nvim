return {
    "mason-org/mason.nvim",
    cond = not vim.g.vscode,
    opts = {
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
            }
        }
    }
}  
