local wz = require("wezterm")

local M = {}

M.setup = function()
  wz.on("gui-startup", function(_)
    local tab1, _, win1 = wz.mux.spawn_window({ workspace = "Main", cwd = wz.home_dir })
    win1:gui_window():toggle_fullscreen()
    tab1:set_title("Task-Mgmt")
    local tab2, _, _ = win1:spawn_tab({ cwd = wz.home_dir })
    tab2:set_title("Misc")
    -- local tk_summ = 'MiscPrograms/task_summary.sh'
    -- local pane2 = pane1:split {
    --   direction = 'Bottom', size = 0.59, cwd = wz.home_dir, args = { 'wsl', '-e', 'taskwarrior-tui' },
    -- }
  end)
end

return M
