return {
  { "junegunn/limelight.vim" },
  { "kdheepak/lazygit.nvim" },
  { "chrisbra/unicode.vim" },
  { "ThePrimeagen/harpoon" },
  {
    "rcarriga/nvim-notify",
    config = function()
      require('notify').setup({
        render = "minimal",
      })
    end
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require('colorizer').setup()
    end
  },
  {
    "sindrets/diffview.nvim",
    config = function()
      require("diffview").setup({})
    end
  },
  {
    "rest-nvim/rest.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require('rest-nvim').setup({})
    end
  },
  {
    "rmagatti/session-lens",
    dependencies = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
    config = function()
      require('auto-session').setup()
    end
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require('trouble').setup {}
    end
  },

  --[[
  {
    "anuvyklack/pretty-fold.nvim",
    config = function ()
      require('pretty-fold').setup()
    end
  },
  {
    "stevearc/oil.nvim",
    config = function ()
      table.insert(lvim.builtin.telescope.defaults.layout_config, { height = 0.5 })
      require("oil").setup()
    end
  },
  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup()
    end,
  },
  {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup()
    end,
  },
  --]]

}
