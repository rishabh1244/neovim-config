local builtin = require('telescope.builtin')-- Files
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", builtin.git_files,  { desc = "Git files" })

-- Live grep (search text in whole project)
vim.keymap.set("n", "<leader>fw", function()
  builtin.live_grep()
end, { desc = "Find word (live grep)" })

-- Grep selected text in visual mode
vim.keymap.set("v", "<leader>fs", function()
  builtin.grep_string()
end, { desc = "Find selected text" })

-- Search ONLY inside current file
vim.keymap.set("n", "<leader>fl", function()
  builtin.current_buffer_fuzzy_find()
end, { desc = "Find in current file" })



