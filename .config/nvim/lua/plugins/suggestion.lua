return {
  {
    "saghen/blink.cmp",
    lazy = false,
    opts = {
      keymap = {
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<C-Space>"] = { "show" },
      },
      sources = {
        default = { "lsp", "path" },
        providers = {
          buffer = { enabled = false },
        },
      },
    },
  },
  { "rafamadriz/friendly-snippets", enabled = false },
}
