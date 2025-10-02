local terminal_buf = nil
local terminal_win = nil
 

local function toggle_terminal()
    -- If terminal window exists and is valid, close it
    if terminal_win and vim.api.nvim_win_is_valid(terminal_win) then
        vim.api.nvim_win_close(terminal_win, false)
        terminal_win = nil
        return
    end
    
    -- If terminal buffer exists, reopen it
    if terminal_buf and vim.api.nvim_buf_is_valid(terminal_buf) then
        vim.cmd('vertical botright split')
        vim.api.nvim_win_set_width(0, 50)
        vim.api.nvim_win_set_buf(0, terminal_buf)
        terminal_win = vim.api.nvim_get_current_win()
    else
        -- Create new terminal
        vim.cmd('vertical botright split')
        vim.api.nvim_win_set_width(0, 50)
        vim.cmd('terminal')
        terminal_buf = vim.api.nvim_get_current_buf()
        terminal_win = vim.api.nvim_get_current_win()
        
        -- Don't list terminal buffer
        vim.bo[terminal_buf].buflisted = false
    end
end

-- Set up keymaps
vim.keymap.set('n', '<C-E>', toggle_terminal, { desc = 'Toggle terminal', silent = true })
vim.keymap.set('t', '<C-E>', function()
    vim.cmd('stopinsert')
    toggle_terminal()
end, { desc = 'Toggle terminal from terminal mode', silent = true })
