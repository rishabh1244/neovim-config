vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
use {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
-- or                            , branch = '0.1.x',
  requires = { {'nvim-lua/plenary.nvim'} }
 
}

use {
  'rmagatti/auto-session',
  config = function()
    require("auto-session").setup {
      auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
    }
  end
}

--color theme one dark
use 'navarasu/onedark.nvim'

use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

use('nvim-treesitter/playground')
use('theprimeagen/harpoon')
use('mbbill/undotree')
use ('tpope/vim-fugitive')

use {
  'nvim-lualine/lualine.nvim',
  requires = { 'nvim-tree/nvim-web-devicons', opt = true }
}



-- Add this to your packer.nvim plugin list
use {
  'windwp/nvim-autopairs',
  config = function()
    require('nvim-autopairs').setup{}
  end
}

end)




















