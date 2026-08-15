return {
  "windwp/nvim-ts-autotag",
  enable = false,
  opts = {
    per_filetype = {
      ["markdown"] = {
        enable_close = false,
        enable_rename = false,
        enable_close_on_slash = false,
      },
    },
  },
}
