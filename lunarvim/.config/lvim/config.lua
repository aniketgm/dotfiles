--[[
              __________________
          /\  \   __           /  /\    /\           Author      : Aniket Meshram [AniGMe]
         /  \  \  \         __/  /  \  /  \          Description : Customized lunarvim configuration. This configuration
        /    \  \       _____   /    \/    \                       is divided into following sections:
       /  /\  \  \     /    /  /            \                      - LunarVim options
      /        \  \        /  /      \/      \                     - Vim options
     /          \  \      /  /                \                    - Additional plugins and their configurations
    /            \  \    /  /                  \                   - Additional keymappings
   /              \  \  /  /                    \
  /__            __\  \/  /__                  __\   Github Repo : https://github.com/aniketgm/Dotfiles

--]]

--[[
lvim is the global options object. Linters should be filled in as strings with 
either a global executable or a path to an executable
--]]

-- # LunarVim specific options
-- #---------------------------
lvim.log.level = "warn"
lvim.format_on_save = true
-- lvim.colorscheme = "onedarker"
lvim.leader = "space"
-- lvim.use_icons = false

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.project.show_hidden = true
lvim.builtin.terminal.active = true
lvim.builtin.theme.tokyonight.options.style = "moon"

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "css",
  "javascript",
  "lua",
  "markdown",
  "norg",
  "python",
  "yaml",
}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- # Vim specific options
-- #----------------------
vim.opt.cmdheight = 1
vim.opt.colorcolumn = '80'
vim.opt.relativenumber = true
vim.opt.fillchars = {
  diff = '⣿', -- Show the specified symbol for Diff
  vert = '¦' -- Show the specified symbol for vertical split
}
-- vim.opt.listchars = {
--   space = '·', -- Show space with the symbol set
--   tab   = '│ ' -- Show tabs with the symbol set
-- }

require("custom/plugins")
require("custom/keymaps")
