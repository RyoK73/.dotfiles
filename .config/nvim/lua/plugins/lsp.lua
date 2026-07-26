return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      bashls = {
        filetypes = { "sh", "bash", "zsh" },
      },
      vtsls = {
        settings = {
          typescript = {
            preferences = {
              includeCompletionsForModuleExports = true,
              includeCompletionsForImportStatements = true,
            },
          },
        },
      },
    },
    vim.lsp.enable("postgres_lsp"),
  },
}
