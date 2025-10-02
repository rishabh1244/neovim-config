-- init.lua or a separate lua file for lsp configurations
local lsp = require("lsp-zero").preset({})

-- Setup mason for installing LSPs
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",        -- Lua
        "pyright",       -- Python
        "rust_analyzer", -- Rust
        "clangd",        -- C/C++
        "eslint",        -- Linting for JS/TS
        "jsonls",        -- JSON
        "html",          -- HTML
        "cssls",         -- CSS
        "tailwindcss",   -- TailwindCSS
        "yamlls",        -- YAML
    }
})
-- Configure LSP servers
lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    -- Example keymaps
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

    vim.keymap.set("i", "<c-f>", function()
        vim.lsp.buf.format({ async = true })
    end, { buffer = bufnr, desc = "Format Document" })
end)

lsp.setup()

-- nvim-cmp setup (autocomplete)
local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = require("lsp-zero").defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
})

vim.diagnostic.config({
    sign = true,
})


cmp.setup({
    mapping = cmp_mappings,
    sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
        { name = "luasnip" }, -- optional, if you use snippets
    }
})

vim.opt.wrap = true       -- Wrap long lines
vim.opt.linebreak = true  -- Wrap at word boundaries
vim.opt.showbreak = "↪ "  -- Show an indicator for wrapped lines

-- Optional: make wrapped lines visually indented like soft tabs
vim.opt.breakindent = true
vim.opt.breakindentopt = "shift:2,min:20"
