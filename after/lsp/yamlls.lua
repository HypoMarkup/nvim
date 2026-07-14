-- Override/extend nvim-lspconfig's default yamlls config: use
-- b0o/schemastore.nvim's schema catalog instead of yamlls' built-in
-- (slower, network-fetched) schema store.
return {
  settings = {
    yaml = {
      schemaStore = {
        enable = false,
        url = "",
      },
      schemas = require("schemastore").yaml.schemas(),
    },
  },
}
