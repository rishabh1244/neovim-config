-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- colorscheme
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("onedark").setup({
        style = "darker",
        transparent = true,
      })
      require("onedark").load()
    end,
  },
  {
    "mbbill/undotree",
    config = function()
      vim.g.undotree_WindowLayout = 2       -- tree on left, diff on bottom
      vim.g.undotree_ShortIndicators = 1    -- compact
      vim.g.undotree_SplitWidth = 30
      vim.g.undotree_SetFocusWhenToggle = 1 -- auto focus when opened
    end,
  },
  {
    "mg979/vim-visual-multi",
    branch = "master",
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({ options = { theme = "onedark" } })
    end
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          numbers = "ordinal",
          mode = "buffers",
          separator_style = "thin", -- thin | slant | padded_slant
          show_buffer_close_icons = false,
          show_close_icon = false,
          always_show_bufferline = false, -- hides when only 1 buffer open
          diagnostics = "nvim_lsp",       -- shows error count on tab
        },
      })
    end,
  },
  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require("nvim-tree").setup() end
  },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          preview = {
            treesitter = false, -- disables the broken ts highlighter in preview
          },
        },
      })
    end,
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        direction = "float",
        float_opts = {
          border = "curved",
        },
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })
      vim.cmd("TSUpdate")
    end,
  },
  -- LSP
  { "neovim/nvim-lspconfig" },
  -- Mason (LSP installer)
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Bridge mason with nvim's built-in LSP
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "hrsh7th/cmp-nvim-lsp" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls", "rust_analyzer", "clangd",
          "html", "cssls", "pyright", "ts_ls",
          "bashls", "solidity_ls",
        },
        automatic_installation = true,
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local servers = {
        "lua_ls", "rust_analyzer", "clangd",
        "html", "cssls", "pyright", "ts_ls",
        "bashls", "solidity_ls",
      }

      for _, server in ipairs(servers) do
        vim.lsp.config(server, { capabilities = capabilities })
        vim.lsp.enable(server)
      end
    end,
  },
  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    }
  },
  -- Git signs in gutter
  { "lewis6991/gitsigns.nvim", config = function() require("gitsigns").setup() end },

  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function() require("nvim-autopairs").setup() end
  },

  -- Comments
  { "numToStr/Comment.nvim", config = function() require("Comment").setup() end },

  -- Which-key (keybinding hints)
  { "folke/which-key.nvim",  config = function() require("which-key").setup() end },

  -- inside lazy.setup, or call after mason loads:
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "ts_ls", "bashls" },
        automatic_installation = true,
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local servers = {
        "lua_ls", "rust_analyzer", "clangd",
        "html", "cssls", "pyright", "ts_ls",
        "bashls", "solidity_ls",
      }
      for _, server in ipairs(servers) do
        vim.lsp.config(server, { capabilities = capabilities })
        vim.lsp.enable(server)
      end
    end,
  }
  ,
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          python     = { "black" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          html       = { "prettier" },
          css        = { "prettier" },
          rust       = { "rustfmt" },
          c          = { "clang_format" },
          cpp        = { "clang_format" },
        },
        format_on_save = { timeout_ms = 500 }, -- remove if you don't want auto format on save
      })
    end,
  },


})
