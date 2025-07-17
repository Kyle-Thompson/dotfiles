return {
  cmd = {
    'clangd',
    '--background-index=false',
    '--pch-storage=disk',
    '--malloc-trim',
    '--clang-tidy=false',
    '-j=4'
  };
}

