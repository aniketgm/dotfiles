local M = {}

-- -- Unicode chars of interest
-- M.LEFT_HALF_CIRCLE_FILLED = utf8.char(0xe0b6) -- ""
-- M.RIGHT_ARROW_FILLED = utf8.char(0xE0B0) -- ""
-- M.LEFT_ARROW_THIN = utf8.char(0xE0B3) -- ""
-- M.SOLID_BOX_THIN_FILLED = utf8.char(0x258E) -- "▎"

-- -- Colors of interest
-- M.COLOR_1 = "#FFBFC5"
-- M.COLOR_2 = "Black"
-- M.COLOR_3 = "#3E4359"
-- M.COLOR_4 = "White"
-- M.COLOR_5 = "#191F26"

-- Color schemes of interest
local fav_color_schemes_list = {
  "Catppuccin Macchiato",
  "Whimsy",
  "wilmersdorf",
}
M.color_scheme = fav_color_schemes_list[2]

return M
