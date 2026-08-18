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
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
-- vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
-- vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
-- vim.cmd([[ highlight Normal guibg=none
--   highlight NonText guibg=none
--   highlight Normal ctermbg=none
--   highlight NonText ctermbg=none
--   highlight NormalNC guibg=none
--   highlight NormalSB guibg=none
-- ]])
local groups = {
  "Normal",
  "NormalNC",
  "NormalFloat",
  "LineNr",
  "CursorLineNr",
  "SignColumn",
  "EndOfBuffer",
  "FoldColumn",
  "Folded",
  -- カーソル行・カラム
  "CursorLine",
  "CursorColumn",
  -- "ColorColumn",
  -- ウィンバー / タブライン(bufferline.nvim使用中とのことなので特に重要)
  "WinBar",
  "WinBarNC",
  "TabLine",
  "TabLineFill",
  "TabLineSel",
  -- markdown系(見出しの背景バーやコードブロック背景)
  "@markup.heading.1.markdown",
  "@markup.heading.2.markdown",
  "@markup.heading.3.markdown",
  "@markup.heading.4.markdown",
  "@markup.heading.5.markdown",
  "@markup.heading.6.markdown",
  -- "@markup.raw.block.markdown", -- コードブロック背景
  "RenderMarkdownH1Bg", -- render-markdown.nvim を使っている場合
  "RenderMarkdownH2Bg",
  "RenderMarkdownH3Bg",
  "RenderMarkdownCode",
  "RenderMarkdownCodeInline",
}

for _, group in ipairs(groups) do
  vim.api.nvim_set_hl(0, group, { bg = "none" })
end
