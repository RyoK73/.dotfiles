return {
  "okuuva/auto-save.nvim",
  event = { "InsertLeave", "FocusLost" },
  opts = {
    enabled = true,
    debounce_delay = 3000,
  },
}
