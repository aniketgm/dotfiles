-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- # Powershell config
-- # -----------------
vim.opt.shell = "pwsh"
vim.opt.shellcmdflag =
  "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
vim.cmd([[
  let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
  let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
  set shellquote= shellxquote=
]])
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.colorcolumn = "80"
vim.opt.swapfile = false
vim.diagnostic.enable(false)
vim.diagnostic.config({ virtual_text = false })
vim.opt.listchars = {
  space = "·", -- Show space with the symbol set
  -- tab = "│ ", -- Show tabs with the symbol set
  tab = "> ", -- Show tabs with the symbol set
  eol = "~",
}
vim.opt.list = false
-- vim.diagnostic.set(ns, 1, diagnostics, { virtual_text = false })
