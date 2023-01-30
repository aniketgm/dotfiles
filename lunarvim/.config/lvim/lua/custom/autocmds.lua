-- # ----------------------
-- #  Miscellaneous Config
-- # ----------------------
--
-- This houses additional configs like custom functions / autocmds, etc..

-- # Autocmds
-- # --------
vim.api.nvim_create_autocmd("FileType", {
  pattern = "floaterm",
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
  end,
})

-- # Toggle LSP
-- local diagnostic_active = true
-- local toggle_diagnostics = function()
--   diagnostic_active = not diagnostic_active
--   if diagnostic_active then
--     vim.diagnostic.show()
--   else
--     vim.diagnostic.hide()
--   end
-- end
-- vim.keymap.set('n', "<leader>lt", toggle_diagnostics)
