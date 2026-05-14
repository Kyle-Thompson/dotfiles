-- nvim-treesitter `main` branch: parsers + queries are installed to
-- `install_dir`, which is prepended to the runtimepath. Requires
-- `tree-sitter-cli` (>= 0.26.1) and a C compiler on PATH for install.
require('nvim-treesitter').setup({
  install_dir = vim.fn.stdpath('data') .. '/site',
})

require('nvim-treesitter').install({
  'bash', 'c', 'cmake', 'cpp', 'dockerfile',
  'lua', 'markdown', 'markdown_inline', 'python', 'toml',
})

vim.api.nvim_create_autocmd('FileType', {
  callback = function(ev) pcall(vim.treesitter.start, ev.buf) end,
})
