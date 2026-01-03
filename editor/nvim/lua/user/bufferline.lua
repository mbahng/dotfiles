local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  return
end

bufferline.setup {
  options = {
    themable = true,
    mode = "buffers",
    numbers = "none", 
    indicator = {
        style = 'underline', 
    },
    -- buffer_close_icon = '',
    modified_icon = "●",
    -- close_icon = "",
    -- close_icon = '',
    left_trunc_marker = "",
    right_trunc_marker = "",
    max_name_length = 30,
    max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
    tab_size = 20,
    name_formatter = function(buf)
      local parent = vim.fn.fnamemodify(buf.path, ":h:t")
      if parent ~= "." then
        return parent .. "/" .. buf.name
      end
      return buf.name
    end,
    diagnostics = "nvim_lsp", 
    diagnostics_update_in_insert = false,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      return "("..count..")"
    end,
    -- NOTE: this will be called a lot so don't do any heavy processing here
    custom_filter = function(buf_number)
      local buftype = vim.bo[buf_number].buftype
      local bufname = vim.fn.bufname(buf_number)
      
      -- Include Iron REPL terminal buffers
      if buftype == "terminal" and (string.match(bufname, "iron") or vim.bo[buf_number].filetype == "iron") then
        return true
      end
      
      -- Exclude other terminal buffers (optional)
      if buftype == "terminal" then
        return false
      end
      
      -- Exclude other unwanted buffer types
      if buftype == "quickfix" or buftype == "help" or buftype == "nofile" then
        return false
      end
      
      return true
    end,
    offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
    show_buffer_icons = true,
    show_buffer_close_icons = false,
    show_close_icon = false,
    show_tab_indicators = true,
    persist_buffer_sort = true,  
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = "slant",
    enforce_regular_tabs = true,
    always_show_bufferline = true,
    -- sort_by = 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
    --   -- add custom logic
    --   return buffer_a.modified > buffer_b.modified
    -- end
  },
  highlights = {
    fill = {
      guifg = { attribute = "fg", highlight = "TabLine" },
      guibg = { attribute = "bg", highlight = "TabLine" },
    },
    background = {
      guifg = { attribute = "fg", highlight = "TabLine" },
      guibg = { attribute = "bg", highlight = "TabLine" },
    },
  
    buffer_selected = {
      guifg = '#000000',
      guibg = '#ffc9de',
      gui = 'bold',
    },
    buffer_visible = {
      guifg = { attribute = "fg", highlight = "TabLine" },
      guibg = { attribute = "bg", highlight = "TabLine" },
    },
     
    close_button = {
      guifg = { attribute = "fg", highlight = "TabLine" },
      guibg = { attribute = "bg", highlight = "TabLine" },
    },
    close_button_visible = {
      guifg = { attribute = "fg", highlight = "TabLine" },
      guibg = { attribute = "bg", highlight = "TabLine" },
    },
    close_button_selected = {
      guifg = '#000000',
      guibg = '#ffc9de',
    },
  
    tab_selected = {
      guifg = '#000000',
      guibg = '#ffc9de',
      gui = 'bold',
    },
    tab = {
      guifg = { attribute = "fg", highlight = "TabLine" },
      guibg = { attribute = "bg", highlight = "TabLine" },
    },
    tab_close = {
      -- guifg = {attribute='fg',highlight='LspDiagnosticsDefaultError'},
      guifg = { attribute = "fg", highlight = "TabLineSel" },
      guibg = { attribute = "bg", highlight = "Normal" },
    },
    duplicate_selected = {
      guifg = '#000000',
      guibg = '#ffc9de',
      gui = 'italic',
    },
    duplicate_visible = {
      guifg = { attribute = "fg", highlight = "TabLine" },
      guibg = { attribute = "bg", highlight = "TabLine" },
      gui = "italic",
    },
    duplicate = {
      guifg = { attribute = "fg", highlight = "TabLine" },
      guibg = { attribute = "bg", highlight = "TabLine" },
      gui = "italic",
    },
    modified = {
      guifg = { attribute = "fg", highlight = "TabLine" },
      guibg = { attribute = "bg", highlight = "TabLine" },
    },
    modified_selected = {
      guifg = '#000000',
      guibg = '#ffc9de',
    },
    modified_visible = {
      guifg = { attribute = "fg", highlight = "TabLine" },
      guibg = { attribute = "bg", highlight = "TabLine" },
    },
    separator = {
      guifg = { attribute = "bg", highlight = "TabLine" },
      guibg = { attribute = "bg", highlight = "TabLine" },
    },
    separator_selected = {
      guifg = { attribute = "bg", highlight = "Normal" },
      guibg = { attribute = "bg", highlight = "Normal" },
    },
    -- separator_visible = {
    --   guifg = {attribute='bg',highlight='TabLine'},
    --   guibg = {attribute='bg',highlight='TabLine'}
    --   },
    indicator_selected = {
      guifg = '#000000',
      guibg = '#ffc9de',
    },
  },
}

-- Make Iron REPL buffers listed
vim.api.nvim_create_autocmd({"TermOpen", "BufEnter"}, {
  pattern = "*",
  callback = function()
    local bufname = vim.fn.bufname()
    local buftype = vim.bo.buftype
    
    -- Check if this is an Iron REPL buffer
    if buftype == "terminal" and (
      string.match(bufname, "iron") or 
      string.match(bufname, "python") or 
      string.match(bufname, "ipython") or
      string.match(bufname, "julia") or
      string.match(bufname, "R")  -- adjust patterns as needed
    ) then
      vim.bo.buflisted = true
    end
  end,
})
