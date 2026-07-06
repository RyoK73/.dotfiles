-- すべてのファイル形式に対してスペルチェックを無効化したい場合
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  command = "setlocal nospell",
})
