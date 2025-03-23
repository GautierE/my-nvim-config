-- Automatically save when switching buffers or leaving focus
vim.api.nvim_create_autocmd({"BufLeave", "FocusLost"}, {
  pattern = "*",
  command = "silent! wall"
})

vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("lazy_autoupdate", { clear = true }),
  callback = function()
    if require("lazy.status").has_updates() then
      require("lazy").update({ show = false })
    end
  end,
})

