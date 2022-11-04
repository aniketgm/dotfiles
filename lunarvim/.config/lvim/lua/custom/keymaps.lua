-- #--------------------
-- # Additional keymaps
-- #--------------------

-- List all keymaps: <leader>Lk
lvim.keys.normal_mode["<C-S-Tab>"] = "<Plug>(CybuLastusedPrev)"
lvim.keys.normal_mode["<C-Tab>"] = "<Plug>(CybuLastusedNext)"
lvim.keys.normal_mode["<C-m>"] = "<cmd>Telescope resume<cr>"
lvim.keys.normal_mode["<C-q>"] = false
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<F2>"] = "<cmd>DiffviewToggleFiles<cr>"
lvim.keys.normal_mode["<F3>"] = "<cmd>NvimTreeFindFileToggle<cr>"
lvim.keys.normal_mode["H"] = "<Plug>(CybuPrev)"
lvim.keys.normal_mode["L"] = "<Plug>(CybuNext)"

local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  i = {
    ["<C-PageUp>"] = actions.preview_scrolling_up,
    ["<C-PageDown>"] = actions.preview_scrolling_down,
  },
  n = {
    ["<C-PageUp>"] = actions.preview_scrolling_up,
    ["<C-PageDown>"] = actions.preview_scrolling_down,
  },
}

-- # New which-key bindings
lvim.builtin.which_key.mappings["P"] = {
  name = "+Project",
  l = { "<cmd>Telescope projects<cr>", "Select a project" },
  s = { "<cmd>Telescope live_grep<cr>", "Search text in current project" },
}
lvim.builtin.which_key.mappings["S"] = {
  name = "+Session",
  w = { "<cmd>SaveSession<cr>", "Save current session" },
  r = { "<cmd>RestoreSession<cr>", "Restore last session" },
  s = { "<cmd>SearchSession<cr>", "Show sessions" },
  k = { "<cmd>DeleteSession<cr>", "Kill/Delete current session" },
}
lvim.builtin.which_key.mappings["gD"] = {
  name = "+Diffview",
  o = { "<cmd>DiffviewOpen -uno<cr>", "Open Diffview" },
  c = { "<cmd>DiffviewClose<cr>", "Close Diffview" },
}
lvim.builtin.which_key.mappings["D"] = {
  name = "+Dotfiles",
  r = { "<cmd>edit ~/.bashrc<cr>", "Edit bashrc" },
  a = { "<cmd>edit ~/.bash_aliases<cr>", "Edit bash aliases" },
  f = { "<cmd>edit ~/.bash_functions<cr>", "Edit bash functions" },
  t = { "<cmd>edit ~/.tmux.conf<cr>", "Edit tmux config" },
  s = { "<cmd>edit ~/.config/starship.toml<cr>", "Edit starship prompt config" },
  -- c = { "<cmd>edit ~/.config/alacritty/alacritty.yml", "Edit alacritty config" },
}

-- # Additions to existing which-key bindings
lvim.builtin.which_key.mappings["sF"] = {
  "<cmd>Telescope find_files cwd=~<cr>", "Find File in HOME dir"
}
lvim.builtin.which_key.mappings["sB"] = {
  "<cmd>Telescope file_browser depth=2<cr>", "Browse Files"
}
lvim.builtin.which_key.mappings["bs"] = {
  "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Search text in this buffer"
}
lvim.builtin.which_key.mappings["bS"] = {
  "<cmd>Telescope live_grep grep_open_files=true<cr>", "Search text in all buffers"
}
