vim.g.python3_host_prog = vim.fn.expand("~/.venv/bin/python3")
require("config.options")
require("config.codeforces")
require("config.keymaps")
require("config.lazy")
vim.o.statusline = "%f %=%l:%c"
vim.env.DISPLAY = ":0"
