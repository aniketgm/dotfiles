return {
  -- {
  --   "rmehri01/onenord.nvim",
  --   config = function()
  --     require('onenord').setup({
  --       styles = {
  --         -- comments = "NONE",
  --         -- strings = "NONE",
  --         -- keywords = "italic",
  --         -- functions = "NONE",
  --         variables = "italic",
  --         -- diagnostics = "underline",
  --       },
  --       disable = {
  --         background = true,
  --         float_background = true
  --       }
  --     })
  --     lvim.colorscheme = "onenord"
  --   end
  -- },
  -- {
  --   "scottmckendry/cyberdream.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("cyberdream").setup({
  --       transparent = true,
  --       italic_comments = true,
  --       theme = {
  --         variant = "auto",
  --         highlights = {
  --           -- See `:h highlight-groups` for a list of highlight groups or run `:hi` to see all groups and their current values
  --           Function = { bg = "NONE", italic = true },
  --           Keyword = { bg = "NONE", italic = true },
  --           String = { fg = "#1bcfa2", bg = "NONE" },
  --         },
  --       }
  --     })
  --     lvim.colorscheme = "cyberdream"
  --   end
  -- },
  {
    "ribru17/bamboo.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("bamboo").setup({
        transparent = true,
        code_style = {
          functions = { italic = true },
          variables = { italic = true },
        },
        lualine = {
          transparent = true,
        },
        highlights = {
          ["@comment"] = { fg = "#696969" },
        },
      })
    end,
  },
  -- {
  --   'rose-pine/neovim',
  --   name = 'rose-pine',
  --   config = function()
  --     require("rose-pine").setup({
  --       variant = "moon",
  --       styles = {
  --         bold = true,
  --         italic = true,
  --         transparency = true,
  --       },
  --     })
  --     lvim.colorscheme = "rose-pine"
  --   end
  -- },
  -- {
  --   "AlexvZyl/nordic.nvim",
  --   config = function()
  --     require("nordic").setup({
  --       -- transparent_bg = true,
  --       -- reduced_blue = true,
  --       cursorline = {
  --         bold = false,       -- Bold font in cursorline.
  --         bold_number = true, -- Bold cursorline number.
  --         theme = 'dark',     -- Avialable styles: 'dark', 'light'.
  --         blend = 0.95,       -- Blending the cursorline bg with the buffer bg.
  --       },
  --     })
  --     lvim.colorscheme = "nordic"
  --   end,
  -- },
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   config = function()
  --     require("catppuccin").setup({
  --       transparent_background = true,
  --       no_italic = false,
  --       styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
  --         comments = { "italic" }, -- Change the style of comments
  --         conditionals = { "italic" },
  --         functions = { "italic" },
  --       },
  --     })
  --     -- lvim.colorscheme = "catppuccin-macchiato"
  --     -- lvim.colorscheme = "catppuccin-mocha"
  --     -- lvim.colorscheme = "catppuccin-frappe"
  --   end,
  -- },
  --
  -- Yet to try
  --
  -- {
  --   "uloco/bluloco.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   dependencies = { 'rktjmp/lush.nvim' },
  --   config = function()
  --     -- your optional config goes here, see below.
  --   end,
  -- },
  { "LazyVim/LazyVim", opts = { colorscheme = "bamboo" } },
}
