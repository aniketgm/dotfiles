return {
  "ghillb/cybu.nvim",
  branch = "main",
  dependencies = { "kyazdani42/nvim-web-devicons", "nvim-lua/plenary.nvim" },
  config = function()
    require("cybu").setup({
      position = {
        max_win_height = 5,
        max_win_width = 1.4
      },
      style = {
        border = "rounded",
        hide_buffer_id = true
      }
    })
  end,
}
