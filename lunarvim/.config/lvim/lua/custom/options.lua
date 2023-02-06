--[[ 
  # ------------------------
  # Lunarvim and Vim options
  # ------------------------

  lvim is the global options object. Linters should be filled in as strings with 
  either a global executable or a path to an executable
--]]

-- # Vim specific options
-- #----------------------
vim.opt.cmdheight = 1
vim.opt.colorcolumn = '80'
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.fillchars = {
  diff = '⣿', -- Show the specified symbol for Diff
  vert = '¦' -- Show the specified symbol for vertical split
}
-- vim.opt.listchars = {
--   space = '·', -- Show space with the symbol set
--   tab   = '│ ' -- Show tabs with the symbol set
-- }

-- # LunarVim specific options
-- #---------------------------
-- lvim.log.level = "warn"
-- lvim.format_on_save = true
lvim.log.level = "info"
lvim.format_on_save = {
  enabled = true,
  pattern = "*.lua",
  timeout = 1000,
}
lvim.leader = "space"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.project.show_hidden = true
lvim.builtin.terminal.active = false

-- # Telescope custom config options
lvim.builtin.telescope.theme = "ivy"
lvim.builtin.telescope.defaults.layout_config = { height = 0.6 }
lvim.builtin.telescope.pickers.buffers.initial_mode = "insert"
lvim.builtin.telescope.pickers.current_buffer_fuzzy_find = { previewer = false }
lvim.builtin.telescope.pickers.live_grep = {
  previewer = false,
  only_sort_text = true,
}
lvim.builtin.telescope.extensions.fzf = true

table.insert(lvim.builtin.breadcrumbs.winbar_filetype_exclude, "floaterm")
table.insert(lvim.builtin.breadcrumbs.winbar_filetype_exclude, "lazygit")

lvim.builtin.treesitter.auto_install = true
-- lvim.builtin.treesitter.ensure_installed = {
--   "bash",
--   "go",
--   "http",
--   "json",
--   "lua",
--   "markdown",
--   "python",
--   "yaml",
-- }
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
