local harpoon_mark = require("harpoon.mark")
local harpoon_ui = require("harpoon.ui")


-- Keymaps
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<C-a>", function() harpoon_mark.add_file() end, opts)
map("n", "<C-m>", function() harpoon_ui.toggle_quick_menu() end, opts)
map("n", "<C-h>", function() harpoon_ui.nav_prev() end, opts)
map("n", "<C-l>", function() harpoon_ui.nav_next() end, opts)

for i = 1, 9 do
  map("n", "<M-" .. i .. ">", function()
    harpoon_ui.nav_file(i)
  end, opts)
end


