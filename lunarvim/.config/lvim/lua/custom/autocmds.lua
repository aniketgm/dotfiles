-- # ----------------------
-- #  Miscellaneous Config
-- # ----------------------
--
-- This houses additional configs like custom commands / autocmds, etc..

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

vim.api.nvim_create_user_command("ToggleNr", function()
  local relnumbr = vim.opt.relativenumber:get()
  local numbr = vim.opt.number:get()
  if numbr and relnumbr then
    vim.opt.number = false
    vim.opt.relativenumber = false
  else
    vim.opt.number = true
    vim.opt.relativenumber = true
  end
end, {})

vim.api.nvim_create_user_command("NewFile", function()
  vim.ui.input({ prompt = "New file: " }, function(input)
    vim.cmd("edit " .. input)
  end)
end, {})

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
