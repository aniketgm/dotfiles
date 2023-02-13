return {
    --[[
  {
    "davidgranstrom/nvim-markdown-preview",
    config = function()
      vim.g.nvim_markdown_preview_theme = "solarized-dark"
      vim.g.nvim_markdown_preview_theme = "github"
    end
  },
  {
    "preservim/vim-markdown",
    dependencies = { "godlygeek/tabular" },
    config = function()
      vim.g.vim_markdown_folding_disabled = 1
      vim.g.vim_markdown_toc_autofit = 1
      vim.g.vim_markdown_conceal = 0
    end
  },
  --]]
    {
        "ellisonleao/glow.nvim",
        config = function()
          require('glow').setup({
              width = 110
          })
        end,
        ft = "markdown",
        lazy = true,
    },
    {
        "iamcco/markdown-preview.nvim",
        ft = "markdown",
        event = "VeryLazy",
        build = function()
          vim.fn["mkdp#util#install"]()
        end,
        lazy = true,
    },
    -- { "lvht/tagbar-markdown" },
}
