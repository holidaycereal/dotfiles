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
    alt        = '#99afa8',
    alt2       = '#b4afa4',
    info       = '#76a9c6',
    special    = '#9e95c7',

    red        = '#e87681',
    orange     = '#d19a66',
    green      = '#98c379',
    cyan       = '#56b6c2',
    blue       = '#619fef',
    purple     = '#9088dd',

    dim_red    = '#893939',
    dim_orange = '#93691d',
    dim_green  = '#085339',
    dim_cyan   = '#2b6f77',
    dim_purple = '#6c52a3',
  },

  light = {
    bg1 = '#fafafa',
    bg2 = '#ececec',
    bg3 = '#dbdbdf',
    bg4 = '#cbcbcf',
    bg5 = '#ababaf',
    fg1 = '#252a2e',
    fg2 = '#7c7f7f',
    fg3 = '#9c9f9f',
    fg4 = '#b2b8b8',

    accent     = '#1133dd',
    comments   = '#8a2be3',
    strings    = '#227b32',
    alt        = '#78595e',
    alt2       = '#595e78',
    info       = '#5574ab',
    special    = '#735a98',

    red        = '#b82028',
    orange     = '#b26832',
    green      = '#6b8f4e',
    cyan       = '#3d7d8c',
    blue       = '#4876b8',
    purple     = '#8850a8',

    dim_red    = '#cd7680',
    dim_orange = '#c89968',
    dim_green  = '#8db380',
    dim_cyan   = '#6bb8c2',
    dim_purple = '#a080b2',
  },
}

function M.get_cols()
  return palettes[vim.o.background]
end

return M
