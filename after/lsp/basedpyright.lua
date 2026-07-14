-- Override/extend nvim-lspconfig's default basedpyright config.
return {
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "standard",
        autoImportCompletions = true,
      },
    },
  },
}
