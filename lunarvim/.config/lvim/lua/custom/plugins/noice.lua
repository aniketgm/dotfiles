return {
    {
        "folke/noice.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },
        config = function()
          require("noice").setup({
              lsp = {
                  -- override = {
                  --     ["vim.lsp.handlers.hover"] = true,
                  --     ["vim.lsp.handlers.signature_help"] = true,
                  --     -- ["config.lsp.signature.enabled"] = false,
                  --     -- ["config.lsp.hover.enabled"] = false,
                  -- }
                  signature = { enabled = false },
                  hover = { enabled = false },
              },
              messages = {
                  enabled = false
              }
          })
        end
    }
}
