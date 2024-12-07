local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

toggleterm.setup({
	size = 50,
	open_mapping = [[<c-\>]],
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "float",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "curved",
		winblend = 0,
    width = function()
      return math.ceil(vim.o.columns * 0.95)
    end,
    height = function()
      return math.ceil(vim.o.lines * 0.9)
    end,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})

local Terminal = require('toggleterm.terminal').Terminal

-- Create three fixed terminals
local term1 = Terminal:new({
  count = 1,
  direction = 'float',
  float_opts = {
    border = 'curved'
  }
})

local term2 = Terminal:new({
  count = 2,
  direction = 'float',
  float_opts = {
    border = 'curved'
  }
})

local term3 = Terminal:new({
  count = 3,
  direction = 'float',
  float_opts = {
    border = 'curved'
  }
})

-- Function to cycle right (next terminal)
function _G.cycle_terminal_right()
  local current_term = vim.b.toggle_number
  local next_term = current_term + 1
  if next_term > 3 then
    next_term = 1
  end
  vim.cmd('close')
  vim.cmd(next_term .. 'ToggleTerm')
end

-- Function to cycle left (previous terminal)
function _G.cycle_terminal_left()
  local current_term = vim.b.toggle_number
  local prev_term = current_term - 1
  if prev_term < 1 then
    prev_term = 3
  end
  vim.cmd('close')
  vim.cmd(prev_term .. 'ToggleTerm')
end

-- Set up terminal keymaps
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  -- vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-`>', [[<C-\><C-n>]], opts)
  -- Navigate between terminals
  vim.keymap.set('t', '<C-l>', '<cmd>lua cycle_terminal_right()<CR>', opts)
  vim.keymap.set('t', '<C-h>', '<cmd>lua cycle_terminal_left()<CR>', opts)
end

-- Auto-set keymaps when terminal opens
vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')

