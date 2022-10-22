-- #--------------------
-- # Additional plugins
-- #--------------------
lvim.plugins = {
  -- {
  --   "folke/trouble.nvim",
  --   cmd = "TroubleToggle",
  -- },

  -- ## Colorschemes
  -- ## ------------
  { "folke/tokyonight.nvim" },
  { "sainnhe/sonokai" },
  -- {
  --   "NTBBloodbath/doom-one.nvim",
  --   config = function()
  --     require('doom-one').setup({
  --       italic_comments = true,
  --       transparent_background = true
  --     })
  --   end
  -- },
  -- { "EdenEast/nightfox.nvim" },
  -- { "jacoborus/tender.vim" },

  -- ## Others
  -- ## ------
  {
    'rmagatti/session-lens',
    requires = {
      'rmagatti/auto-session',
      'nvim-telescope/telescope.nvim'
    }
  },
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
    config = function()
      require("diffview").setup()
    end,
  },
  { "kdheepak/lazygit.nvim" },
  { "nvim-telescope/telescope-file-browser.nvim" },
  {
    "ghillb/cybu.nvim",
    branch = "main",
    requires = { "kyazdani42/nvim-web-devicons", "nvim-lua/plenary.nvim" },
  }
}

-- #--------------------
-- # Additional config
-- #--------------------

-- # Colorscheme config
-- # ------------------
-- vim.g.sonokai_style = 'default'
-- vim.g.sonokai_style = 'andromeda'
-- vim.g.sonokai_better_performance = 1
-- vim.g.sonokai_transparent_background = 1
-- vim.g.sonokai_style = 'espresso'
-- vim.g.sonokai_enable_italic = 1
require("tokyonight").setup({
  style = "moon", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
  transparent = false, -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
  styles = {
    comments = {},
    keywords = {},
    functions = { italic = true },
    variables = {},
  },
})

lvim.colorscheme = "tokyonight"
-- lvim.colorscheme = "sonokai"
-- lvim.colorscheme = "doom-one"

-- # Auto-Session
-- # ------------
require('auto-session').setup()

-- # Telescope
-- # ---------
lvim.builtin.telescope.defaults.layout_strategy = "bottom_pane"
lvim.builtin.telescope.defaults.sorting_strategy = "ascending"
lvim.builtin.telescope.defaults.path_display = { truncate = true }
-- lvim.builtin.telescope.defaults.winblend = 15
lvim.builtin.telescope.pickers.current_buffer_fuzzy_find = { previewer = false }
lvim.builtin.telescope.pickers.live_grep = {
  previewer = false,
  shorten_path = true,
  only_sort_text = true,
}
lvim.builtin.telescope.pickers.buffers = {
  sort_lastused = true,
  mappings = {
    i = { ["<C-d>"] = "delete_buffer" }
  }
}
lvim.builtin.telescope.pickers.find_files.layout_config = { preview_width = 65 }
lvim.builtin.telescope.extensions.fzf = true

require("telescope").load_extension "session-lens"
require("telescope").load_extension "file_browser"

-- # Cybu [Cycle Buffer]
-- # -------------------
require("cybu").setup({
  position = {
    max_win_height = 5,
    max_win_width = 1.2
  },
  style = {
    border = "rounded",
    hide_buffer_id = true
  }
})
