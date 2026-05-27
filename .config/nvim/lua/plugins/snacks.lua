return {
  "folke/snacks.nvim",
  opts = {
    explorer = {
      enabled = true,
      win = {
        keys = {
          ["<Tab>"] = "down",
          ["<S-Tab>"] = "up",
        },
      },
    },
    picker = {
      actions = {
        tab_next = { action = "list_down" },
        tab_prev = { action = "list_up" },
      },
      win = {
        input = {
          keys = {
            ["<Tab>"] = { "tab_next", mode = { "i", "n" } },
            ["<S-Tab>"] = { "tab_prev", mode = { "i", "n" } },
          },
        },
      },
    },
  },
}
