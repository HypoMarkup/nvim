-- Inside VSCode (vscode-neovim) use the trimmed-down entry point instead
if vim.g.vscode then
  require("config.vscode")
  return
end

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")
require("config.lsp")
