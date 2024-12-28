--              __________________
--          /\  \   __           /  /\    /\           Author      : Aniket Meshram [AniGMe]
--         /  \  \  \         __/  /  \  /  \          Description : This is a wezterm configuration file
--        /    \  \       _____   /    \/    \                       similar to the tmux on Linux. This launches
--       /  /\  \  \     /    /  /            \                      a multiplexer environment to run ssh sessions,
--      /        \  \        /  /      \/      \                     terminals and terminal-programs.
--     /          \  \      /  /                \
--    /            \  \    /  /                  \     Github Repo : https://github.com/aniketgm/Dotfiles
--   /              \  \  /  /                    \
--  /__            __\  \/  /__                  __\
--

-- Include main wezterm object
local wz = require("wezterm")

-- Include local setups
local cl = require("custom.colors")
local km = require("config.keymaps")
local ui = require("config.ui")

-- Include plugin: tab bar
local tabline = wz.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

-- require("events.right-status").setup()
-- require("events.tab-title").setup()
require("events.gui-startup").setup()

-- Set main config variable
local cf = {}
if wz.config_builder then
  cf = wz.config_builder()
end

-- Add UI config
ui.add_to_config(cf)

-- Tab bar: tabline plugin config customization
-- Link: https://github.com/michaelbrusegard/tabline.wez
tabline.setup({
  options = {
    theme = cl.color_scheme,
    color_overrides = {
      tab = {
        inactive = { fg = "#89b4fa" },
        active = { fg = "#cdd6f4" },
      },
    },
  },
  sections = {
    tabline_a = { "" },
    tabline_b = { "" },
    tab_active = { "index", { "tab", padding = { left = 0, right = 1 } } },
    tab_inactive = { "index", { "tab", padding = { left = 0, right = 1 } } },
    tabline_x = {
      {
        "datetime",
        style = "[%a] %b/%d",
        hour_to_icon = false,
        icon = { wz.nerdfonts.md_calendar, color = { fg = "#56DEAA" } },
      },
    },
    tabline_y = {
      "datetime",
      {
        "battery",
        battery_to_icon = {
          empty = { wz.nerdfonts.md_battery_alert_variant_outline, color = { fg = "#FE3727" } },
          quarter = { wz.nerdfonts.md_battery_20, color = { fg = "#DE7356" } },
          half = wz.nerdfonts.md_battery_50,
          three_quarters = wz.nerdfonts.md_battery_70,
          full = { wz.nerdfonts.md_battery, color = { fg = "#73E45A" } },
        },
      },
    },
    tabline_z = { "workspace" },
  },
})
tabline.apply_to_config(cf)

-- Add keymaps config
km.add_to_config(cf)

return cf
