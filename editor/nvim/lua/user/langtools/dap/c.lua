local dap = require("dap")

local function default_c_program()
  local cwd_program = vim.fn.getcwd() .. "/a.out"
  local buf_dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p:h")
  local buf_program = (buf_dir ~= "" and buf_dir or vim.fn.getcwd()) .. "/a.out"

  -- Prefer a Makefile-style default without prompting.
  -- Try CWD first, then the current buffer's directory.
  if vim.fn.filereadable(cwd_program) == 1 then
    return cwd_program
  end
  if vim.fn.filereadable(buf_program) == 1 then
    return buf_program
  end

  return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
end

dap.configurations.c = {
  {
    name = "Launch (a.out)",
    type = "lldb",
    request = "launch",
    program = default_c_program,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
    runInTerminal = false,
  },
}
