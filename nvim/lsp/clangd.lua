return {
  cmd = {
    'clangd',
    '--background-index=false',
    '--pch-storage=disk',
    '--malloc-trim',
    '--clang-tidy=false',
    '-j=4'
  },
  filetypes = { 'c', 'cpp' },
  root_markers = { '.clangd', '.git' },
  capabilities = require('blink.cmp').get_lsp_capabilities(),
}
