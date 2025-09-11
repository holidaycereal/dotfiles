-- basic settings

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.termguicolors = true
vim.o.autochdir = true
vim.o.undofile = true
vim.o.title = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 4
vim.o.cursorline = true
vim.o.signcolumn = 'no'
vim.o.colorcolumn = '0'
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.winborder = 'rounded'
vim.o.foldmethod = 'marker'
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.incsearch = true

vim.o.guicursor = 'n:block-blinkon0,c-ci:block-blinkon300,v:block-blinkon0,i:ver25-blinkon300,r-cr-o:hor20'

vim.o.cino = '(s,U1,Ws,m1,l1,:0,g0,j1,J1'
-- (s,U1,Ws - indent properly within unclosed parens
-- m1       - closing parens line up properly
-- l1       - code after case labels indents properly
-- :0       - case labels align with switch
-- g0       - c++ scope declaration outdent
-- j1,J1    - java/javascript object indentation

vim.g.editorconfig = true

vim.g.markdown_fenced_languages = {
  'ts=typescript',
}
