return {
  cmd = {
    'clangd',
    '--background-index=false',
    '--pch-storage=disk',
    '--malloc-trim',
    '--clang-tidy=false',
    '-j=4'
  };
  capabilities = require('cmp_nvim_lsp').default_capabilities();
}

