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
  { "sainnhe/sonokai" },
  -- { "NTBBloodbath/doom-one.nvim" },

  -- ## Others
  -- ## ------
  { "chrisbra/unicode.vim" },
  { "junegunn/limelight.vim" },
  { "kdheepak/lazygit.nvim" },
  { "mbbill/undotree" },
  { "nvim-telescope/telescope-file-browser.nvim" },
  { "nvim-telescope/telescope-symbols.nvim" },
  { "vimwiki/vimwiki" },
  { "ElPiloto/telescope-vimwiki.nvim" },
  { "itchyny/calendar.vim" },
  { "ellisonleao/glow.nvim" },
  { "davidgranstrom/nvim-markdown-preview" },
  { "sindrets/diffview.nvim" },
  -- { "petertriho/nvim-scrollbar" },
  -- { "folke/zen-mode.nvim" },

  -- {
  --   "iamcco/markdown-preview.nvim",
  --   run = "cd app && npm install",
  --   setup = function()
  --     vim.g.mkdp_filetypes = { "markdown" }
  --   end,
  --   ft = { "markdown" },
  -- },
  {
    "rmagatti/session-lens",
    requires = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
  },
  {
    "ghillb/cybu.nvim",
    branch = "main",
    requires = { "kyazdani42/nvim-web-devicons", "nvim-lua/plenary.nvim" },
  },
  -- {
  --   "nvim-neorg/neorg",
  --   run = ":Neorg sync-parsers",
  --   requires = { "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope" },
  -- }
  -- {
  --   "aniketgm/mind.nvim",
  --   branch = 'master',
  --   requires = { "nvim-lua/plenary.nvim" },
  -- },
}

-- #-----------------------------
-- # Plugin config
-- # >> After loading the plugins
-- #-----------------------------

-- # Colorscheme config
-- # ------------------
vim.g.sonokai_style = 'andromeda'
vim.g.sonokai_better_performance = 1
lvim.colorscheme = "sonokai"

-- require('doom-one').setup({
--   italic_comments = true,
--   transparent_background = true
-- })

-- # Auto-Session
-- # ------------
require('auto-session').setup()

-- # DiffView
-- # --------
require("diffview").setup({})

-- # Glow
-- # ----
require('glow').setup({
  width = 110
})

-- # Nvim-scrollbar (minimap)
-- # ------------------------
-- require("scrollbar").setup()

-- # Zen-mode
-- # --------
-- require("zen-mode").setup()

-- # Telescope
-- # ---------
-- lvim.builtin.telescope.defaults.winblend = 15 -- don't use, impacts performance
lvim.builtin.telescope.pickers.current_buffer_fuzzy_find = { previewer = false }
lvim.builtin.telescope.pickers.find_files.previewer = nil
lvim.builtin.telescope.pickers.live_grep = {
  previewer = false,
  only_sort_text = true,
}
lvim.builtin.telescope.extensions.fzf = true

require("telescope").load_extension "session-lens"
require("telescope").load_extension "file_browser"
require("telescope").load_extension "vimwiki"

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

-- # Undotree
-- # --------
vim.cmd([[
  if has("persistent_undo")
    let target_path = expand('~/.undodir')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
  endif
]])

-- # Vimwiki
-- # -------
vim.g.vimwiki_list = {
  {
    path = '~/Documents/Vimwiki/',
    path_html = '~/Documents/Vimwiki/site_html/',
    custom_wiki2html = 'vimwiki_markdown',
    diary_rel_path = 'Diary/',
    syntax = 'markdown',
    ext = '.md',
    template_default = 'default',
    template_ext = '.tpl',
    template_path = '~/Documents/Vimwiki/templates/',
    auto_toc = 1,
  }
}
vim.g.vimwiki_listsyms = ' ○◑✓'
vim.g.vimwiki_global_ext = 0
require("luasnip").filetype_extend("vimwiki", { "markdown" })

-- # Markdown Preview
-- # ----------------
vim.g.nvim_markdown_preview_theme = "solarized-dark"

-- ## -- ## -- ## -- ## -- Extras -- ## -- ## -- ## --

-- # Neorg
-- # -----
-- require("neorg").setup {
--   load = {
--     -- ["core.defaults"] = {}, -- Enable default modules

--     ["core.autocommands"] = {},
--     ["core.norg.esupports.hop"] = {},
--     ["core.norg.esupports.metagen"] = {},
--     ["core.keybinds"] = {},
--     ["core.norg.news"] = {},
--     ["core.norg.qol.toc"] = {},
--     ["core.norg.qol.todo_items"] = {},
--     -- ["core.syntax"] = {},            -- Has some issue with auto-session.
--     ["core.tangle"] = {},
--     ["core.norg.esupports.indent"] = {},
--     ["core.norg.journal"] = {},
--     ["core.integrations.treesitter"] = {},
--     ["core.neorgcmd"] = {},
--     ["core.mode"] = {},

--     ["core.norg.dirman"] = {
--       config = {
--         workspaces = {
--           projects = "~/Documents/Neorg/Projects",
--           study    = "~/Documents/Neorg/Study",
--           finance  = "~/Documents/Neorg/Finance",
--           social   = "~/Documents/Neorg/Social",
--         }
--       }
--     },
--     ["core.norg.concealer"] = {},
--     ["core.integrations.telescope"] = {}, -- Requires neorg-telescope plugin
--   }
-- }
-- local sources_table = lvim.builtin.cmp.sources
-- sources_table[#sources_table + 1] = { name = "neorg" }

-- # Mind: Note taking and workflow
-- # ------------------------------
-- require("mind").setup {
--   persistence = {
--     state_path = "~/Documents/MindNotes/mind.json",
--     data_dir = "~/Documents/MindNotes"
--   },
--   ui = {
--     width = 30,
--     icon_preset = {
--       { " ", "Project" },
--       { " ", "Idea" },
--       { " ", "Note(s)" },
--       { "陼", "Tasks/Todos" },
--       { " ", "Todo" },
--       { "☰ ", "Doing" },
--       { " ", "Done" },
--       { " ", "Cancelled" },
--       { " ", "GitHub" },
--       { " ", "Monitoring" },
--       { " ", "Internet, Earth, everyone!" },
--       { " ", "On Hold" },
--       { "₹ ", "Finance" },
--     }
--   }
-- }

-- # Vim Markdown
-- # ------------
-- vim.g.vim_markdown_folding_disabled = 1
-- vim.g.vim_markdown_conceal = 2
-- vim.g.vim_markdown_toc_autofit = 1
