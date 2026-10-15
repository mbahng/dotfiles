local dap = require("dap")

dap.adapters.python = {
	type = "executable",
	command = vim.fn.getcwd() .. "/.venv/bin/python",
	args = { "-m", "debugpy.adapter" },
}

local _dap_py_program = nil
local _dap_py_args = {}

dap.configurations.python = {
  {
    justMyCode = false,
    type = 'python',
    request = 'launch',
    name = 'Launch',
    program = '${file}',
    args = {},
    console = "integratedTerminal",
		cwd = vim.fn.getcwd(),
  },
  {
    type = 'python',
    request = 'launch',
    name = 'Launch custom file with arguments',
    program = function()
      _dap_py_args = {}
      local command = vim.fn.input('Command: ', '')
      if command == '' or command == 'python ' then return nil end

      local parts = vim.split(command, " +")
      local start_idx = (parts[1] == 'python') and 2 or 1

      if parts[start_idx] then
        _dap_py_program = parts[start_idx]
        for i = start_idx + 1, #parts do
          table.insert(_dap_py_args, parts[i])
        end
      end

      return _dap_py_program
    end,
    args = function()
      return _dap_py_args
    end,
    console = "integratedTerminal",
    cwd = vim.fn.getcwd(),
  },
}
