vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<leader>l", "0v$")
vim.keymap.set("n", "<S-l>", "<cmd>e#<CR>", { desc = "Go to previously opened file" })
vim.keymap.set('i', '<BS>', '<BS>', { noremap = true })

vim.keymap.set("i", "(", "()<Left>")
vim.keymap.set("i", "[", "[]<Left>")
vim.keymap.set("i", "{", "{}<Left>")
vim.keymap.set("i", "\"", "\"\"<Left>")
vim.keymap.set("i", "'", "''<Left>")
vim.keymap.set("i", "<", "<><Left>")

-- put this in your init.lua
local term_win = nil
local term_buf = nil

vim.keymap.set("i", "'", "''<Left>")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("i", "<C-BS>", "<C-w>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-h>", "<C-w>", { noremap = true, silent = true })
vim.keymap.set("i", "<BS>", "<C-w>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-?>", "<C-w>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-Del>", "<Esc>ldwi", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>q", ":bd<CR>", { desc = "Close current buffer", silent = true })


vim.api.nvim_set_keymap("n", "<leader>tf", "<Plug>PlenaryTestFile", { noremap = false, silent = false })

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "=ap", "ma=ap'a")
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

vim.keymap.set("n", "<leader>vwm", function()
    require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
    require("vim-with-me").StopVimWithMe()
end)

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Disable Shift+J (join lines)
vim.keymap.set("n", "J", "<nop>", { noremap = true, silent = true })

vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<M-h>", "<cmd>silent !tmux-sessionizer -s 0 --vsplit<CR>")
vim.keymap.set("n", "<M-H>", "<cmd>silent !tmux neww tmux-sessionizer -s 0<CR>")

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
vim.keymap.set("n", "<leader>ca", function()
    require("cellular-automaton").start_animation("make_it_rain")
end)


vim.keymap.set('i', '<C-Up>', '<Esc>:move .-2<CR>==gi', {
    desc = 'Move line up in Insert mode',
    silent = true
})

vim.keymap.set('i', '<C-Down>', '<Esc>:move .+1<CR>==gi', {
    desc = 'Move line down in Insert mode',
    silent = true
})

-- Duplicate current line up/down in Insert mode (Shift + Ctrl + Up/Down)
vim.keymap.set('i', '<S-C-Up>', '<Esc>yyP==gi', {
    desc = 'Duplicate line above in Insert mode',
    silent = true
})

vim.keymap.set('i', '<S-C-Down>', '<Esc>yyp==gi', {
    desc = 'Duplicate line below in Insert mode',
    silent = true
})


vim.keymap.set('n', '<C-Up>', ':move .-2<CR>==', {
    desc = 'Move line up in Normal mode',
    silent = true
})

vim.keymap.set('n', '<C-Down>', ':move .+1<CR>==', {
    desc = 'Move line down in Normal mode',
    silent = true
})


vim.keymap.set('n', '<S-C-Up>', 'yyP==', {
    desc = 'Duplicate line above in Normal mode',
    silent = true
})

vim.keymap.set('n', '<S-C-Down>', 'yyp==', {
    desc = 'Duplicate line below in Normal mode',
    silent = true
})
vim.keymap.set('v', '<C-Up>', ":move '<-2<CR>gv=gv", {
    desc = 'Move selection up in Visual mode',
    silent = true
})

vim.keymap.set('v', '<C-Down>', ":move '>+1<CR>gv=gv", {
    desc = 'Move selection down in Visual mode',
    silent = true
})

vim.keymap.set('n', '<S-Del>', 'dd', {
    desc = 'Delete entire line in Normal mode',
    silent = true
})


vim.keymap.set('i', '<S-Del>', 'dd', {
    desc = 'Delete entire line in Normal mode',
    silent = true
})


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

-- Terminal mode mapping (so it works *inside* the terminal too)
vim.keymap.set('t', '<leader>tf', function()
    -- First leave terminal insert mode before toggling
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-\\><C-n>', true, false, true), 'n', false)
    float_term:toggle()
end, { desc = "Toggle floating terminal" })
