require('nvim-treesitter.configs').setup({
  ensure_installed = { "c", "cpp", "python", "rust" },
  auto_install     = true,
  highlight        = { enable = true }
})
