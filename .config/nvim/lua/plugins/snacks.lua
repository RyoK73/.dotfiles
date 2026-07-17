return {
  "folke/snacks.nvim",
  opts = {
    explorer = { enabled = true },
    notifier = { enabled = true },
    picker = {
      win = {
        input = {
          keys = {
            ["<Tab>"] = { "list_down", mode = { "i", "n" } },
            ["<S-Tab>"] = { "list_up", mode = { "i", "n" } },
          },
        },
        list = {
          keys = {
            ["<Tab>"] = { "list_down", mode = { "n", "x" } },
            ["<S-Tab>"] = { "list_up", mode = { "n", "x" } },
          },
        },
      },
    },
  },
}
