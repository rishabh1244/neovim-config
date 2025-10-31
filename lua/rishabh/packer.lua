vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        requires = { 'nvim-lua/plenary.nvim' }
    }
    use { 'akinsho/toggleterm.nvim', config = function()
        require("toggleterm").setup {
            direction = 'float'
        }
    end }

    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'
    use 'morhetz/gruvbox'

    use 'navarasu/onedark.nvim'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'nvim-treesitter/playground'
    use {
        'mbbill/undotree',
        config = function()
            -- Optional: keymap to toggle
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle Undotree" })
        end
    }

    use 'tpope/vim-fugitive'
    use {
        'akinsho/bufferline.nvim',
        requires = 'kyazdani42/nvim-web-devicons'
    }
    use {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup {}
        end
    }

    --file navigator


    use {
        "andweeb/presence.nvim",
        config = function()
            require("presence"):setup({
                auto_update = true,
                neovim_image_text = "Neovim IDE",
                main_image = "neovim",
                enable_line_number = true,
            })
        end
    }


    -- LSP Zero and dependencies
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },         -- Required
            { 'hrsh7th/cmp-nvim-lsp' },     -- Required
            { 'hrsh7th/cmp-buffer' },       -- Optional
            { 'hrsh7th/cmp-path' },         -- Optional
            { 'saadparwaiz1/cmp_luasnip' }, -- Optional
            { 'hrsh7th/cmp-nvim-lua' },     -- Optional

            -- Snippets
            { 'L3MON4D3/LuaSnip' },             -- Required
            { 'rafamadriz/friendly-snippets' }, -- Optional
        }
    }
    -- Colorscheme
    require('onedark').setup {
        style = 'warmer',
        background = 'hard'
    }
    require('onedark').load()
    --discord presencei
    use {
        'vyfor/cord.nvim',
        run = ':Cord update',
        config = function()
            require('cord').setup()
        end
    }
    require('cord').setup({
        auto_update = true,
        neovim_image_text = "The One True Text Editor",
        main_image = "neovim",
        enable_line_number = true,
        buttons = {},
        show_time = true,
    })


    -- REACT !
    -- React/JS/TS syntax & LSP setup
    use 'MunifTanjim/prettier.nvim'
    use 'jose-elias-alvarez/typescript.nvim' -- Extra TypeScript utilities
    use("nvimtools/none-ls.nvim")            -- instead of jose-elias-alvarez/null-ls.nvim

    -- LSP icons, UI & status
    use 'onsails/lspkind.nvim'
    use 'folke/trouble.nvim'
    use 'folke/todo-comments.nvim'

    -- File explorer
    use {
        'nvim-tree/nvim-tree.lua',
        requires = 'nvim-tree/nvim-web-devicons',
        config = function()
            require("nvim-tree").setup()
            vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
        end
    }

    use {
        'windwp/nvim-ts-autotag',
        after = 'nvim-treesitter',
        config = function()
            require('nvim-ts-autotag').setup()
        end
    }

    -- Optional: Emmet-like snippets for HTML/JSX (div>ul>li*3 etc.)
    use 'mattn/emmet-vim'
    use 'hrsh7th/cmp-nvim-lsp-signature-help' -- Function signature help
    use 'dcampos/nvim-snippy'                 -- Alternative snippet engine (optional)
    use 'honza/vim-snippets'
end)
