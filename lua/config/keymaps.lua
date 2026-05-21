vim.g.mapleader = " " -- MUST be first line

local map = vim.keymap.set

map("n", "<leader>f", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format file" })
-- map
map("n", "<leader>q", ":bdelete<CR>", { desc = "Close buffer" })
map("n", "<leader>l", "V", { desc = "Select line" })

-- terminals 
map("n", "<leader>tf", "<cmd>1ToggleTerm direction=float<cr>",      { desc = "Float terminal" })
map("n", "<leader>th", "<cmd>2ToggleTerm direction=horizontal<cr>", { desc = "Horizontal terminal" })
-- undo
map("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { desc = "Undotree" })

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*",
  callback = function()
    local opts = { buffer = 0 }
    map("t", "<leader>tf", "<cmd>1ToggleTerm<cr>", opts)
    map("t", "<leader>th", "<cmd>2ToggleTerm<cr>", opts)
    map("t", "<Esc>", "<cmd>ToggleTerm<cr>", opts)
  end,
})
-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(e)
    local opts = { buffer = e.buf }
    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "K", vim.lsp.buf.hover, opts)
    map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    map("n", "<leader>rn", vim.lsp.buf.rename, opts)
    map("n", "gr", vim.lsp.buf.references, opts)
    map("n", "<leader>d", vim.diagnostic.open_float, opts)
    map("n", "[d", vim.diagnostic.goto_prev, opts)
    map("n", "]d", vim.diagnostic.goto_next, opts)
  end,
})

-- File explorer
map("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file tree" })

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })

-- Buffer by number
for i = 1, 9 do
  map("n", "<leader>" .. i, "<cmd>BufferLineGoToBuffer " .. i .. "<cr>", { desc = "Buffer " .. i })
end

-- Window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Buffer navigation
map("n", "<S-l>", ":bnext<CR>")
map("n", "<S-h>", ":bprevious<CR>")

-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move lines up/down
map("n", "<A-j>", ":m .+1<CR>==")
map("n", "<A-k>", ":m .-2<CR>==")
