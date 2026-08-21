return {
  "okuuva/auto-save.nvim",
  event = { "InsertLeave", "FocusLost" },
  opts = {
    enabled = false,
    debounce_delay = 3000,
  },
}
