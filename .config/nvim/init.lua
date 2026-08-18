-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- 全体のデフォルト
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- シェル系だけTabでインデントに
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sh", "zsh" },
  callback = function()
    vim.opt_local.expandtab = false
  end,
})

-- 背景を透過
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
-- vim.cmd([[ highlight Normal guibg=none
--   highlight NonText guibg=none
--   highlight Normal ctermbg=none
--   highlight NonText ctermbg=none
--   highlight NormalNC guibg=none
--   highlight NormalSB guibg=none
-- ]])
