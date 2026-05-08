local dap = require("dap")

dap.adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
}

dap.adapters.lldb = {
  type = 'executable',
  command = '/opt/homebrew/opt/llvm/bin/lldb-dap',
  name = 'lldb'
}

dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
    runInTerminal = false,
  },
  {
    name = 'Launch with arguments',
    type = 'lldb',
    request = 'launch',
    program = function()
      local program = vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      if program == '' then return nil end

      local args_string = vim.fn.input('Arguments: ')
      if args_string ~= '' then
        -- Store args in a global variable to be used by the args function
        _G.dap_temp_args = vim.split(args_string, " +")
      else
        _G.dap_temp_args = {}
      end

      return program
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = function()
      return _G.dap_temp_args or {}
    end,
    runInTerminal = false,
  },
}

dap.configurations.c = dap.configurations.cpp
