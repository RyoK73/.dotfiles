return {
  "okuuva/auto-save.nvim",
  event = { "InsertLeave", "FocusLost" },
  opts = {
    debounce_delay = 3000,
  },
}
