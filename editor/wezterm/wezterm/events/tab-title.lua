local wz = require("wezterm")

local cn = require("custom.colors")
local fn = require("custom.functions")

local M = {}

M.setup = function()
  wz.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    panes = panes
    config = config
    max_width = max_width

    local background = cn.NORMAL_TAB_BG
    local foreground = cn.NORMAL_TAB_FG
    local title_italic = false

    local is_first = tab.tab_id == tabs[1].tab_id
    local is_last = tab.tab_id == tabs[#tabs].tab_id

    if tab.is_active then
      background = cn.ACTIVE_TAB_BG
      foreground = cn.ACTIVE_TAB_FG
      title_italic = true
    elseif hover then
      background = cn.HOVER_TAB_BG
      foreground = cn.HOVER_TAB_FG
    end

    local leading_fg = cn.NORMAL_TAB_FG
    local leading_bg = background
    local trailing_fg = background
    local trailing_bg = cn.NORMAL_TAB_BG
    local txt_unicode = ""

    if is_first then
      leading_fg = cn.ACTIVE_TAB_BG
      txt_unicode = cn.SOLID_BOX_FILLED
    else
      leading_fg = cn.NORMAL_TAB_BG
      txt_unicode = cn.LEFT_SEPARATOR
    end

    if is_last then
      trailing_bg = cn.HOVER_TAB_BG
    else
      trailing_bg = cn.NORMAL_TAB_BG
    end

    local tab_text = fn.tab_title(tab)

    return {
      { Background = { Color = leading_bg } },
      { Foreground = { Color = leading_fg } },
      { Text = txt_unicode },
      { Attribute = { Italic = title_italic } },
      { Attribute = { Intensity = hover and "Bold" or "Normal" } },
      { Background = { Color = leading_bg } },
      { Foreground = { Color = leading_fg } },
      { Background = { Color = background } },
      { Foreground = { Color = foreground } },
      { Text = " " .. tab_text .. " " },
      { Background = { Color = leading_bg } },
      { Foreground = { Color = leading_fg } },
      { Background = { Color = trailing_bg } },
      { Foreground = { Color = trailing_fg } },
      { Text = cn.LEFT_SEPARATOR },
    }
  end)
end

return M
