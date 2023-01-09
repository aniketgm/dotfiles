-- #----------------
-- # Custom keymaps
-- #----------------

-- To list all keymaps do: <leader>Lk

-- # <Esc> is too far to reach everytime. Use 'ii' to switch to normal mode.
vim.api.nvim_set_keymap("i", "ii", "<Esc>", { noremap = true })

-- # Non leader insert-mode keymaps
-- # ------------------------------
vim.api.nvim_set_keymap("i", "<M-1>", "FloatermNew --wintype=split --position=bottom --height=0.5", { noremap = true })


-- # Non leader normal-mode keymaps
-- # ------------------------------
lvim.keys.normal_mode["<C-S-Tab>"] = "<Plug>(CybuLastusedPrev)"
lvim.keys.normal_mode["<C-Tab>"] = "<Plug>(CybuLastusedNext)"
lvim.keys.normal_mode["<C-m>"] = "<cmd>Telescope resume<cr>"
lvim.keys.normal_mode["<C-q>"] = false
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<M-1>"] = "<cmd>FloatermNew --wintype=split --position=bottom --height=0.4<cr>"
lvim.keys.normal_mode["<F2>"] = "<cmd>DiffviewToggleFiles<cr>"
lvim.keys.normal_mode["<F3>"] = "<cmd>NvimTreeFindFileToggle<cr>"
lvim.keys.normal_mode["<F4>"] = "<cmd>UndotreeToggle<cr>"
lvim.keys.normal_mode["H"] = "<Plug>(CybuPrev)"
lvim.keys.normal_mode["L"] = "<Plug>(CybuNext)"

-- # Telescope preview window keymaps
-- # --------------------------------
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

-- Lunarvim maps '<leader>w' to save buffer.
-- Removing it for vimwiki, which uses '<leader>ww'
lvim.builtin.which_key.mappings["w"] = nil

-- # ----------------------
-- # New which-key bindings
-- # ----------------------
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
-- lvim.builtin.which_key.mappings["n"] = {
--   name = "+Neorg Telescope",
--   w = { "<cmd>Telescope neorg switch_workspace<cr>", "Switch workspace" },
--   m = { "<cmd>Neorg inject-metadata<cr>", "Add metadata" },
-- }
lvim.builtin.which_key.mappings["m"] = {
  name = "+MindNotes",
  m = { "<cmd>MindOpenMain<cr>", "Open main mind tree" },
  p = { "<cmd>MindOpenProject<cr>", "Open project mind tree" },
  c = { "<cmd>MindClose<cr>", "Close mind tree" }
}

-- # -------------------------------------
-- # Extending existing which-key bindings
-- # -------------------------------------

-- # Search extensions
lvim.builtin.which_key.mappings["sF"] = {
  "<cmd>Telescope find_files cwd=~<cr>", "Find files in HOME"
}
lvim.builtin.which_key.mappings["s/"] = {
  "<cmd>Telescope find_files cwd=/<cr>", "Find files in ROOT"
}
lvim.builtin.which_key.mappings["sB"] = {
  "<cmd>Telescope file_browser depth=2<cr>", "Browse Files"
}
lvim.builtin.which_key.mappings["sT"] = {
  "<cmd>Telescope live_grep cwd=~<cr>", "Search text in HOME"
}

-- # Buffer extensions
lvim.builtin.which_key.mappings["bs"] = {
  "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Search text in this buffer"
}
lvim.builtin.which_key.mappings["bS"] = {
  "<cmd>Telescope live_grep grep_open_files=true<cr>", "Search text in all buffers"
}

-- # Vimwiki extensions
lvim.builtin.which_key.mappings["wf"] = {
  "<cmd>lua require('telescope').extensions.vimwiki.vimwiki()<cr>", "Find wiki file"
}
lvim.builtin.which_key.mappings["wS"] = {
  "<cmd>lua require('telescope').extensions.vimwiki.live_grep()<cr>", "Live grep wiki files"
}
lvim.builtin.which_key.mappings["wg"] = {
  "<cmd>Glow<cr>", "Markdown preview"
}
lvim.builtin.which_key.mappings["wp"] = {
  "<cmd>MarkdownPreview<cr>", "Markdown preview HTML"
}

-- # Toggle Limelight
lvim.builtin.which_key.mappings["ut"] = {
  "<cmd>Limelight!!<cr>", "Toggle Limelight"
}
