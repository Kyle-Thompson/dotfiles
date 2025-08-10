local comment_string_group = vim
  .api
  .nvim_create_augroup("comment_string", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = "c,cpp",
    command = [[setlocal commentstring=//\ %s]],
    group = comment_string_group,
})
