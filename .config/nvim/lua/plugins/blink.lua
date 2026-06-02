return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    },
  },
  -- opts = function(_, opts)
  --   opts.keymap = opts.keymap or {}
  --   opts.keymap["<Tab>"] = {
  --     function(cmp)
  --       if cmp.is_visible() then
  --         return cmp.select_next()
  --       end
  --     end,
  --     function()
  --       vim.api.nvim_feedkeys(
  --         vim.api.nvim_replace_termcodes("<C-t>", true, true, true),
  --         "n",
  --         false
  --       )
  --       return true
  --     end,
  --   }
  --   opts.keymap["<S-Tab>"] = {
  --     function(cmp)
  --       if cmp.is_visible() then
  --         return cmp.select_prev()
  --       end
  --     end,
  --     function()
  --       vim.api.nvim_feedkeys(
  --         vim.api.nvim_replace_termcodes("<C-d>", true, true, true),
  --         "n",
  --         false
  --       )
  --       return true
  --     end,
  --   }
  -- end,
}
