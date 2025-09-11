-- keymaps

local map = function(mode, original, replace)
  return vim.keymap.set(
    mode, original, replace,
    { noremap = true, silent = true }
  )
end

-- override auto comment behvaiour
map('n', '<leader>o', 'o<Esc>cc')
map('n', '<leader>O', 'O<Esc>cc')

-- just insert a newline and stay in normal mode
map('n', '<C-.>', 'o<Esc>k')
map('n', '<C-,>', 'O<Esc>')

-- keep cursor centred
map('n', '<C-u>', '<C-u>zz')
map('n', '<C-d>', '<C-d>zz')

-- toggle line/column highlighting
map('n', '<leader>cc', ':set cursorcolumn!<CR>')
map('n', '<leader>cl', ':set cursorline!<CR>')

-- use system clipboard
map({'n', 'v'}, '<leader>y', '"+y')
map({'n', 'v'}, '<leader>Y', '"+Y')
map({'n', 'v'}, '<leader>p', '"+p')
map({'n', 'v'}, '<leader>P', '"+P')

-- set tabstop
for i = 1, 8 do
  map('n', '<leader>t' .. i, function()
    vim.o.tabstop = i
    vim.o.shiftwidth = i
  end)
end

-- colorscheme debugging
map('n', '<leader>I', ':Inspect<CR>')
map('n', '<leader>qh', ':so $VIMRUNTIME/syntax/hitest.vim<CR>')
map('n', 'L', _G.theme_from_gtk)

-- emacs bindings for insert mode
map('i', '<C-a>', '<Home>')
map('i', '<C-e>', '<End>')
map('i', '<C-k>', '<End><C-u>')
map('i', '<C-d>', '<Right><C-h>')
map('i', '<A-d>', '<C-Right><C-w>')
map('i', '<C-b>', '<Left>')
map('i', '<C-f>', '<Right>')
map('i', '<A-b>', '<C-Left>')
map('i', '<A-f>', '<C-Right>')

-- mini.files
map('n', '<leader>f.', require('mini.files').open)

-- mini.pick
map('n', '<leader>ff', require('mini.pick').builtin.files)
map('n', '<leader>fg', require('mini.pick').builtin.grep_live)
map('n', '<leader>fb', require('mini.pick').builtin.buffers)

-- show lsp diagnostic floating window
map('n', '<leader>ds', vim.diagnostic.open_float)
