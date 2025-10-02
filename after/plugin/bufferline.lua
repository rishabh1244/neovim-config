require("bufferline").setup{
    options = {
        numbers = "ordinal",        -- shows 1, 2, 3 … for easy jump
        diagnostics = "nvim_lsp",  -- show LSP errors/warnings
        show_buffer_close_icons = true,
        show_close_icon = false,
        separator_style = "thin",
        indicator = { style = "icon", icon = "▎" },
        always_show_bufferline = true,
        offsets = {
            {
                filetype = "NvimTree",
                text = "EXPLORER",
                highlight = "Directory",
                text_align = "left"
            }
        },
    }
}
-- Jump to buffers quickly (1-9)
for i = 1, 9 do
    vim.keymap.set("n", "<leader>"..i, function() 
        require("bufferline").go_to_buffer(i, true) 
    end)
end
 
