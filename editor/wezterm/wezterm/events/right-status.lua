local wz = require("wezterm")

local cn = require("custom.colors")

local M = {}

---@type string[]
local icons_discharging = {
  wz.nerdfonts.md_battery_10,
  wz.nerdfonts.md_battery_20,
  wz.nerdfonts.md_battery_30,
  wz.nerdfonts.md_battery_40,
  wz.nerdfonts.md_battery_50,
  wz.nerdfonts.md_battery_60,
  wz.nerdfonts.md_battery_70,
  wz.nerdfonts.md_battery_80,
  wz.nerdfonts.md_battery_90,
  wz.nerdfonts.md_battery,
}

---@type string[]
local icons_charging = {
  wz.nerdfonts.md_battery_charging_10,
  wz.nerdfonts.md_battery_charging_20,
  wz.nerdfonts.md_battery_charging_30,
  wz.nerdfonts.md_battery_charging_40,
  wz.nerdfonts.md_battery_charging_50,
  wz.nerdfonts.md_battery_charging_60,
  wz.nerdfonts.md_battery_charging_70,
  wz.nerdfonts.md_battery_charging_80,
  wz.nerdfonts.md_battery_charging_90,
  wz.nerdfonts.md_battery_charging,
}

M.setup = function()
  wz.on("update-right-status", function(window, _)
    local batt_stat = ""
    local batt_icon = ""
    local batt = ""
    for _, b in ipairs(wz.battery_info()) do
      local idx = umath.clamp(umath.round(b.state_of_charge * 10), 1, 10)
      batt_stat = string.format("%.0f%%", b.state_of_charge * 100)
      if b.state == "Charging" then
        batt_icon = icons_charging[idx]
      else
        batt_icon = icons_discharging[idx]
      end
      batt = batt_icon .. batt_stat
    end

    window:set_right_status(wz.format({
      { Foreground = { Color = cn.RBS.TAB_BAR_FG } },
      { Text = cn.RIGHT_SEPARATOR },
      { Text = cn.RIGHT_SEPARATOR },
      { Attribute = { Italic = true } },
      { Text = " " .. wz.nerdfonts.dev_brackets .. " " .. window:active_workspace() .. " " },
      { Text = cn.RIGHT_SEPARATOR },
      { Text = cn.RIGHT_SEPARATOR },
      { Foreground = { Color = cn.RBS.TAB_BAR_FG } },
      { Text = " " .. batt .. " " },
      { Text = cn.RIGHT_SEPARATOR },
      { Text = cn.RIGHT_SEPARATOR },
      { Foreground = { Color = cn.RBS.TAB_BAR_FG } },
      { Text = " " .. wz.nerdfonts.md_calendar_month .. " " .. wz.time.now():format("[%a] %b %d") .. " " },
      { Text = cn.RIGHT_SEPARATOR },
      { Text = cn.RIGHT_SEPARATOR },
      { Foreground = { Color = cn.RBS.TAB_BAR_FG } },
      { Text = " " .. wz.nerdfonts.md_clock_outline .. " " .. wz.time.now():format("%H:%M") },
    }))
  end)
end

return M
