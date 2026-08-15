return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      bashls = {
        filetypes = { "sh", "bash", "zsh" },
      },
      ts_ls = {
        init_options = {
          preferences = {
            importModuleSpecifierPreference = "non-relative", -- "non-relative" や "project-relative" も可
          },
        },
      },
    },
  },
}
