-- per-language config (mostly lsp)

_G.add({
  source = 'neovim/nvim-lspconfig',
  depends = { 'williamboman/mason.nvim' },
})
require('mason').setup()

vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
})

vim.lsp.config('*', {
  capabilities = {
    textDocument = {
      completion = { completionItem = { snippetSupport = false } },
    },
  },
})

-- rust
vim.lsp.enable('rust_analyzer')

-- haskell
vim.lsp.enable('hls')

-- ocaml
vim.lsp.enable('ocamllsp')
vim.cmd('set rtp^="' .. vim.fn.expand('~') .. '/.opam/default/share/ocp-indent/vim"')

-- c/c++
vim.lsp.enable('clangd')

-- lua
vim.lsp.config('lua_ls', {
  settings = { Lua = {
    diagnostics = { globals = { 'vim' } } },
  },
})
vim.lsp.enable('lua_ls')

-- f#
-- vim defaults to forth for .fs files
vim.cmd("autocmd BufNewFile,BufRead *.fs,*.fsx,*.fsi set filetype=fsharp")
vim.lsp.enable('fsautocomplete')

-- go
vim.lsp.config('gopls', {
  on_attach = function(client, bufnr)
    vim.bo[bufnr].tabstop = 4
    vim.bo[bufnr].shiftwidth = 4
  end,
})
vim.lsp.enable('gopls')

-- js/ts {{{
-- check if deno config exists in a directory
local function has_deno_config(dir)
  local deno_files = { 'deno.json', 'deno.jsonc' }
  for _, file in ipairs(deno_files) do
    if vim.fn.filereadable(dir .. '/' .. file) == 1 then return true end
  end
  return false
end

-- find project root and determine if it's a deno project
local function get_typescript_root(bufnr, on_dir)
  local root_markers = { 'package.json', 'tsconfig.json', '.git', 'deno.json', 'deno.jsonc' }
  local current_dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ':p:h')
  local root_dir = vim.fs.find(root_markers, { upward = true, path = current_dir })[1]
  if root_dir then root_dir = vim.fn.fnamemodify(root_dir, ':p:h') end
  on_dir(root_dir)
end

vim.lsp.config('deno_ls', {
  -- cmd = { 'deno', 'lsp' },
  root_dir = function(bufnr, on_dir)
    get_typescript_root(bufnr, function(root_dir)
      -- only activate deno lsp if deno.json or deno.jsonc exists in the root
      if root_dir and has_deno_config(root_dir) then
        on_dir(root_dir)
      else
        on_dir(nil)
      end
    end)
  end,
})

vim.lsp.config('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  root_dir = function(bufnr, on_dir)
    get_typescript_root(bufnr, function(root_dir)
      -- only activate ts_ls if it's not a deno project
      if root_dir and not has_deno_config(root_dir) then
        on_dir(root_dir)
      else
        on_dir(nil)
      end
    end)
  end,
})

vim.lsp.enable({ 'deno_ls', 'ts_ls' })
-- }}}

-- c#
-- this is the most ridiculous shit i have ever had to write
vim.lsp.config('csharp_ls', {
  on_attach = function(client, bufnr)
    -- hack to make the language server wake up
    vim.defer_fn(function()
      vim.api.nvim_buf_call(bufnr, function()
        vim.cmd("silent! normal! xu")
      end)
    end, 500)
  end,
  handlers = {
    -- suppress annoying messages that steal cursor focus
    ['window/showMessage'] = function() end,
  },
})
vim.lsp.enable('csharp_ls')
