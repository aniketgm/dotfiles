local wz = require("wezterm")

local M = {}

local mod = {
  c = "CTRL",
  s = "SHIFT",
  a = "ALT",
}

local kmapbind = function(key, mods, action)
  return { key = key, mods = table.concat(mods, "|"), action = action }
end

local keymaps = function()
  local keys = {
    kmapbind("r", { mod.a }, wz.action.ReloadConfiguration),
    kmapbind("l", { mod.a }, wz.action.ShowLauncherArgs({ flags = "FUZZY|COMMANDS" })),
    kmapbind("q", { mod.c, mod.s }, wz.action.QuickSelect),

    -- Workspaces
    kmapbind("w", { mod.a }, wz.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" })),
    kmapbind("i", { mod.c, mod.a }, wz.action.SwitchToWorkspace),
    kmapbind("n", { mod.c, mod.a }, wz.action.SwitchWorkspaceRelative(1)),
    kmapbind("p", { mod.c, mod.a }, wz.action.SwitchWorkspaceRelative(-1)),

    -- Switch to tabs. Defined only for 6 tabs, since that is most number of tabs I usually keep.
    kmapbind("1", { mod.a }, wz.action.ActivateTab(0)),
    kmapbind("2", { mod.a }, wz.action.ActivateTab(1)),
    kmapbind("3", { mod.a }, wz.action.ActivateTab(2)),
    kmapbind("4", { mod.a }, wz.action.ActivateTab(3)),
    kmapbind("5", { mod.a }, wz.action.ActivateTab(4)),
    kmapbind("6", { mod.a }, wz.action.ActivateTab(5)),

    -- Pane splits and movements
    kmapbind("|", { mod.a, mod.s }, wz.action.SplitHorizontal({ domain = "CurrentPaneDomain" })),
    kmapbind("_", { mod.a, mod.s }, wz.action.SplitVertical({ domain = "CurrentPaneDomain" })),
    kmapbind("h", { mod.c, mod.s }, wz.action.ActivatePaneDirection("Left")),
    kmapbind("l", { mod.c, mod.s }, wz.action.ActivatePaneDirection("Right")),
    kmapbind("k", { mod.c, mod.s }, wz.action.ActivatePaneDirection("Up")),
    kmapbind("j", { mod.c, mod.s }, wz.action.ActivatePaneDirection("Down")),

    -- Create new workspace with prompt for entering workspace name
    kmapbind(
      "w",
      { mod.s, mod.a },
      wz.action.PromptInputLine({
        description = wz.format({
          { Attribute = { Intensity = "Bold" } },
          { Foreground = { AnsiColor = "Fuchsia" } },
          { Text = "Workspace Name" },
        }),
        action = wz.action_callback(function(window, pane, line)
          if line then
            window:perform_action(wz.action.SwitchToWorkspace({ name = line }), pane)
          end
        end),
      })
    ),

    -- Create new tab with prompt for entering tabname
    kmapbind(
      "t",
      { mod.c, mod.s },
      wz.action.PromptInputLine({
        description = wz.format({
          { Attribute = { Intensity = "Bold" } },
          { Foreground = { AnsiColor = "Fuchsia" } },
          { Text = "Tab Name" },
        }),
        -- The callback gets a gui_window, so first get mux_window and then spawn_tab
        action = wz.action_callback(function(window, _, line)
          if line then
            local tab, _, _ = window:mux_window():spawn_tab({})
            tab:set_title(line)
          end
        end),
      })
    ),
  }
  return keys
end

M.add_to_config = function(cf)
  cf.keys = keymaps()
end

return M
