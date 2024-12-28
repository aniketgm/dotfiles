-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

-- This houses custom commands and autocmds

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

vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopeResults",
  command = [[setlocal nofoldenable]],
})

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "toggleterm",
--   callback = function()
--     vim.opt.number = false
--     vim.opt.relativenumber = false
--   end,
-- })

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "markdown",
--   callback = function()
--     vim.opt.conceallevel = 1
--     vim.opt.foldmethod = "indent"
--   end,
-- })

-- # Custom Commands
-- # ---------------
vim.api.nvim_create_user_command("DiffviewToggle", function(e)
  local view = require("diffview.lib").get_current_view()
  if view then
    vim.cmd("DiffviewClose")
  else
    vim.cmd("DiffviewOpen " .. e.args)
  end
end, { nargs = "*" })

vim.api.nvim_create_user_command("AddCurrTime", function()
  local time_pattern = "%a, %b %d %Y, %H:%M"
  vim.cmd("put =strftime('" .. time_pattern .. "')")
end, {})

vim.api.nvim_create_user_command("ToggleListchars", function()
  local liststatus = vim.opt.list:get()
  if liststatus then
    vim.opt.list = false
  else
    vim.opt.list = true
  end
end, {})

-- vim.api.nvim_create_user_command("ToggleNr", function()
--   local relnumbr = vim.opt.relativenumber:get()
--   local numbr = vim.opt.number:get()
--   if numbr and relnumbr then
--     vim.opt.number = false
--     vim.opt.relativenumber = false
--   else
--     vim.opt.number = true
--     vim.opt.relativenumber = true
--   end
-- end, {})

-- vim.api.nvim_create_user_command("NewFile", function()
--   vim.ui.input({ prompt = "Name: " }, function(input)
--     vim.cmd("edit " .. input)
--   end)
-- end, {})
