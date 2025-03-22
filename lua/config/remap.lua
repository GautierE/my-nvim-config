
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", "\"_d")

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<leader>dd", "i dd();<Esc>F(a", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>du", "i dump();<Esc>F(a", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>cl", "i console.log();<Esc>F(a", { noremap = true, silent = true })

vim.keymap.set('', '<LeftMouse>', '', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', '<LeftDrag>', '', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', '<LeftRelease>', '', { noremap = true, silent = true })

