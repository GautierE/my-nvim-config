
vim.cmd("highlight! HarpoonActive guibg=NONE guifg=#8FE2E1")
vim.cmd("highlight! HarpoonNumberActive guibg=NONE guifg=#8FE2E1")
require("harpoon").setup({
    tabline = true,
    menu = {
        width = vim.api.nvim_win_get_width(0) - 20,
    },
})

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<leader>&", function() ui.nav_file(1) end)
vim.keymap.set("n", "<leader>é", function() ui.nav_file(2) end)
vim.keymap.set("n", "<leader>\"", function() ui.nav_file(3) end)
vim.keymap.set("n", "<leader>'", function() ui.nav_file(4) end)
vim.keymap.set("n", "<leader>(", function() ui.nav_file(5) end)
vim.keymap.set("n", "<leader>-", function() ui.nav_file(6) end)
vim.keymap.set("n", "<leader>è", function() ui.nav_file(7) end)
vim.keymap.set("n", "<leader>!", function() ui.nav_file(8) end)
vim.keymap.set("n", "<leader>ç", function() ui.nav_file(9) end)
