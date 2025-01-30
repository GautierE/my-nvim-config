function ColorMyPencils(color)
    color = color or "desert"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" }) 
    vim.api.nvim_set_hl(0, "LineNr", { fg = "#B4F9F8" }) 
    vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#B4F9F8" }) 
    vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#B4F9F8" }) 
end



return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
	ColorMyPencils("tokyonight-moon")
    end
  },
}

