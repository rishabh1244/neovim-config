return {
  "yunusey/codeforces-nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  config = function()
    require("codeforces-nvim").setup({
      cf_path = "~/codeforces",

      use_term_toggle = true,

      timeout = 5000,

      use_native_display = true,

      compiler = {
        cpp = { "g++", "@.cpp", "-std=c++20", "-O2", "-o", "@" },

        py = {},
      },

      run = {
        cpp = { "@" },

        py = { "python3", "@.py" },
      },
    })
  end,
}
