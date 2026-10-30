local dap = require("dap")

-- Resolved when a session starts, not when this file loads: getcwd() at load time
-- pins the adapter to whatever directory nvim happened to open in, so launching
-- from another project would reach for a .venv that isn't there.
dap.adapters.python = function(callback)
	callback({
		type = "executable",
		command = vim.fn.getcwd() .. "/.venv/bin/python",
		args = { "-m", "debugpy.adapter" },
	})
end

local _dap_py_program = nil
local _dap_py_args = {}

dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = 'Launch',
    program = '${file}',
    args = {},
    -- debugpy defaults subProcess to true, which gives every forked child its own
    -- debug session. A DataLoader with num_workers > 0 then hands the adapter one
    -- debuggee per worker and the session dies; see pydev_monkey.create_fork.
    subProcess = false,
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
    subProcess = false,
    console = "integratedTerminal",
    cwd = vim.fn.getcwd(),
  },
}
