function ColorIt(color)
  color = color or "onedark"

  vim.o.termguicolors = true


  vim.g.airline_powerline_fonts = 1
  vim.cmd.colorscheme(color)


vim.g.airline_powerline_fonts = 1
vim.g.airline_theme = "gruvbox"

vim.g.gruvbox_contrast_dark = "hard"   -- "soft", "medium", "hard"

vim.g.gruvbox_contrast_light = "hard"

  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorIt()

