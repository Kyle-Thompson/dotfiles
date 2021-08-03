local dap = require('dap')
dap.adapters.cpp = {
  type = 'executable';
  command = '/usr/bin/lldb-vscode';
  name = 'lldb';
}

dap.configurations.cpp = {
  {
    -- needed for nvim-dap
    name = 'Launch';
    type = 'lldb';
    request = 'launch';
    args = function()
      return { unpack(vim.split(vim.fn.input('args: '), " ", true)) }
    end;
    program = function()  -- is there a more intelligent way to do this?
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    runInTerminal = false;
  },
}
