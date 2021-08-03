local dap = require('dap')
dap.adapters.python = {
  type = 'executable';
  command = '/usr/bin/python';
  args = { '-m', 'debugpy.adapter' };
}

dap.configurations.python = {
  {
    -- needed for nvim-dap
    name = "Launch file";
    type = 'python';
    request = 'launch';
    args = function()
      return { unpack(vim.split(vim.fn.input('args: '), " ", true)) }
    end;

    -- debugpy options
    program = "${file}";
    pythonPath = function()
      local root_dir = vim.lsp.buf.list_workspace_folders()[1]
      if vim.fn.executable(root_dir .. '/venv/bin/python') == 1 then
        return root_dir .. '/venv/bin/python'
      elseif vim.fn.executable(root_dir .. '/.venv/bin/python') == 1 then
        return root_dir .. '/.venv/bin/python'
      else
        return '/usr/bin/python'
      end
    end;
  },
}
