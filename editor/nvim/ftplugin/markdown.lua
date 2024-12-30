vim.cmd "set wrap"
vim.cmd "setlocal spell spelllang=en_us"
vim.cmd "set breakindent"
vim.keymap.set("n", "<leader>s", ":MarkdownPreviewToggle<cr>")
vim.cmd "set foldmethod=expr"
vim.cmd "set foldexpr=v:lua.markdown_level()"
vim.cmd "set shiftwidth=3"

-- Define the Lua function
function _G.markdown_level()
    local line = vim.fn.getline(vim.v.lnum)
    local header_level = line:match("^(##+)")
    if header_level then
        return ">" .. #header_level
    else
        return "="
    end
end
