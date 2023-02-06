return {
  {
    "voldikss/vim-floaterm",
    init = function()
      vim.g.floaterm_keymap_new = '<F8>'
      vim.g.floaterm_keymap_toggle = '<F10>'
      vim.g.floaterm_keymap_prev = '<F9>'
      vim.g.floaterm_keymap_next = '<F11>'
      vim.g.floaterm_height = 0.8
      vim.g.floaterm_width = 0.9
      vim.g.floaterm_autoclose = 1
      -- vim.g.floaterm_title = '─[-($1/$2)-Terminal-]─'
      vim.g.floaterm_title = '─($1/$2)─Terminal─'
      vim.g.floaterm_borderchars = '─│─│╭╮╯╰'
    end,
  }
}
