vim.keymap.set('n', '<leader>ls', function()
  vim.lsp.buf_request(0, 'clangd/switchSourceHeader', { uri = vim.uri_from_bufnr(0) }, function(err, result)
    if err or not result then return end
    vim.cmd('edit ' .. vim.uri_to_fname(result))
  end)
end, { buffer = true, desc = 'Switch header/source' })

vim.keymap.set('n', '<leader>lt', function()
  vim.lsp.inlay_hint.enable(
    not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }),
    { bufnr = 0 }
  )
end, { buffer = true, desc = 'Toggle inlay hints' })
