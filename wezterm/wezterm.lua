local wezterm = require 'wezterm'
local act = wezterm.action
local current_appearance = wezterm.gui.get_appearance()

local term_cols = {
  light = {
    '#252a2e', -- black
    '#cc1000', -- red
    '#008800', -- green
    '#c87800', -- yellow
    '#0d57e8', -- blue
    '#b232b2', -- magenta
    '#007878', -- cyan
    '#b2b4b8', -- white
  },
  dark = {
    '#606660', -- black
    '#ff6868', -- red
    '#88dd68', -- green
    '#e9b070', -- yellow
    '#4c9cff', -- blue
    '#d088de', -- magenta
    '#68dddd', -- cyan
    '#b2b8b2', -- white
  },
}

local light_scheme = { -- {{{
  background = '#fafafa',
  foreground = '#252a2e',
  selection_bg = '#005fff',
  selection_fg = '#fafafa',
  cursor_border = '#252a2e',

  ansi = term_cols.light,
  brights = term_cols.light,

  tab_bar = {
    active_tab = {
      bg_color = '#c4c4c8',
      fg_color = '#222428',
    },
    inactive_tab = {
      bg_color = '#d4d4d8',
      fg_color = '#727478',
    },
    inactive_tab_hover = {
      bg_color = '#d4d4d8',
      fg_color = '#252a2e',
    },
    new_tab = {
      bg_color = '#fafafa',
      fg_color = '#222428',
    },
    new_tab_hover = {
      bg_color = '#d4d4d8',
      fg_color = '#222428',
    },
  },
}

local dark_scheme = {
  background = '#181818',
  foreground = '#e0dbd1',
  selection_bg = '#005fff',
  selection_fg = '#fafafa',
  cursor_border = '#e0dbd1',

  ansi = term_cols.dark,
  brights = term_cols.dark,

  tab_bar = {
    active_tab = {
      bg_color = '#444444',
      fg_color = '#dddddd',
    },
    inactive_tab = {
      bg_color = '#2c2c2c',
      fg_color = '#999999',
    },
    inactive_tab_hover = {
      bg_color = '#2c2c2c',
      fg_color = '#cccccc',
    },
    new_tab = {
      bg_color = '#181818',
      fg_color = '#c0c0c0',
    },
    new_tab_hover = {
      bg_color = '#323232',
      fg_color = '#dddddd',
    },
  },
} -- }}}

local function get_cached_scheme()
  if current_appearance:find('Light') then
    return {
      scheme = light_scheme,
      titlebar = '#fafafa',
    }
  elseif current_appearance:find('Dark') then
    return {
      scheme = dark_scheme,
      titlebar = '#181818',
    }
  end
end

wezterm.on("window-config-reloaded", function(window)
  window:set_config_overrides({
    colors = get_cached_scheme().scheme,
    active_titlebar_bg = get_cached_scheme().titlebar,
    inactive_titlebar_bg = get_cached_scheme().titlebar,
  })
end)

return {
  enable_wayland = true,
  term = "wezterm",
  colors = get_cached_scheme().scheme,
  automatically_reload_config = true,

  -- Font
  font = wezterm.font 'Iosevka Arrows',
  -- harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
  font_size = 14,
  line_height = 1.25,
  freetype_load_target = "Light",

  -- Cursor
  default_cursor_style = 'SteadyBlock',
  cursor_blink_rate = 450,
  animation_fps = 1,
  cursor_blink_ease_in = 'Constant',
  cursor_blink_ease_out = 'Constant',
  force_reverse_video_cursor = true,
  hide_mouse_cursor_when_typing = true,

  -- Keybinds
  keys = {
    { key = 'n', mods = 'ALT', action = act.SpawnWindow },
    { key = 'w', mods = 'ALT', action = act.CloseCurrentPane { confirm = true } },

    { key = 't', mods = 'ALT', action = act.SpawnTab 'CurrentPaneDomain' },
    -- { key = '[', mods = 'ALT', action = act.ActivateTabRelative(-1) },
    -- { key = ']', mods = 'ALT', action = act.ActivateTabRelative(1) },
    { key = '{', mods = 'ALT|SHIFT', action = act.ActivateTabRelative(-1) },
    { key = '}', mods = 'ALT|SHIFT', action = act.ActivateTabRelative(1) },

    { key = 'n', mods = 'ALT|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = 'n', mods = 'ALT|CTRL', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
    { key = 'j', mods = 'ALT', action = act.ActivatePaneDirection 'Down' },
    { key = 'k', mods = 'ALT', action = act.ActivatePaneDirection 'Up' },
    { key = 'h', mods = 'ALT', action = act.ActivatePaneDirection 'Left' },
    { key = 'l', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },
    { key = '[', mods = 'ALT', action = act.ActivatePaneDirection 'Left' },
    { key = ']', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },

    { key = '<', mods = 'ALT|SHIFT', action = act.AdjustPaneSize { 'Left', 5 } },
    { key = '>', mods = 'ALT|SHIFT', action = act.AdjustPaneSize { 'Right', 5 } },
    { key = ',', mods = 'ALT|CTRL', action = act.AdjustPaneSize { 'Down', 2 } },
    { key = '.', mods = 'ALT|CTRL', action = act.AdjustPaneSize { 'Up', 2 } },

    { key = 'n', mods = 'CTRL|SHIFT', action = act.ScrollByLine(1) },
    { key = 'p', mods = 'CTRL|SHIFT', action = act.ScrollByLine(-1) },

    { key = 'f', mods = 'CTRL|SHIFT', action = act.Search("CurrentSelectionOrEmptyString") },
  },

  -- Window
  window_frame = {
    font = wezterm.font { family = 'Inter', weight = 'Regular' },
    font_size = 12.0,
    active_titlebar_bg = get_cached_scheme().titlebar,
    inactive_titlebar_bg = get_cached_scheme().titlebar,
  },
  inactive_pane_hsb = { saturation = 1.0, brightness = 1.0 },
  use_fancy_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
  adjust_window_size_when_changing_font_size = false,

  -- Scrolling
  scrollback_lines = 3500,
  scroll_to_bottom_on_input = true,
  alternate_buffer_wheel_scroll_speed = 1,
}

-- vim: nowrap
