local wz = require("wezterm")

local cl = require("custom.colors")
local fn = require("custom.functions")

local C = {}

C.add_to_config = function(cf)
  cf.default_prog = fn.PWSH_ARGS
  cf.check_for_updates = false
  cf.automatically_reload_config = true
  cf.max_fps = 120
  cf.tab_bar_at_bottom = false
  cf.use_fancy_tab_bar = false
  cf.tab_max_width = 50
  cf.enable_tab_bar = true
  cf.window_background_opacity = 0.92
  cf.window_padding = { left = 2, right = 2, top = 7, bottom = 2 }
  cf.color_scheme = cl.color_scheme
  cf.font = wz.font({ family = "JetBrainsMono NF" })
  cf.font_size = 11
  cf.line_height = 1.1
end

return C
