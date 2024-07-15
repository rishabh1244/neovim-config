
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
vim.wo.number = true

local builtin = require('telescope.builtin')
vim.g.mapleader = " "
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})

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
	vim.api.nvim_set_hl(0,"Normal", {bg="none"})
	--vim.api.nvim_set_hl(1,"NormalFloat", {bg="none"})
end
ColorPencils()

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






--for autocompleate and shit
-- nvim-cmp setup
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  window = {},
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for `:` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
local lspconfig = require'lspconfig'
local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.pyright.setup {
  capabilities = capabilities,
}

lspconfig.tsserver.setup {
  capabilities = capabilities,
}

lspconfig.gopls.setup {
  capabilities = capabilities,
}

-- Add more LSP servers as needed
-- Add this at the beginning of your init.lua to bootstrap packer.nvim if it is not already installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

  if packer_bootstrap then
    require('packer').sync()
  end
end)

