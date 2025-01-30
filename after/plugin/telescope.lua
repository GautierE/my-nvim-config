local telescope = require('telescope')
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope find git files' })
vim.keymap.set('n', '<leader>ps', function()
    require('telescope.builtin').grep_string({
        search = vim.fn.input("Grep > "),
        additional_args = { "--hidden" },
    })
end)

telescope.setup {

    pickers = {

        find_files = {

            hidden = true

        }

    }
}
