-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local kmap_normal = function(key, cmd, desc)
  vim.api.nvim_set_keymap("n", key, cmd, { noremap = true, desc = desc })
end

local kmap_insert = function(key, cmd, desc)
  vim.api.nvim_set_keymap("i", key, cmd, { noremap = true, desc = desc })
end

local kmap_visual = function(key, cmd, desc)
  vim.api.nvim_set_keymap("v", key, cmd, { noremap = true, desc = desc })
end

local nvim_data = vim.fn.stdpath("data")
local nvim_ldata = vim.fn.stdpath("data") .. "/lazy/LazyVim"

-- # <Esc> is too far to reach everytime. Use 'ii' to switch to normal mode.
kmap_insert("ii", "<Esc>", "Goto Normal mode")

kmap_normal("<C-t>", "<cmd>FloatermNew --wintype=split --height=0.4<cr>", "Terminal in split mode")
kmap_normal("<leader>uH", "<cmd>ToggleListchars<cr>", "Toggle Listchars")
-- With FzfLua
-- kmap_normal("<leader>fl", "<cmd>FzfLua files cwd=" .. nvim_ldata .. "<cr>", "Find Files (LazyVim)")
-- kmap_normal("<leader>fL", "<cmd>FzfLua live_grep cwd=" .. nvim_ldata .. "<cr>", "Grep Files (LazyVim)")
-- kmap_normal("<leader>fo", "<cmd>FzfLua lines<cr>", "Grep Open Files")
-- kmap_normal("<leader>fp", "<cmd>FzfLua files cwd=" .. nvim_data .. "<cr>", "Find Files (Plugins)")
-- kmap_normal("<leader>fP", "<cmd>FzfLua live_grep cwd=" .. nvim_data .. "<cr>", "Grep Files (Plugins)")
-- kmap_normal("<leader>gr", "<cmd>FzfLua git_branches<cr>", "Branches")
-- With Telescope
kmap_normal("<leader>fl", "<cmd>Telescope find_files cwd=" .. nvim_ldata .. "<cr>", "Find Files (LazyVim)")
kmap_normal("<leader>fL", "<cmd>Telescope live_grep cwd=" .. nvim_ldata .. "<cr>", "Grep Files (LazyVim)")
kmap_normal("<leader>fo", "<cmd>Telescope live_grep grep_open_files=true<cr>", "Grep Open Files")
kmap_normal("<leader>fp", "<cmd>Telescope find_files cwd=" .. nvim_data .. "<cr>", "Find Files (Plugins)")
kmap_normal("<leader>fP", "<cmd>Telescope live_grep cwd=" .. nvim_data .. "<cr>", "Grep Files (Plugins)")
kmap_normal("<leader>gr", "<cmd>Telescope git_branches<cr>", "Branches")

-- Dotfiles keymaps
if vim.loop.os_uname().sysname == "Windows_NT" then
  kmap_normal("<leader>Dp", "<cmd>edit ~/Documents/PowerShell/Microsoft.PowerShell_profile.ps1<cr>", "Edit PS Profile")
  kmap_normal("<leader>Dw", "<cmd>edit ~/.config/wezterm/wezterm.lua<cr>", "Edit wezterm config")
else
  kmap_normal("<leader>Dr", "<cmd>edit ~/.bashrc<cr>", "Edit bashrc")
  kmap_normal("<leader>Da", "<cmd>edit ~/.bash_aliases<cr>", "Edit bash aliases")
  kmap_normal("<leader>Df", "<cmd>edit ~/.bash_functions<cr>", "Edit bash functions")
  kmap_normal("<leader>Ds", "<cmd>edit ~/.config/starship.toml<cr>", "Edit starship prompt config")
end
