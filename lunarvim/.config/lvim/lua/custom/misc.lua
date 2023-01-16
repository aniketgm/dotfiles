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
