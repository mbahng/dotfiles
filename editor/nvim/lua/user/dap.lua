local dap = require("dap")
local dapui = require("dapui")
local dap_python = require("dap-python")

dap_python.setup("python")

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



-- UI and virtual text 

dapui.setup({
  expand_lines = false, 
  layouts = {
    {
      elements = {
        -- You can remove any of these you don't want
        { id = "scopes", size = 0.76 },      -- Variables in current scope
        { id = "breakpoints", size = 0.12 }, -- List of breakpoints
        { id = "stacks", size = 0.12 },      -- Call stack
      },
      size = 60,  -- Width of the sidebar
      position = "left",
    },
    {
      elements = {
        { id = "console", size = 0.5 },      -- Program output
        { id = "repl", size = 0.5 },     -- Watch expressions
      },
      size = 80,  -- Height of bottom panel
      position = "right",
    },
  },
})
require("nvim-dap-virtual-text").setup({
  commented = false,
  -- virt_text_pos = 'eol',  -- Position: 'eol' | 'overlay' | 'right_align'
  virt_lines = true,    
  display_callback = function(variable, buf, stackframe, node, options)
    if #variable.value > 50 then
      local first_part = string.sub(variable.value, 1, 30)
      local last_part = string.sub(variable.value, -20)
      return ' ' .. first_part .. '...' .. last_part
    end
    return ' ' .. variable.value
  end,
})




-- Configurations 

dap.configurations.python = {
  {
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
    name = 'Launch file with arguments',
    program = '${file}',
    args = function()
      local args_string = vim.fn.input('Arguments: ')
      return vim.split(args_string, " +")
    end,
    console = "integratedTerminal",
  },
  {
    type = 'python',
    request = 'launch',
    name = 'Debug protopnet train-prototree',
    module = 'protopnet',
    args = {
      'train-prototree',
      '--no-wandb',
      '--push',
      '--dataset=bioscan_genetic',
      '--dataset-id=smal',
      '--backbone=genconv',
      '--warm-up-phase-len=1',
      '--joint-phase-len=1',
      '--variability-coef=-1e-8',
      '--cluster-coef=-0.00',
      '--orthogonality-coef=0.0',
      '--latent-dim-multiplier-exp=2',
      '--phase-multiplier=1',
      '--phase-relative-lr-multiplier=1.72334',
      '--num-addon-layers=3',
      '--batch-size=512',
      '--depth=10',
      '--save-every-n-epochs=1',
      '--backbone-lr=0.0',
      '--add-on-lr=0.001',
      '--prototype-lr=0.002',
    },
    console = "integratedTerminal",
  },
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
  -- {
  --   name = 'Build and Launch',
  --   type = 'lldb',
  --   request = 'launch',
  --   program = function()
  --     -- Build first
  --     local build_cmd = vim.fn.input('Build command: ', 'make', 'shellcmd')
  --     vim.fn.system(build_cmd)
  --     if vim.v.shell_error ~= 0 then
  --       vim.notify('Build failed!', vim.log.levels.ERROR)
  --       return nil
  --     end
  --     return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
  --   end,
  --   cwd = '${workspaceFolder}',
  --   stopOnEntry = false,
  --   args = {},
  --   runInTerminal = false,
  -- },
}

dap.configurations.c = dap.configurations.cpp







-- Signs

vim.fn.sign_define("DapBreakpoint", {
  text = "",
  texthl = "DiagnosticSignError",
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("DapBreakpointRejected", {
  text = "", -- or "❌"
  texthl = "DiagnosticSignError",
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("DapStopped", {
  text = "", -- or "→"
  texthl = "DiagnosticSignWarn",
  linehl = "Visual",
  numhl = "DiagnosticSignWarn",
})

-- Automatically open/close DAP UI
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

local opts = { noremap = true, silent = true }

-- Toggle breakpoint
vim.keymap.set("n", "<leader>db", function()
  dap.toggle_breakpoint()
end, opts)

-- Continue / Start
vim.keymap.set("n", "<leader>dc", function()
  dap.continue()
end, opts)

-- Step Over
vim.keymap.set("n", "<leader>do", function()
  dap.step_over()
end, opts) 
vim.keymap.set("n", "<S-o>", function()
  dap.step_over()
end, opts) 

-- expand variable
vim.keymap.set("n", "<leader>dk", function()
  dapui.eval(nil, { enter = true })
end, opts)

-- Step Into
vim.keymap.set("n", "<leader>di", function()
  dap.step_into()
end, opts)

-- Step Out
vim.keymap.set("n", "<leader>dO", function()
  dap.step_out()
end, opts)

-- Keymap to terminate debugging
vim.keymap.set("n", "<leader>dq", function()
  require("dap").terminate()
end, opts)

-- Toggle DAP UI
vim.keymap.set("n", "<leader>du", function()
  dapui.toggle()
end, opts)

-- Navigate up the call stack (to caller)
vim.keymap.set("n", "<leader>dU", function()
  dap.up()
end, opts)

-- Navigate down the call stack (to callee)
vim.keymap.set("n", "<leader>dD", function()
  dap.down()
end, opts)
