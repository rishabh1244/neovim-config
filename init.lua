
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
vim.wo.number = true

vim.cmd([[autocmd VimLeave * mksession! ~/.config/nvim/session.vim]])
vim.cmd([[autocmd VimEnter * source ~/.config/nvim/session.vim]])



local builtin = require('telescope.builtin')
vim.g.mapleader = " "
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})

require('nvim-autopairs').setup{
  disable_filetype = { "TelescopePrompt" }, -- disable autopairs in specific filetypes
  disable_in_macro = true, -- disable autopairs when recording a macro
  disable_in_visualblock = false, -- disable autopairs when selecting text in visual block mode
  ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]],"%s+", "") -- ignore certain characters
}


-- harpoon keymaps begin
vim.keymap.set('n',"<C-a>",ui.toggle_quick_menu)
vim.keymap.set('n',"<leader>a",mark.add_file)
vim.keymap.set('n',"<C-q>",function() ui.nav_file(1) end)
vim.keymap.set('n',"<C-w>",function() ui.nav_file(2) end)
vim.keymap.set('n',"<C-e>",function() ui.nav_file(3) end)
vim.keymap.set('n',"<C-r>",function() ui.nav_file(4) end)
--harpoon keymaps end

vim.keymap.set("n", "<leader>pv" , vim.cmd.Ex)

--activate one dark
-- Lua
require('onedark').load()
--toggle undot
vim.keymap.set("n","<leader>u", vim.cmd.UndotreeToggle)


-- transparent ide

function ColorPencils(color)
    color = color or 'onedark'
    vim.cmd.colorscheme(color)

    local hl_groups = {
        "Normal",
        "NormalFloat",
        "LineNr",
        "SignColumn",
        "StatusLine",
        "StatusLineNC",
        "VertSplit",
        "EndOfBuffer"
    }

    for _, group in ipairs(hl_groups) do
        vim.api.nvim_set_hl(0, group, { bg = "none" })
    end
end

ColorPencils('onedark')

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
--vim.opt.expandtab = false
require('lualine').setup()





-- undo system
vim.api.nvim_set_keymap('i', '<Space>', '<Space><C-g>u', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('i', '<CR>', '<CR><C-g>u', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<BS>', '<BS><C-g>u', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-z>', '<C-o>u', { noremap = true, silent = true })
--more fast keymaps
vim.api.nvim_set_keymap('i', '<C-Del>', '<Esc>ddi', { noremap = true, silent = true })



---copy paste and shit 
vim.o.clipboard = 'unnamedplus'

-- Key mappings for copy and paste using system clipboard
vim.api.nvim_set_keymap('n', '<leader>y', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>Y', '"+Y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>p', '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>P', '"+P', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>p', '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>P', '"+P', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>x', 'd', { noremap = true })

-- space Y to copy the line , space + y to copy selected stuff
vim.api.nvim_set_keymap('n', '<leader>lv', ':belowright split | terminal<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tn', ':tabnew<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<S-Tab>', ':tabnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-W>', ':wq!<CR>', { noremap = true, silent = true })



