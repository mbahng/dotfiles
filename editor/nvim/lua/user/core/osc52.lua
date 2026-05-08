return { "ojroques/nvim-osc52",                            -- connecting local clipboard to remote connections 
  config = function() 
    -- yanking both copies to neovim clipboard (normal) and local clipboard (osc52) 
    -- local clipboard is good for when working in remote servers. Must be after plugins.lua
    vim.keymap.set('v', 'y', function()
      -- Copy to Neovim registers
      vim.cmd('normal! y')
      -- Copy to system clipboard via OSC52
      require('osc52').copy_visual()
    end, { noremap = true, silent = true })

    vim.keymap.set('n', 'yy', function()
      vim.cmd('normal! yy')
      local line = vim.fn.getline('.')
      require('osc52').copy(line)
    end, { noremap = true, silent = true })
  end
}

