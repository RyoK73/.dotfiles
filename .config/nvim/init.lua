-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- 全体のデフォルト
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- シェル系だけタブに
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sh", "zsh" },
  callback = function()
    vim.opt_local.expandtab = false
  end,
})
