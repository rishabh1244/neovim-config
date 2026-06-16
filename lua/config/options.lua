local opt = vim.opt
vim.diagnostic.config({
  signs = false,        -- removes W E I H from gutter
  virtual_text = false, -- removes inline error text too (optional)
  underline = true,     -- keeps underline on bad code
  update_in_insert = false,
})
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undodir"

opt.number = true
opt.relativenumber = false
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.wrap = true
opt.termguicolors = true
opt.scrolloff = 8
opt.cursorline = true
opt.clipboard = "unnamedplus"   -- system clipboard
opt.splitbelow = true
opt.splitright = true
opt.updatetime = 10
opt.timeoutlen = 300
vim.opt.guicursor = ""
