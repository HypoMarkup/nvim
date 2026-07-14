-- Override/extend nvim-lspconfig's default jsonls config: wire up
-- b0o/schemastore.nvim's schema catalog (package.json, tsconfig.json, etc.)
return {
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
}
