function ColorIt(color)
    color = color or "onedark"

vim.opt.termguicolors = true
    vim.g.airline_powerline_fonts = 1
    vim.cmd.colorscheme(color)


    vim.g.airline_powerline_fonts = 1
    vim.g.airline_theme = "gruvbox"

    vim.g.gruvbox_contrast_dark = "hard" -- "soft", "medium", "hard"

    vim.g.gruvbox_contrast_light = "hard"

    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.cmd("colorscheme onedark")


vim.api.nvim_set_hl(0, "Normal", {
  bg = "#0B0F14",
  fg = "#cdd6f4"
})
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#0B0F14" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "#0B0F14" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "#0B0F14" })
local bg = "#0B0F14"

local groups = {
  "Normal",
  "NormalNC",
  "NormalFloat",
  "SignColumn",
  "EndOfBuffer",
  "VertSplit",
  "WinSeparator",
  "StatusLine",
  "StatusLineNC",
  "TabLineFill",
}

for _, group in ipairs(groups) do
  vim.api.nvim_set_hl(0, group, { bg = bg })
end
vim.api.nvim_set_hl(0, "CursorLineNr", { bg = bg })
vim.api.nvim_set_hl(0, "FoldColumn", { bg = bg })
vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = bg })
vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = bg })
vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = bg })

end 
ColorIt()
