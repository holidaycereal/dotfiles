-- theme & colorscheme setup

_G.add({ source = 'navarasu/onedark.nvim' })

-- sync theme with system light/dark mode
function _G.theme_from_gtk()
  local success, handle = pcall(io.popen, 'gsettings get org.gnome.desktop.interface color-scheme')
  local is_dark = true

  if not success or not handle then
    vim.notify('could not detect system theme, using dark mode', vim.log.levels.WARN)
    vim.o.background = 'dark'
  else
    local result = handle:read('*a') or ''
    handle:close()
    is_dark = result:find('dark')
    vim.o.background = is_dark and 'dark' or 'light'
  end

  vim.cmd.colorscheme('gruber')
end

theme_from_gtk()
