-- Jupyter-style data science workflow for Neovim
-- Drop this file in lua/plugins/datascience.lua
--
-- Stack:
--   molten-nvim  -> talks to a real Jupyter kernel, runs code, keeps state alive
--   image.nvim   -> renders plot output (png/svg) inline in the buffer (Kitty graphics protocol)
--
-- Everything here is self-contained: keymaps are buffer-local and only active
-- in Python files, so nothing in your existing config.keymaps is touched.

return {
  {
    "3rd/image.nvim",
    -- pin to a release tag; main branch breaks occasionally
    version = "^1",
    opts = {
      backend = "kitty", -- requires Kitty (or wezterm/ghostty, same protocol)
      max_width = 100,
      max_height = 24,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true,
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    },
  },

  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- last release before any breaking 2.x changes
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      -- settings must be set *before* the plugin loads
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_auto_open_output = false -- open output manually, less visual noise
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = true  -- shows a small inline marker on evaluated lines
      vim.g.molten_virt_lines_off_by_1 = true
    end,
    config = function()
      -- ── # %% cell helper ──────────────────────────────────────────────
      -- Lets you work in a plain .py file using the same "# %%" cell
      -- markers that VS Code / Jupytext use, and evaluate just the cell
      -- under the cursor.
      local function cell_range()
        local cur = vim.api.nvim_win_get_cursor(0)[1]
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        local total = #lines
        local is_marker = function(l) return l:match("^#%s*%%%%") ~= nil end

        local s = 1
        for i = cur, 1, -1 do
          if is_marker(lines[i]) then
            s = (i == cur) and (i + 1) or (i + 1)
            break
          end
        end

        local e = total
        for i = cur + 1, total do
          if is_marker(lines[i]) then
            e = i - 1
            break
          end
        end
        return s, e
      end
      local function run_cell()
        local s, e = cell_range()
        if s > e then
          vim.notify("Empty cell", vim.log.levels.WARN)
          return
        end
        vim.api.nvim_win_set_cursor(0, { s, 0 })
        vim.cmd("normal! V")
        vim.api.nvim_win_set_cursor(0, { e, 0 })
        vim.cmd("normal! \27") -- Escape: exits visual mode, finalizes '< '> as linewise
        vim.cmd("MoltenEvaluateVisual")
      end
      local function goto_next_cell()
        local cur = vim.api.nvim_win_get_cursor(0)[1]
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        for i = cur + 1, #lines do
          if lines[i]:match("^#%s*%%%%") then
            vim.api.nvim_win_set_cursor(0, { i, 0 })
            return
          end
        end
      end

      local function goto_prev_cell()
        local cur = vim.api.nvim_win_get_cursor(0)[1]
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        for i = cur - 1, 1, -1 do
          if lines[i]:match("^#%s*%%%%") then
            vim.api.nvim_win_set_cursor(0, { i, 0 })
            return
          end
        end
      end

      -- ── buffer-local keymaps, Python only ───────────────────────────
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        callback = function(args)
          local buf = args.buf
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc, silent = true })
          end

          map("n", "<leader>ji", ":MoltenInit<CR>", "Jupyter: init kernel")
          map("n", "<leader>jr", run_cell, "Jupyter: run cell")
          map("n", "<leader>jl", ":MoltenEvaluateLine<CR>", "Jupyter: run line")
          map("v", "<leader>jv", ":<C-u>MoltenEvaluateVisual<CR>gv", "Jupyter: run selection")
          map("n", "<leader>jo", ":MoltenShowOutput<CR>", "Jupyter: show output")
          map("n", "<leader>jc", ":MoltenHideOutput<CR>", "Jupyter: hide/close output")
          map("n", "<leader>jx", ":MoltenDelete<CR>", "Jupyter: delete cell output")
          map("n", "<leader>jR", ":MoltenReevaluateCell<CR>", "Jupyter: re-run last cell")
          map("n", "<leader>jq", ":MoltenInterrupt<CR>", "Jupyter: interrupt kernel")
          map("n", "]j", goto_next_cell, "Jupyter: next cell")
          map("n", "[j", goto_prev_cell, "Jupyter: prev cell")
        end,
      })
    end,
  },
}
