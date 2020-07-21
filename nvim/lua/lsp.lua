local lsp = require('nvim_lsp')
local completion = require('completion')
local diagnostic = require('diagnostic')

lsp.clangd.setup{
  cmd = {'clangd', '--background-index', '--clang-tidy', '--log=error',
         '--pretty'};
  on_attach = function()
    completion.on_attach()
    diagnostic.on_attach()
  end
}

-- language server keymaps
vim.api.nvim_set_keymap('n', '<leader>ld',
                        '<cmd>lua vim.lsp.buf.declaration()<CR>',
                        { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>lwd',
                        '<cmd>sp<CR>:lua vim.lsp.buf.declaration()<CR>',
                        { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>li',
                        '<cmd>lua vim.lsp.buf.definition()<CR>',
                        { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>lwi',
                        '<cmd>sp<CR>:lua vim.lsp.buf.definition()<CR>',
                        { noremap = true, silent = true })

-- diagnostic settings
vim.g.diagnostic_show_sign = 0
vim.g.diagnostic_enable_virtual_text = 1
vim.g.diagnostic_virtual_text_prefix = ''
