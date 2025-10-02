-- lua/config/harpoon.lua (example)
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

local function goto_tab(n)
  local tab_count = #vim.api.nvim_list_tabpages()
  if n <= tab_count then
    vim.api.nvim_set_current_tabpage(vim.api.nvim_list_tabpages()[n])
  end
end

-- map Alt+1..9
for i = 1, 9 do
  map('n', '<M-' .. i .. '>', function()
    goto_tab(i)
  end, opts)
end

  --- mark operations
map('n', '<C-a>', function()
  require('harpoon.mark').add_file()
end, opts)                         -- add current file to Harpoon

map('n', '<C-m>', function()
  require('harpoon.ui').toggle_quick_menu()
end, opts)                         -- toggle Harpoon quick menu

-- navigation
map('n', '<C-h>', function()
  require('harpoon.ui').nav_prev()
end, opts)                         -- previous harpoon file

map('n', '<C-l>', function()
  require('harpoon.ui').nav_next()
end, opts)                         -- next harpoon file

-- direct nav to files 1..9
-- NOTE: <C-1>..<C-9> usually don’t work in terminal Neovim
-- use <M-1> (Alt+1) instead if you want numbers
for i = 1, 9 do
  map('n', '<M-' .. i .. '>', function()
    require('harpoon.ui').nav_file(i)
  end, opts)
end

-- optional: open a terminal in harpoon (if using harpoon.term)
map('n', '<C-t>', function()
  require('harpoon.term').gotoTerminal(1) 
end, opts)
map('n', '<C-a>', function()
  require('harpoon.mark').add_file()
end, opts)                         -- add current file to Harpoon

map('n', '<C-m>', function()
  require('harpoon.ui').toggle_quick_menu()
end, opts)                         -- toggle Harpoon quick menu

-- navigation
map('n', '<C-h>', function()
  require('harpoon.ui').nav_prev()
end, opts)                         -- previous harpoon file

map('n', '<C-l>', function()
  require('harpoon.ui').nav_next()
end, opts)                         -- next harpoon file

-- direct nav to files 1..9
-- NOTE: <C-1>..<C-9> usually don’t work in terminal Neovim
-- use <M-1> (Alt+1) instead if you want numbers
for i = 1, 9 do
  map('n', '<M-' .. i .. '>', function()
    require('harpoon.ui').nav_file(i)
  end, opts)
end

