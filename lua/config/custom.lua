-- Automatically save when switching buffers or leaving focus
vim.api.nvim_create_autocmd({"BufLeave", "FocusLost"}, {
  pattern = "*",
  command = "silent! wall"
})

