return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    },
    sources = {
      default = { "lsp", "path", "snippets" },
      providers = {
        buffer = { enabled = false },
      },
    },
  },
}
