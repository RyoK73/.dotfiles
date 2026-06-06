return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      -- prettierの対応ファイルフォーマット
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      less = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      jsonc = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      graphql = { "prettier" },
      vue = { "prettier" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    formatters = {
      prettier = {
        prepend_args = {
          "--config",
          os.getenv("HOME") .. "/.config/prettier/.prettierrc",
        },
      },
    },
  },
}
