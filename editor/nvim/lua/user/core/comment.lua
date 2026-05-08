return { "terrortylor/nvim-comment",                       -- commenting functionality
  config = function()
    require("nvim_comment").setup({
      marker_padding = true,
      comment_empty = true,
      line_mapping = "<leader>c",
      operator_mapping = "<leader>c",
      comment_chunk_text_object = "ic",
    })
  end
}
