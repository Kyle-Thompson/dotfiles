return {
  filetypes = { 'rust' },
  root_markers = { 'Cargo.toml', '.git' },
  settings = {
    ['rust-analyzer'] = {
      cargo = {
        autoreload = true,
        loadOutDirsFromCheck = true,
        features = "all",
      },
      checkOnSave = {
        enable = true,
        overrideCommand = {
          'cargo',
          'clippy',
          '--message-format=json',
          '--all-targets',
          '--all-features',
          '--',
          '-Dclippy::all',
          '-Dclippy::pedantic',
          '-Aclippy::module_name_repetitions'
        },
      },
      completion = {
        addCallParanthesis = false,
        privateEditable = { enable = true },
        postfix = { enable = false },
      },
      diagnostics = { disabled = { 'inactive-code' } },
      imports = { merge = { glob = false } },
      notifications = { cargoTomlNotFound = false },
      procMacro = { enable = true },
      typing = { autoClosingAngleBrackets = { enable = true } },
    },
  },
}

