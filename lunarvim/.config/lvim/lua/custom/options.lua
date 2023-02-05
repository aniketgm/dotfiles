--[[ 
  # ------------------------
  # Lunarvim and Vim options
  # ------------------------

  lvim is the global options object. Linters should be filled in as strings with 
  either a global executable or a path to an executable
--]]

-- # LunarVim specific options
-- #---------------------------
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.leader = "space"

-- # Lvim colorscheme
-- # ----------------
-- vim.g.sonokai_style = 'andromeda'
-- vim.g.sonokai_better_performance = 1

-- lvim.colorscheme = "sonokai"
lvim.colorscheme = "nordic"
-- lvim.colorscheme = "tokyonight"

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.project.show_hidden = true
lvim.builtin.terminal.active = false
lvim.builtin.theme.tokyonight.options.style = "moon"

-- # Telescope extra config options
lvim.builtin.telescope.theme = "ivy"
-- lvim.builtin.telescope.defaults.winblend = 15 -- don't use, impacts performance
lvim.builtin.telescope.defaults.layout_config = { height = 0.6 }
-- lvim.builtin.telescope.pickers.find_files.previewer = nil
lvim.builtin.telescope.pickers.buffers.initial_mode = "insert"
lvim.builtin.telescope.pickers.current_buffer_fuzzy_find = { previewer = false }
lvim.builtin.telescope.pickers.live_grep = {
  previewer = false,
  only_sort_text = true,
}
lvim.builtin.telescope.extensions.fzf = true

table.insert(lvim.builtin.breadcrumbs.winbar_filetype_exclude, "floaterm")
table.insert(lvim.builtin.breadcrumbs.winbar_filetype_exclude, "lazygit")

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "css",
  "go",
  "http",
  "json",
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
