return {
  {
    "renerocksai/telekasten.nvim",
    config = function()
      local home = vim.fn.expand("~/Documents/Telekasten")
      require('telekasten').setup({
        home = home,
        dailies = home .. '/' .. 'Daily',
        weeklies = home .. '/' .. 'Weekly',
        templates = home .. '/' .. 'Templates',
        vaults = {
          vault1 = {
            home = "/home/aniketgm/Documents/Telekasten/Home",
          }
        }
      })
    end,
  }
}
