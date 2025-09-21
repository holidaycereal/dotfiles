-- autocmds

local autocmd = vim.api.nvim_create_autocmd

local mkgroup = function(groupname)
  return vim.api.nvim_create_augroup(groupname, { clear = true })
end

-- highlight yanked text briefly
autocmd('TextYankPost', {
  group = mkgroup('YankHighlight'),
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 150 })
  end,
})

-- synchronise theme with system
autocmd({'FocusGained', 'FocusLost'}, {
  group = mkgroup('ThemeFromGtk'),
  callback = _G.theme_from_gtk,
})

-- custom behaviour for help windows
autocmd('FileType', {
  group = mkgroup('HelpCustom'),
  pattern = 'help',
  callback = function()
    -- vim.keymap.set({'n', 'v'}, 'j', '<C-e>', { buffer=true, noremap=true, silent=true })
    -- vim.keymap.set({'n', 'v'}, 'k', '<C-y>', { buffer=true, noremap=true, silent=true })
    vim.wo.scrolloff = 999
    vim.wo.cursorline = false
  end,
})

-- markdown
autocmd('FileType', {
  group = mkgroup('Markdown'),
  pattern = 'markdown',
  callback = function()
    vim.wo.linebreak = true
    vim.wo.spell = true
    -- vim.bo.textwidth = 80
  end,
})

-- html
autocmd('FileType', {
  group = mkgroup('HTML'),
  pattern = 'html',
  callback = function()
    vim.wo.linebreak = true
  end,
})
