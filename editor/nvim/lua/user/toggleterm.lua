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

-- Create four fixed terminals with different border colors
local term1 = Terminal:new({
  count = 1,
  direction = 'float',
  float_opts = {
    border = 'curved',
  },
  highlights = {
    FloatBorder = {
      guifg = "#ff9999"
    }
  }
})

local term2 = Terminal:new({
  count = 2,
  direction = 'float',
  float_opts = {
    border = 'curved',
  },
  highlights = {
    FloatBorder = {
      guifg = "#ffff99"
    }
  }
})

local term3 = Terminal:new({
  count = 3,
  direction = 'float',
  float_opts = {
    border = 'curved',
  },
  highlights = {
    FloatBorder = {
      guifg = "#99ff99"
    }
  }
})

local term4 = Terminal:new({
  count = 4,
  direction = 'float',
  float_opts = {
    border = 'curved',
  },
  highlights = {
    FloatBorder = {
      guifg = "#99ccff"
    }
  }
})

-- Function to cycle right (next terminal)
function _G.cycle_terminal_right()
  local current_term = vim.b.toggle_number or 1
  -- Force current_term to be between 1 and 4
  current_term = ((current_term - 1) % 4) + 1
  
  -- Calculate next terminal (will always be between 1 and 4)
  local next_term = (current_term % 4) + 1
  
  term1:close()
  term2:close()
  term3:close()
  term4:close()
  
  if next_term == 1 then term1:open() end
  if next_term == 2 then term2:open() end
  if next_term == 3 then term3:open() end
  if next_term == 4 then term4:open() end
end

-- Function to cycle left (previous terminal)
function _G.cycle_terminal_left()
  local current_term = vim.b.toggle_number or 1
  -- Force current_term to be between 1 and 4
  current_term = ((current_term - 1) % 4) + 1
  
  local prev_term = current_term - 1
  if prev_term < 1 then
    prev_term = 4
  end
  
  term1:close()
  term2:close()
  term3:close()
  term4:close()
  
  if prev_term == 1 then term1:open() end
  if prev_term == 2 then term2:open() end
  if prev_term == 3 then term3:open() end
  if prev_term == 4 then term4:open() end
end

function _G.toggle_terminal()
    if vim.b.toggle_number == nil then
        -- If no terminal is open, open terminal 1
        term1:open()
    else
        -- Otherwise use built-in toggle
        vim.cmd('ToggleTerm')
    end
end

vim.keymap.set({'n', 't'}, '<C-\\>', '<cmd>lua toggle_terminal()<CR>', { noremap = true, silent = true })

-- Set up terminal keymaps
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  -- Navigate between terminals
  vim.keymap.set('t', '<C-l>', '<cmd>lua cycle_terminal_right()<CR>', opts)
  vim.keymap.set('t', '<C-h>', '<cmd>lua cycle_terminal_left()<CR>', opts)
end

vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')
