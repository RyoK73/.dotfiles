local opt = vim.opt
opt.list = true
opt.listchars = {
  space = "·",
  tab = "→ ",
  eol = "↲",
}
opt.wrap = true
opt.linebreak = true
opt.whichwrap:append("b,s,<,>,[,],h,l")

-- タブとインデントの設定
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- 検索設定
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true

-- スワップファイルの設定
opt.swapfile = false

-- 十字線
opt.cursorline = true
opt.cursorcolumn = true
