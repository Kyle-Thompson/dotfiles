require('blink.cmp').setup {
  sources = {
    default = { 'lsp', 'path', 'buffer', 'snippets' },
  },
  snippets = { preset = 'luasnip' },
  keymap = {
    preset = 'default',
  },
  signature = { enabled = true },
}

-- TODO: this doesn't work right now
-- vim.keymap.set("i", "<CR>", function()
--   if vim.fn.pumvisible() == 1 then
--     return "<C-y>" -- Accept the current completion item
--   else
--     return "<CR>"  -- Normal enter key behavior
--   end
-- end, { expr = true, noremap = true })
