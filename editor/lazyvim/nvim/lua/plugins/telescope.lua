return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        layout_strategy = "flex",
        layout_config = { height = 0.65, width = 0.9, horizontal = { preview_width = 0.6 }, prompt_position = "top" },
        path_display = { truncate = 3 },
        sorting_strategy = "ascending",
      },
    },
    -- keys = {
    --   { "<leader>xx", "<cmd>Telescope workspace_diagnostics<cr>", desc = "Diagnostics (Telescope)" },
    --   { "<leader>xX", "<cmd>Telescope document_diagnostics<cr>", desc = "Buffer Diagnostics (Telescope)" },
    --   { "<leader>cs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Symbols (Telescope)" },
    --   { "<leader>cS", false },
    --   { "<leader>xL", "<cmd>Telescope loclist<cr>", desc = "Location List (Telescope)" },
    --   { "<leader>xQ", "<cmd>Telescope quickfix<cr>", desc = "Quickfix List (Telescope)" },
    -- },
  },
  {
    "crispgm/telescope-heading.nvim",
    config = function()
      require("telescope").load_extension("heading")
    end,
    lazy = true,
    ft = {
      "markdown",
      "help",
    },
  },
  {
    "xiyaowong/telescope-emoji.nvim",
    lazy = true,
    config = function()
      require("telescope").load_extension("emoji")
    end,
    keys = {
      { "<leader>fm" },
    },
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          frecency = {
            show_scores = true,
            show_filter_column = false,
            path_display = { "filename_first" },
          },
        },
      })
      require("telescope").load_extension("frecency")
    end,
    keys = {
      { "<leader>fq" },
    },
  },
  -- { "nvim-telescope/telescope-symbols.nvim", lazy = true, },
}
