return {
  {
    "voldikss/vim-floaterm",
    config = function()
      vim.g.floaterm_keymap_new = "<F9>"
      vim.g.floaterm_keymap_toggle = "<F11>"
      vim.g.floaterm_keymap_prev = "<F10>"
      vim.g.floaterm_keymap_next = "<F12>"
      vim.g.floaterm_wintype = "float"
      vim.g.floaterm_height = 0.7
      vim.g.floaterm_width = 0.9
      vim.g.floaterm_autoclose = 1
      vim.g.floaterm_title = "─($1/$2)─Terminal─"
      vim.g.floaterm_borderchars = "─│─│╭╮╯╰"
    end,
    lazy = true,
    cmd = { "FloatermOpen", "FloatermToggle", "FloatermNew" },
    keys = {
      { "<C-t>", "<cmd>FloatermNew --wintype=split --height=0.4<cr>", desc = "Terminal in split mode" },
      { "<F11>", mode = { "n", "t" }, "<cmd>FloatermToggle<cr>", desc = "Toggle terminal" },
    },
  },
}
