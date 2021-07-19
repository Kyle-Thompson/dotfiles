packloadall         " load all plugins in pack/start
lua require('init')
augroup lsp
  au!
  au FileType java lua require('jdtls').start_or_attach({cmd = {'jdtls.sh'}})
augroup end
