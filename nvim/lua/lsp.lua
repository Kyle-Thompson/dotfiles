vim.cmd('packadd nvim-lsp')  -- can this be removed?

local nvim_lsp = require('nvim_lsp')
local ncm2 = require('ncm2')

nvim_lsp.clangd.setup{
  cmd = {'clangd', '--background-index', '--clang-tidy', '--log=error',
         '--pretty'};
  on_init = ncm2.register_lsp_source;
}

-- disable signs
do
  local util = require 'vim.lsp.util'
  vim.lsp.callbacks['textDocument/publishDiagnostics'] = function(_, _, result)
    if not result then return end
    local uri = result.uri
    local bufnr = vim.uri_to_bufnr(uri)
    if not bufnr then
      err_message("LSP.publishDiagnostics: Couldn't find buffer for ", uri)
      return
    end
    util.buf_clear_diagnostics(bufnr)
    util.buf_diagnostics_save_positions(bufnr, result.diagnostics)
    util.buf_diagnostics_underline(bufnr, result.diagnostics)
    util.buf_diagnostics_virtual_text(bufnr, result.diagnostics)
    vim.api.nvim_command("doautocmd User LspDiagnosticsChanged")
  end
end
