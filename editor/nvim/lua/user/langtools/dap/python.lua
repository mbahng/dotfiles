local dap = require("dap")

dap.adapters.python = {
  type = "executable",
  command = "python",
  args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
  {
    justMyCode = false,
    type = 'python',
    request = 'launch',
    name = 'Launch',
    program = '${file}',
    args = {},
    console = "integratedTerminal",
  },
  {
    type = 'python',
    request = 'launch',
    name = 'Launch custom file with arguments',
    program = function()
      local command = vim.fn.input('Command: ', '')
      if command == '' or command == 'python ' then return nil end

      -- Parse the command to extract file and arguments
      local parts = vim.split(command, " +")
      local program = nil
      local args = {}

      -- Skip 'python' if present
      local start_idx = 1
      if parts[1] == 'python' then
        start_idx = 2
      end

      if parts[start_idx] then
        program = parts[start_idx]
        -- Collect remaining parts as arguments
        for i = start_idx + 1, #parts do
          table.insert(args, parts[i])
        end
      end

      return program
    end,
    console = "integratedTerminal",
  },
}
