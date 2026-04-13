-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- すべてのファイル形式に対してスペルチェックを無効化したい場合
vim.api.nvim_create_autocmd("FileType",{
    pattern = "*",
    command = "setlocal nospell",
})

-- ↑ or ↓

-- 特定のファイル形式に対してスペルチェックを無効化したい場合
vim.api.nvim_create_autocmd("FileType",{
    pattern = "<無効化したいファイルタイプ> ex:markdown",
    command = "setlocal nospell",
})