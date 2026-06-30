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

-- Winbar: shows breadcrumbs (function/class context)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.server_capabilities.documentSymbolProvider then
      vim.wo.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
    end
  end,
})
require("lazy").setup({
  { import = "plugins" },

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
    "NvChad/nvim-colorizer.lua",
    config = function()
        require("colorizer").setup({
            "*",
        }, {
            RGB = true,
            RRGGBB = true,
            names = true,
            RRGGBBAA = true,
            css = true,
            css_fn = true,
            mode = "background", -- color the actual text background
        })
    end,
},

  {
    "mbbill/undotree",
    config = function()
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_ShortIndicators = 1
      vim.g.undotree_SplitWidth = 30
      vim.g.undotree_SetFocusWhenToggle = 1
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
          separator_style = "thin",
          show_buffer_close_icons = false,
          show_close_icon = false,
          always_show_bufferline = false,
          diagnostics = "nvim_lsp",
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
            treesitter = false,
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
  -- Navic (breadcrumbs)
  { "SmiteshP/nvim-navic",  dependencies = "neovim/nvim-lspconfig" },
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
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "SmiteshP/nvim-navic",
    },
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
      local navic = require("nvim-navic")

      local servers = {
        "lua_ls", "rust_analyzer", "clangd",
        "html", "cssls", "pyright", "ts_ls",
        "bashls", "solidity_ls",
      }

      for _, server in ipairs(servers) do
        vim.lsp.config(server, {
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            if client.server_capabilities.documentSymbolProvider then
              navic.attach(client, bufnr)
            end
          end,
        })
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
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"]     = cmp.mapping.select_prev_item(),
          ["<C-j>"]     = cmp.mapping.select_next_item(),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"]     = cmp.mapping.abort(),
          ["<CR>"]      = cmp.mapping.confirm({ select = true }),
          ["<Tab>"]     = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
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
  { "numToStr/Comment.nvim",   config = function() require("Comment").setup() end },
  -- Which-key (keybinding hints)
  { "folke/which-key.nvim",    config = function() require("which-key").setup() end },
  -- Formatter
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
        format_on_save = { timeout_ms = 500 },
      })
    end,
  },
})

local spec = {
    "yunusey/codeforces-nvim",
    dependencies = { "nvim-lua/plenary.nvim" } -- optional, used for testing
}

spec.config = function()
    require('codeforces-nvim').setup {
        use_term_toggle = true,
        cf_path = "/path/to/desired/codeforces/folder",
        timeout = 15000,
        compiler = {
            cpp = { "g++", "@.cpp", "-o", "@" },
            py = {}
        },
        run = {
            cpp = { "@" },
            py = { "python3", "@.py" }
        },
        notify = function(title, message, type)
            local notify = require('notify')
            if message == nil then
                notify(title, type, {
                    render = "minimal",
                })
            else
                notify(message, type, {
                    title = title,
                })
            end
        end
    }
end

return spec
