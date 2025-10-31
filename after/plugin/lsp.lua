local lsp = require("lsp-zero").preset({})
local null_ls = require("null-ls")

-- Setup Mason & ensure LSPs are installed
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "pyright",
        "rust_analyzer",
        "clangd",
        "eslint",
        "ts_ls",
        "html",
        "cssls",
        "emmet_ls",
        "tailwindcss",
        "jsonls",
        "yamlls",
    },
    handlers = {
        lsp.default_setup,
    },
})

-- =============================
-- Manual LSP Configurations
-- =============================

-- HTML LSP with full capabilities
require('lspconfig').html.setup({
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    filetypes = { "html", "htmldjango", "htm" },
    init_options = {
        configurationSection = { "html", "css", "javascript" },
        embeddedLanguages = {
            css = true,
            javascript = true
        },
        provideFormatter = true
    },
    settings = {
        html = {
            format = {
                enable = true
            },
            hover = {
                documentation = true,
                references = true
            }
        }
    }
})

-- Emmet LSP for HTML abbreviations
require('lspconfig').emmet_ls.setup({
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    filetypes = {
        "html",
        "htmldjango",
        "typescriptreact",
        "javascriptreact",
        "css",
        "sass",
        "scss",
        "less",
        "svelte",
        "vue"
    },
    init_options = {
        html = {
            options = {
                ["bem.enabled"] = true,
            },
        },
    },
})

-- CSS LSP
require('lspconfig').cssls.setup({
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    filetypes = { "css", "scss", "less", "sass" },
})

-- Attach keymaps & formatting
lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

    -- Format on save
    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })
    end
end)

lsp.setup()

-- =============================
-- nvim-cmp (Autocompletion)
-- =============================
local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

-- Load friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip",  priority = 750 },
        { name = "buffer",   priority = 500 },
        { name = "path",     priority = 250 },
    }),
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
            before = function(entry, vim_item)
                return vim_item
            end
        }),
    },
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
})

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = false,
})

-- =============================
-- null-ls (Formatters & Linters)
-- =============================
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.prettier.with({
            filetypes = {
                "javascript",
                "typescript",
                "typescriptreact",
                "javascriptreact",
                "json",
                "css",
                "scss",
                "html",
                "markdown"
            },
        }),
    },
})

-- =============================
-- TypeScript/React Enhancements
-- =============================
require("typescript").setup({
    disable_commands = false,
    server = {
        on_attach = function(client, bufnr)
            local opts = { buffer = bufnr }
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>", opts)
        end,
    },
})

-- =============================
-- Wrap Settings
-- =============================
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.showbreak = "↪ "
vim.opt.breakindent = true
vim.opt.breakindentopt = "shift:2,min:20"
