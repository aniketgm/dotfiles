-- All helper functions here
-- These are called in wezterm.lua

local M = {}

M.PWSH_ARGS = { "pwsh", "-nologo" }

-- Check if array contains value
function M.has_value(tab, val)
  for _, value in ipairs(tab) do
    if value == val then
      return true
    end
  end
  return false
end

-- Get the basename from the given path
function M.basename(s)
  return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

-- Take the tab title from tab_info, else use the title from the active pane in that tab
function M.tab_title(tab_info)
  local title = tab_info.tab_title
  if title and #title > 0 then
    return title
  else
    local procname = M.basename(tab_info.active_pane.foreground_process_name)
    return procname:gsub(".exe", "")
  end
end

-- Spawn a new workspace else switch to the workspace if already exists
function M.get_ws_action_callback(wz, ws_name, ws_folder, first_tabname, ...)
  local args = { ... }
  return wz.action_callback(function(_, _)
    if M.has_value(wz.mux.get_workspace_names(), ws_name) then
      wz.mux.set_active_workspace(ws_name)
      return
    end
    local _t, _, _w = wz.mux.spawn_window({
      workspace = ws_name,
      args = M.PWSH_ARGS,
      cwd = ws_folder,
    })
    _t:set_title(first_tabname)
    for _, v in ipairs(args) do
      local _x, _, _ = _w:spawn_tab({ cwd = ws_folder })
      _x:set_title(v)
    end
    wz.mux.set_active_workspace(ws_name)
  end)
end

return M
