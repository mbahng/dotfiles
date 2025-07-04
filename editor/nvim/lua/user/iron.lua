local iron = require("iron.core")
-- IMPORTANT: You must have ipython installed on your env for this to work! 
iron.setup {
  config = {
    -- Whether a repl should be discarded or not
    scratch_repl = true,
    -- Your repl definitions come here
    repl_definition = {
      sh = {
        command = {"bash", "-c", "'conda init && conda activate $CONDA_DEFAULT_ENV'" }
      },
    },
    python = {
      command = { "python", "--no-autoindent", "--matplotlib" }, -- must be python or envs don't work
      format = require("iron.fts.common").bracketed_paste
    },
    -- How the repl window will be displayed
    -- See below for more information
    repl_open_cmd = require('iron.view').split.vertical.botright(0.5),
  },
  -- You can set them here or manually add keymaps to the functions in iron.core
  keymaps = {
    send_motion = "<space>r", 
    visual_send = "<space>r",
    send_file = "<space>sf",
    send_line = "<space>sl",
    send_until_cursor = "<space>su",
    send_mark = "<space>sm",
    mark_motion = "<space>mc",
    mark_visual = "<space>mc",
    remove_mark = "<space>md",
    cr = "<space>s<cr>",
    interrupt = "<space>ri",
    exit = "<space>rq",
    clear = "<space>rl",
  },
  -- If the highlight is on, you can change how it looks
  -- For the available options, check nvim_set_hl
  highlight = {
    italic = true
  },
  ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
}
