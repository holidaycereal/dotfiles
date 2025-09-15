local M = {}

function M.load()
  vim.cmd('hi clear')
  if vim.fn.exists('syntax_on') then vim.cmd('syntax reset') end
  vim.g.colors_name = 'alenatheme'
  require('alenatheme.highlights').set_all()
end

return M
