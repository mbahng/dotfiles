local com = require('nvim_comment')

com.setup(
  {
    marker_padding = true,
    comment_empty = true,
    line_mapping = "<leader>c",
    operator_mapping = "<leader>c",
    comment_chunk_text_object = "ic"
  }
)
