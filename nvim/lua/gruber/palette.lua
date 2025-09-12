local M = {}

local palettes = {
  dark = {
    bg1 = '#181818',
    bg2 = '#232323',
    bg3 = '#2c2c2c',
    bg4 = '#363636',
    bg5 = '#525252',
    fg1 = '#e0dbd1',
    fg2 = '#888885',
    fg3 = '#636360',
    fg4 = '#4b4949',

    accent     = '#eecc22',
    comments   = '#cc8c3c',
    strings    = '#73c936',
    alt        = '#99a6a1',
    info       = '#96a6c8',
    special    = '#9e95c7',

    red        = '#e86671',
    orange     = '#d19a66',
    green      = '#98c379',
    cyan       = '#56b6c2',
    blue       = '#61afef',
    purple     = '#c678dd',

    dim_red    = '#993939',
    dim_orange = '#93691d',
    dim_green  = '#085339',
    dim_cyan   = '#2b6f77',
    dim_purple = '#8a3fa0',
  },

  light = {
    bg1 = '#fafafa',
    bg2 = '#ececec',
    bg3 = '#d8d8dc',
    bg4 = '#c8c8cc',
    bg5 = '#b2b2b6',
    fg1 = '#2e2a25',
    fg2 = '#7c7f7f',
    fg3 = '#9c9f9f',
    fg4 = '#b2b8b8',

    accent     = '#1133dd',
    comments   = '#3355ff',
    strings    = '#3c8828',
    alt        = '#78696e',
    info       = '#65749b',
    special    = '#736a98',

    red        = '#b83e47',
    orange     = '#a67042',
    green      = '#6b8f4e',
    cyan       = '#3d7d8c',
    blue       = '#4876b8',
    purple     = '#9547a8',

    dim_red    = '#cd7680',
    dim_orange = '#c89968',
    dim_green  = '#8db380',
    dim_cyan   = '#6bb8c2',
    dim_purple = '#b090c2',
  },
}

function M.get_cols()
  return palettes[vim.o.background]
end

return M
