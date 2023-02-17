-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

-- stylua: ignore
local colors = {
    blue   = '#80a0ff',
    cyan   = '#79dac8',
    black  = '#080808',
    white  = '#c6c6c6',
    red    = '#ff5189',
    violet = '#d183e8',
    grey   = '#303030',
    green  = "#98be65",
    bg     = '#202328',
    fg     = "#bbc2cf",
}

local bubbles_theme = {
    normal = {
        a = { fg = colors.black, bg = colors.blue },
        b = { fg = colors.fg, bg = colors.grey },
        c = { fg = colors.fg, bg = colors.black },
    },
    insert = { a = { fg = colors.black, bg = colors.green } },
    visual = { a = { fg = colors.black, bg = colors.cyan } },
    replace = { a = { fg = colors.black, bg = colors.red } },
    inactive = {
        a = { fg = colors.fg, bg = colors.bg },
        b = { fg = colors.fg, bg = colors.bg },
        c = { fg = colors.fg, bg = colors.bg },
    },
}

lvim.builtin.lualine.options.theme = bubbles_theme
lvim.builtin.lualine.options.component_separators = '|'
lvim.builtin.lualine.options.section_separators = { left = '', right = '' }
lvim.builtin.lualine.options.icons_enabled = lvim.use_icons
lvim.builtin.lualine.options.globalstatus = true
lvim.builtin.lualine.options.disabled_filetypes = { "alpha" }

local lualinecomps = require "lvim.core.lualine.components"

local mode = {
    function()
      return lvim.icons.ui.Target .. " "
    end,
    separator = { left = '' },
    right_padding = 2,
    color = {},
    cond = nil,
}

lvim.builtin.lualine.sections.lualine_a = { mode }
lvim.builtin.lualine.sections.lualine_b = { lualinecomps.branch }
lvim.builtin.lualine.sections.lualine_c = {
    lualinecomps.diff,
    lualinecomps.python_env,
}
lvim.builtin.lualine.sections.lualine_x = {
    lualinecomps.diagnostics,
    lualinecomps.lsp,
    -- lualinecomps.spaces,
    lualinecomps.filetype,
}
lvim.builtin.lualine.sections.lualine_y = { lualinecomps.progress }
lvim.builtin.lualine.sections.lualine_z = { { 'location', separator = { right = '' }, left_padding = 2 } }

lvim.builtin.lualine.inactive_sections.lualine_a = { mode }
lvim.builtin.lualine.inactive_sections.lualine_b = { lualinecomps.branch }
lvim.builtin.lualine.inactive_sections.lualine_c = {
    lualinecomps.diff,
    lualinecomps.python_env,
}
lvim.builtin.lualine.inactive_sections.lualine_x = {
    lualinecomps.diagnostics,
    lualinecomps.lsp,
    -- lualinecomps.spaces,
    lualinecomps.filetype,
}
lvim.builtin.lualine.inactive_sections.lualine_y = { lualinecomps.progress }
lvim.builtin.lualine.inactive_sections.lualine_z = { { 'location', separator = { right = '' }, left_padding = 2 } }

lvim.builtin.lualine.tabline = {}
lvim.builtin.lualine.extensions = {}
