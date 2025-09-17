-- theme & colorscheme setup

-- sync theme with system light/dark mode
function _G.theme_from_gtk()
  local success, handle = pcall(io.popen, 'gsettings get org.gnome.desktop.interface color-scheme')

  if not success or not handle then
    vim.notify('could not detect system theme, using dark mode', vim.log.levels.WARN)
    vim.o.background = 'dark'
  else
    local result = handle:read('*a') or ''
    handle:close()
    vim.o.background = result:find('light') and 'light' or 'dark'
  end

  vim.cmd.colorscheme('alenatheme')
end

theme_from_gtk()
