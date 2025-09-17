-- plugin setup and config

_G.add({
  source = 'nvim-treesitter/nvim-treesitter',
  checkout = 'master',
  monitor = 'main',
  hooks = {
    post_checkout = function() vim.cmd('TSUpdate') end,
  },
})

require('nvim-treesitter.configs').setup({
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
})

require('mini.ai').setup()
require('mini.comment').setup()
require('mini.trailspace').setup()

require('mini.align').setup({
  modifiers = {
    -- only align first column
    F = function(steps, _)
      table.insert(steps.pre_justify, require('mini.align').gen_step.filter('n==1'))
    end,
  },
})

require('mini.surround').setup({
  mappings = {
    add            = '<leader>sa',
    delete         = '<leader>sd',
    find           = '<leader>sf',
    find_left      = '<leader>sF',
    highlight      = '<leader>sh',
    replace        = '<leader>sr',
    update_n_lines = '<leader>sn',
  },
})

require('mini.icons').setup()

require('mini.files').setup({
  windows = {
    preview = true,
    width_preview = 70,
    width_focus = 30,
  },
  -- -- disable icons
  -- content = {
  --   prefix = function() end,
  -- },
})

require('mini.pick').setup({
  -- -- disable icons
  -- source = { show = require('mini.pick').default_show },
})

require('mini.hipatterns').setup({
  highlighters = {
    fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
    hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
    todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
    note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },

    hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
  },
})

require('mini.tabline').setup({
  show_icons = false,
})

require('mini.completion').setup({
  -- delay = { completion = 200, info = 200, signature = 200 },
})
