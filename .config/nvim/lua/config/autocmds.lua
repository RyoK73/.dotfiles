-- すべてのファイル形式に対してスペルチェックを無効化したい場合
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  command = "setlocal nospell",
})
-- smear-cursor insertモードではparticlesをオフに、ノーマルモードではオンに
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    require("smear_cursor.config").particles_enabled = false
  end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    require("smear_cursor.config").particles_enabled = true
  end,
})
