require("rishabh")
require("rishabh.set")
require("terminal")
vim.opt.guifont = "Monocraft Nerd Font:h14"
vim.opt.clipboard = "unnamedplus"
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.g.airline_theme = 'onedark'
  end,
})
---31 10 25
