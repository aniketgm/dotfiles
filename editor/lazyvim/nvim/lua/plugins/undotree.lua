return {
  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
    keys = { -- load the plugin only when using it's keybinding:
      { "<F4>", "<cmd>lua require('undotree').toggle()<cr>" },
    },
  },
  -- {
  --   "mbbill/undotree",
  --   config = function()
  --     vim.cmd([[
  --       if has("persistent_undo")
  --         let target_path = expand('~/.undodir')
  --
  --         " create the directory and any parent directories
  --         " if the location does not exist.
  --         if !isdirectory(target_path)
  --             call mkdir(target_path, "p", 0700)
  --         endif
  --
  --         let &undodir=target_path
  --         set undofile
  --       endif
  --     ]])
  --   end,
  -- },
}
