vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Line selection and buffer navigation
vim.keymap.set("n", "<leader>l", "0v$")
vim.keymap.set("n", "<S-l>", "<cmd>e#<CR>", { desc = "Go to previously opened file" })
vim.keymap.set('i', '<BS>', '<BS>', { noremap = true })

-- Auto-pair brackets and quotes (removed <> autopair)
vim.keymap.set("i", "(", "()<Left>")
vim.keymap.set("i", "[", "[]<Left>")
vim.keymap.set("i", "{", "{}<Left>")
vim.keymap.set("i", "\"", "\"\"<Left>")
vim.keymap.set("i", "'", "''<Left>")

-- Visual mode: Move lines up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Word deletion in insert mode
vim.keymap.set("i", "<C-BS>", "<C-w>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-h>", "<C-w>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-Del>", "<Esc>ldwi", { noremap = true, silent = true })

-- Buffer management
vim.keymap.set("n", "<leader>q", ":bd<CR>", { desc = "Close current buffer", silent = true })

-- Better line joining and vertical navigation
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "=ap", "ma=ap'a")
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

-- Paste without yanking
vim.keymap.set("x", "<leader>p", [["_dP]])

-- System clipboard operations
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Delete to black hole register
vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")

-- Better escape
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Disable Q
vim.keymap.set("n", "Q", "<nop>")

-- Tmux integration
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<M-h>", "<cmd>silent !tmux-sessionizer -s 0 --vsplit<CR>")
vim.keymap.set("n", "<M-H>", "<cmd>silent !tmux neww tmux-sessionizer -s 0<CR>")

-- Quickfix and location list navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Search and replace word under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- ============================================================================
-- WORD NAVIGATION (Ctrl + Left/Right arrows)
-- ============================================================================

-- Normal mode: Jump words with Ctrl+Arrow
vim.keymap.set('n', '<C-Left>', 'b', {
    desc = 'Jump word backward in Normal mode',
    silent = true
})

vim.keymap.set('n', '<C-Right>', 'w', {
    desc = 'Jump word forward in Normal mode',
    silent = true
})

-- Insert mode: Jump words with Ctrl+Arrow
vim.keymap.set('i', '<C-Left>', '<C-o>b', {
    desc = 'Jump word backward in Insert mode',
    silent = true
})

vim.keymap.set('i', '<C-Right>', '<C-o>w', {
    desc = 'Jump word forward in Insert mode',
    silent = true
})

-- Visual mode: Extend selection by word
vim.keymap.set('v', '<C-Left>', 'b', {
    desc = 'Extend selection word backward in Visual mode',
    silent = true
})

vim.keymap.set('v', '<C-Right>', 'w', {
    desc = 'Extend selection word forward in Visual mode',
    silent = true
})

-- ============================================================================
-- LINE MOVEMENT (Ctrl + Up/Down arrows)
-- ============================================================================

-- Insert mode: Move line up/down
vim.keymap.set('i', '<C-Up>', '<Esc>:move .-2<CR>==gi', {
    desc = 'Move line up in Insert mode',
    silent = true
})

vim.keymap.set('i', '<C-Down>', '<Esc>:move .+1<CR>==gi', {
    desc = 'Move line down in Insert mode',
    silent = true
})

-- Normal mode: Move line up/down
vim.keymap.set('n', '<C-Up>', ':move .-2<CR>==', {
    desc = 'Move line up in Normal mode',
    silent = true
})

vim.keymap.set('n', '<C-Down>', ':move .+1<CR>==', {
    desc = 'Move line down in Normal mode',
    silent = true
})

-- Visual mode: Move selection up/down
vim.keymap.set('v', '<C-Up>', ":move '<-2<CR>gv=gv", {
    desc = 'Move selection up in Visual mode',
    silent = true
})

vim.keymap.set('v', '<C-Down>', ":move '>+1<CR>gv=gv", {
    desc = 'Move selection down in Visual mode',
    silent = true
})

-- ============================================================================
-- LINE DUPLICATION (Shift + Ctrl + Up/Down)
-- ============================================================================

-- Insert mode: Duplicate line
vim.keymap.set('i', '<S-C-Up>', '<Esc>yyP==gi', {
    desc = 'Duplicate line above in Insert mode',
    silent = true
})

vim.keymap.set('i', '<S-C-Down>', '<Esc>yyp==gi', {
    desc = 'Duplicate line below in Insert mode',
    silent = true
})

-- Normal mode: Duplicate line
vim.keymap.set('n', '<S-C-Up>', 'yyP==', {
    desc = 'Duplicate line above in Normal mode',
    silent = true
})

vim.keymap.set('n', '<S-C-Down>', 'yyp==', {
    desc = 'Duplicate line below in Normal mode',
    silent = true
})

-- ============================================================================
-- LINE DELETION (Shift + Delete)
-- ============================================================================

vim.keymap.set('n', '<S-Del>', 'dd', {
    desc = 'Delete entire line in Normal mode',
    silent = true
})

vim.keymap.set('i', '<S-Del>', '<Esc>ddi', {
    desc = 'Delete entire line in Insert mode',
    silent = true
})

-- ============================================================================
-- ADDITIONAL SMOOTH KEYMAPS
-- ============================================================================

-- Home/End keys in insert mode (like modern editors)
vim.keymap.set('i', '<Home>', '<C-o>^', {
    desc = 'Jump to first non-blank character in Insert mode',
    silent = true
})

vim.keymap.set('i', '<End>', '<C-o>$', {
    desc = 'Jump to end of line in Insert mode',
    silent = true
})

-- Select all
vim.keymap.set('n', '<C-a>', 'ggVG', {
    desc = 'Select all text',
    silent = true
})

-- Save with Ctrl+S (works in normal and insert mode)
vim.keymap.set('n', '<C-s>', ':w<CR>', {
    desc = 'Save file in Normal mode',
    silent = true
})

vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>a', {
    desc = 'Save file in Insert mode',
    silent = true
})

-- Undo/Redo with common shortcuts
vim.keymap.set('n', '<C-z>', 'u', {
    desc = 'Undo',
    silent = true
})

vim.keymap.set('i', '<C-z>', '<C-o>u', {
    desc = 'Undo in Insert mode',
    silent = true
})

vim.keymap.set('n', '<C-y>', '<C-r>', {
    desc = 'Redo',
    silent = true
})

vim.keymap.set('i', '<C-y>', '<C-o><C-r>', {
    desc = 'Redo in Insert mode',
    silent = true
})

-- Better indenting in visual mode
vim.keymap.set('v', '<', '<gv', {
    desc = 'Indent left and reselect',
    silent = true
})

vim.keymap.set('v', '>', '>gv', {
    desc = 'Indent right and reselect',
    silent = true
})

-- Tab navigation
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', {
    desc = 'New tab',
    silent = true
})

vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', {
    desc = 'Close tab',
    silent = true
})

vim.keymap.set('n', '<C-Tab>', ':tabnext<CR>', {
    desc = 'Next tab',
    silent = true
})

vim.keymap.set('n', '<C-S-Tab>', ':tabprevious<CR>', {
    desc = 'Previous tab',
    silent = true
})

-- Window navigation (smoother Alt+arrows)
vim.keymap.set('n', '<M-Left>', '<C-w>h', {
    desc = 'Move to left window',
    silent = true
})

vim.keymap.set('n', '<M-Right>', '<C-w>l', {
    desc = 'Move to right window',
    silent = true
})

vim.keymap.set('n', '<M-Up>', '<C-w>k', {
    desc = 'Move to upper window',
    silent = true
})

vim.keymap.set('n', '<M-Down>', '<C-w>j', {
    desc = 'Move to lower window',
    silent = true
})

-- Clear search highlighting
vim.keymap.set('n', '<Esc>', ':noh<CR>', {
    desc = 'Clear search highlighting',
    silent = true
})

-- ============================================================================
-- TOGGLETERM SETUP
-- ============================================================================

local Terminal = require("toggleterm.terminal").Terminal

require("toggleterm").setup({
    start_in_insert = true,
    insert_mappings = true,
    direction = "float",
    float_opts = { border = "curved" },
})

-- Persistent terminal instance
local float_term = Terminal:new({
    direction = "float",
    hidden = true,
})

-- Normal mode mapping
vim.keymap.set('n', '<leader>tf', function()
    float_term:toggle()
end, { desc = "Toggle floating terminal" })

-- Terminal mode mapping
vim.keymap.set('t', '<leader>tf', function()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-\\><C-n>', true, false, true), 'n', false)
    float_term:toggle()
end, { desc = "Toggle floating terminal" })

-- Easy terminal escape
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', {
    desc = 'Exit terminal mode',
    silent = true
})

-- ============================================================================
-- COMMENTING (Ctrl + /) - Using Comment.nvim
-- ============================================================================

-- Add this to your Packer configuration:
--[[
use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
}
--]]

-- Setup Comment.nvim with Ctrl+/ keybinding
require('Comment').setup({
    toggler = {
        line = '<C-_>',  -- Ctrl+/ for toggling comment on current line
        block = 'gbc',   -- Block comment in normal mode
    },
    opleader = {
        line = '<C-_>',  -- Ctrl+/ in visual mode
        block = 'gb',    -- Block comment operator
    },
    mappings = {
        basic = true,
        extra = false,
    },
})

-- Additional keymaps for commenting (Ctrl+/ works as Ctrl+_ in terminals)
vim.keymap.set('n', '<C-_>', function()
    return vim.v.count == 0
        and '<Plug>(comment_toggle_linewise_current)'
        or '<Plug>(comment_toggle_linewise_count)'
end, { expr = true, desc = 'Toggle comment' })

vim.keymap.set('v', '<C-_>', '<Plug>(comment_toggle_linewise_visual)', { desc = 'Toggle comment' })
