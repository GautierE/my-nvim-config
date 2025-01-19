local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.prettier.with({
            filetypes = { "javascript", "typescript", "css", "html", "json" },
            extra_args = { "--single-quote", "false" },
        }),
    },
})

vim.cmd([[
    augroup FormatOnSave
        autocmd!
        autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx lua vim.lsp.buf.format()
    augroup END
]])

