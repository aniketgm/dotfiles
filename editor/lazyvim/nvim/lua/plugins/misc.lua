return {
  { "Bekaboo/deadcolumn.nvim" },
  { "meznaric/key-analyzer.nvim" },
  {
    "chrisbra/unicode.vim",
    lazy = true,
    cmd = { "UnicodeSearch", "UnicodeTable" },
    keys = {
      { "<leader>su", "<cmd>UnicodeTable<cr>", desc = "Open unicode table" },
    },
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    "sindrets/diffview.nvim",
    config = function()
      require("diffview").setup({})
    end,
    keys = {
      { "<leader>gd", "<cmd>DiffviewToggle<cr>", desc = "Toggle Diffview" },
      { "<F2>", "<cmd>DiffviewToggleFiles<cr>", desc = "Toggle Diffview Files" },
    },
  },
  {
    "RishabhRD/nvim-cheat.sh",
    dependencies = { "RishabhRD/popfix" },
    lazy = true,
    cmd = { "Cheat" },
    keys = {
      { "<leader>se", "<cmd>Cheat<cr>", desc = "Launch cheat.sh" },
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    dependencies = { "mfussenegger/nvim-dap" },
    ft = "python",
    config = function()
      require("dap-python").setup("~/AppData/Roaming/nvim-data/mason/packages/debugpy/venv/Scripts/python")
    end,
  },
  {
    "hedyhli/outline.nvim",
    config = function()
      -- Example mapping to toggle outline
      vim.keymap.set("n", "<leader>co", "<cmd>Outline<CR>", { desc = "Toggle Outline" })
      require("outline").setup({
        -- Your setup opts here (leave empty to use defaults)
        outline_window = {
          position = "left",
        },
      })
    end,
  },
  {
    "folke/twilight.nvim",
    lazy = true,
    cmd = { "Twilight" },
    keys = {
      { "<leader>ut", "<cmd>Twilight<cr>", desc = "Toggle twilight mode" },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>D", group = "dotfiles", icon = { icon = "שּׂ" } },
      },
    },
  },
  {
    "atiladefreitas/dooing",
    config = function()
      require("dooing").setup({
        window = {
          width = 50, -- Width of the floating window
          height = 15, -- Height of the floating window
          border = "rounded", -- Border style
          padding = {
            top = 1,
            bottom = 1,
            left = 5,
            right = 2,
          },
        },
      })
    end,
    keys = {
      { "<leader>td", desc = "Toggle Todo List" },
    },
    opts = {},
  },
  -- {
  --   "echasnovski/mini.files",
  --   version = false,
  --   config = function()
  --     local mini_files = require("mini.files").setup({
  --       windows = {
  --         preview = true,
  --         width_preview = 50,
  --       },
  --     })
  --   end,
  --   keys = {
  --     { "<leader>e", "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr>", desc = "Open file explorer" },
  --   },
  -- },
  -- {
  --   "sudormrfbin/cheatsheet.nvim",
  --   dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
  --   lazy = true,
  --   cmd = "Cheatsheet",
  --   keys = {
  --     { "<leader>se", "<cmd>Cheatsheet<cr>", desc = "Search cheatsheet" },
  --   }
  -- },
  -- {
  --   "rcarriga/nvim-notify",
  --   config = function()
  --     require("notify").setup({
  --       render = "minimal",
  --       top_down = false,
  --       background_colour = "#000000",
  --     })
  --   end,
  -- },
  -- {
  --   "rmagatti/auto-session",
  --   opts = {
  --     auto_save_enabled = true,
  --     log_level = "error",
  --   },
  -- },
  -- {
  --   "folke/todo-comments.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   opts = {
  --     colors = {
  --       allok = { "DiagnosticOk", "#178525" },
  --     },
  --     keywords = {
  --       TODO = { icon = "☰ ", color = "info" },
  --       DONE = { icon = " ", color = "allok" },
  --       PAUSE = { icon = "‖ ", color = "warning" },
  --     },
  --   },
  -- },
  -- {
  --   "leath-dub/snipe.nvim",
  --   opts = {
  --     ui = {
  --       max_width = -1, -- -1 means dynamic width
  --       -- Position can be "topleft", "bottomleft", "topright", "bottomright", "center", "cursor" (sets under the current cursor pos)
  --       position = "center",
  --     },
  --   },
  -- },
  -- {
  --   "anuvyklack/pretty-fold.nvim",
  --   config = function ()
  --     require('pretty-fold').setup()
  --   end
  -- },
}
