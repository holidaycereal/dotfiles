local M = {}

local function blend(col1, col2, alpha)
  local function hex_to_rgb(hex_str)
    local pattern = "^#([abcdef0-9][abcdef0-9])([abcdef0-9][abcdef0-9])([abcdef0-9][abcdef0-9])$"
    local r, g, b = string.match(hex_str, pattern)
    return { tonumber(r, 16), tonumber(g, 16), tonumber(b, 16) }
  end
  col1 = hex_to_rgb(col1)
  col2 = hex_to_rgb(col2)
  local function blendChannel(i)
    local ret = (alpha * col1[i] + ((1 - alpha) * col2[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end
  return string.format("#%02X%02X%02X", blendChannel(1), blendChannel(2), blendChannel(3))
end

function M.set_all()
  local c = require('gruber.palette').get_cols()

  local common = {
    ['Normal']       = { fg = c.fg1, bg = c.bg1 },
    ['Visual']       = { bg = c.bg4 },
    ['VisualNOS']    = { bg = c.bg4, underline = true },
    ['EndOfBuffer']  = { fg = c.bg1 },
    ['FoldColumn']   = { bg = c.bg3 },
    ['Folded']       = { bg = c.bg3, italic = true },
    ['SpecialKey']   = { fg = c.bg3 },
    ['NonText']      = { fg = c.bg3 },
    ['Whitespace']   = { fg = c.bg3 },
    ['Conceal']      = { fg = c.bg3 },
    ['WinSeparator'] = { fg = c.bg3 },
    ['Cursor']       = { reverse = true },
    ['vCursor']      = { link = 'Cursor' },
    ['iCursor']      = { link = 'Cursor' },
    ['lCursor']      = { link = 'Cursor' },
    ['CursorIM']     = { link = 'Cursor' },
    ['TermCursor']   = { link = 'Cursor' },
    ['LineNr']       = { fg = c.fg4 },
    ['CursorLineNr'] = { fg = c.accent },
    ['CursorLine']   = { bg = c.bg2 },
    ['CursorColumn'] = { link = 'CursorLine' },
    ['Search']       = { bg = c.bg4 },
    ['CurSearch']    = { bg = c.bg5 },
    ['IncSearch']    = { link = 'CurSearch' },
    ['Substitute']   = { link = 'CurSearch' },
    ['MatchParen']   = { bg = c.bg5 },

    -- UI elements
    ['Title']            = { bold = true },
    ['Directory']        = { fg = c.blue, bold = true },
    ['ErrorMsg']         = { fg = c.red, bold = true },
    ['WarningMsg']       = { fg = c.orange, bold = true },
    ['MoreMsg']          = { fg = c.fg1 },
    ['ModeMsg']          = { fg = c.fg1 },
    ['Question']         = { fg = c.fg1 },
    ['NormalFloat']      = { bg = c.bg1 },
    ['FloatBorder']      = { bg = c.bg1, fg = c.fg2 },
    ['QuickFixLine']     = { fg = c.info, underline = true },
    ['Debug']            = { fg = c.orange },
    ['debugPC']          = { fg = c.bg1, bg = c.green },
    ['debugBreakpoint']  = { fg = c.bg1, bg = c.red },
    ['ToolbarButton']    = { fg = c.bg1, bg = c.blue },
    ['PmenuSbar']        = { bg = c.bg2 },
    ['PmenuThumb']       = { bg = c.bg4 },
    ['Pmenu']            = { bg = c.bg2 },
    ['PmenuSel']         = { bg = c.bg4 },
    ['PmenuKindSel']     = { link = 'PmenuSel' },
    ['PmenuExtraSel']    = { link = 'PmenuSel' },
    ['WildMenu']         = { link = 'PmenuSel' },
    ['PmenuMatch']       = { bold = true },
    ['PmenuMatchSel']    = { bold = true },
    ['StatusLine']       = { fg = c.fg1, bg = c.bg3 },
    ['StatusLineNC']     = { fg = c.fg3, bg = c.bg2 },
    ['StatusLineTerm']   = { link = 'StatusLine' },
    ['StatusLineTermNC'] = { link = 'StatusLineNC' },
    ['WinBar']           = { link = 'StatusLine' },
    ['WinBarNC']         = { link = 'StatusLineNC' },
    ['TabLine']          = { fg = c.fg2, bg = c.bg3 },
    ['TabLineSel']       = { fg = c.fg1, bg = c.bg4 },
    ['TabLineFill']      = {},

    -- diff, spell, diagnostic
    ['Added']                      = { fg = c.green },
    ['Removed']                    = { fg = c.red },
    ['Changed']                    = { fg = c.blue },
    ['DiffAdd']                    = { fg = 'none', bg = c.dim_green },
    ['DiffChange']                 = { fg = 'none', bg = c.dim_blue },
    ['DiffDelete']                 = { fg = 'none', bg = c.dim_red },
    ['DiffText']                   = { fg = 'none', bg = c.dim_cyan },
    ['DiffAdded']                  = { fg = c.green },
    ['DiffChanged']                = { fg = c.blue },
    ['DiffRemoved']                = { fg = c.red },
    ['DiffDeleted']                = { fg = c.red },
    ['DiffFile']                   = { fg = c.cyan },
    ['DiffIndexLine']              = { fg = c.fg3 },
    ['SpellBad']                   = { fg = 'none', undercurl = true, sp = c.red },
    ['SpellCap']                   = { fg = 'none', undercurl = true, sp = c.orange },
    ['SpellLocal']                 = { fg = 'none', undercurl = true, sp = c.blue },
    ['SpellRare']                  = { fg = 'none', undercurl = true, sp = c.purple },
    ['DiagnosticError']            = { fg = c.red },
    ['DiagnosticWarn']             = { fg = c.orange },
    ['DiagnosticInfo']             = { fg = c.info },
    ['DiagnosticHint']             = { fg = c.special },
    ['DiagnosticOk']               = { fg = c.green },
    ['DiagnosticVirtualTextError'] = { fg = c.dim_red,    bg = blend(c.dim_red,    c.bg1, 0.1) },
    ['DiagnosticVirtualTextWarn']  = { fg = c.dim_orange, bg = blend(c.dim_orange, c.bg1, 0.1) },
    ['DiagnosticVirtualTextInfo']  = { fg = c.dim_cyan,   bg = blend(c.dim_cyan,   c.bg1, 0.1) },
    ['DiagnosticVirtualTextHint']  = { fg = c.dim_purple, bg = blend(c.dim_purple, c.bg1, 0.1) },
    ['DiagnosticVirtualTextOk']    = { fg = c.dim_green,  bg = blend(c.dim_green,  c.bg1, 0.1) },
    ['DiagnosticUnderlineError']   = { undercurl = true, sp = c.red },
    ['DiagnosticUnderlineWarn']    = { undercurl = true, sp = c.orange },
    ['DiagnosticUnderlineInfo']    = { undercurl = true, sp = c.info },
    ['DiagnosticUnderlineHint']    = { undercurl = true, sp = c.special },
    ['DiagnosticUnderlineOk']      = { undercurl = true, sp = c.green },
    ['DiagnosticUnnecessary']      = {},

    -- syntax
    ['String']         = { fg = c.strings },
    ['Character']      = { fg = c.strings },
    ['Tag']            = { fg = c.strings },
    ['Number']         = { fg = c.alt },
    ['Float']          = { fg = c.alt },
    ['Boolean']        = { fg = c.alt },
    ['Type']           = { fg = c.alt },
    ['TypeDef']        = { fg = c.alt },
    ['Structure']      = { fg = c.alt },
    ['StorageClass']   = { fg = c.alt },
    ['Constant']       = { fg = c.alt },
    ['Macro']          = { fg = c.alt, bold = true },
    ['PreProc']        = { fg = c.accent, bold = true },
    ['PreCondit']      = { fg = c.accent, bold = true },
    ['Include']        = { fg = c.accent, bold = true },
    ['Keyword']        = { fg = c.accent, bold = true },
    ['Define']         = { fg = c.accent, bold = true },
    ['Exception']      = { fg = c.accent, bold = true },
    ['Conditional']    = { fg = c.accent, bold = true },
    ['Repeat']         = { fg = c.accent, bold = true },
    ['Statement']      = { fg = c.accent, bold = true },
    ['Error']          = { fg = c.red, bold = true },
    ['Label']          = { link = 'Title' },
    ['Special']        = { fg = c.special },
    ['Identifier']     = { fg = c.fg1 },
    ['Variable']       = { fg = c.fg1 },
    ['Function']       = { fg = c.fg1 },
    ['Operator']       = { fg = c.fg1 },
    ['Delimiter']      = { fg = c.fg1 },
    ['SpecialChar']    = { fg = c.fg1 },
    ['Comment']        = { fg = c.comments },
    ['SpecialComment'] = { fg = c.comments },
    ['Todo']           = { fg = c.comments },
  }

  local treesitter = {
    ['@variable']           = common['Variable'],
    ['@variable.member']    = common['Variable'],
    ['@variable.parameter'] = common['Variable'],
    ['@property']           = common['Variable'],
    ['@variable.builtin']           = { italic = true }, -- `this`, `self`
    ['@variable.parameter.builtin'] = { italic = true }, -- `_`, `it`

    ['@constant']           = common['Constant'],
    ['@constant.builtin']   = common['Constant'],
    ['@constant.macro']     = common['Constant'],
    ['@label']              = common['Special'],

    ['@string']                = common['String'],
    ['@string.documentation']  = common['String'],
    ['@string.regexp']         = common['String'],
    ['@string.escape']         = common['String'],
    ['@string.special']        = common['String'],
    ['@string.special.symbol'] = common['String'],
    ['@string.special.path']   = common['String'],
    ['@string.special.url']    = { fg = c.strings, underline = true },
    ['@character']             = common['String'],

    ['@boolean']      = common['Boolean'],
    ['@number']       = common['Number'],
    ['@number.float'] = common['Float'],

    ['@type']            = common['Type'],
    ['@type.builtin']    = common['Type'],
    ['@type.definition'] = common['Type'],
    ['@constructor']     = common['Type'],
    ['@module']          = common['Type'],
    ['@module.builtin']  = common['Type'],

    ['@function']             = common['Function'],
    ['@function.builtin']     = common['Function'],
    ['@function.call']        = common['Function'],
    ['@function.macro']       = common['Function'],
    ['@function.method']      = common['Function'],
    ['@function.method.call'] = common['Function'],

    ['@keyword']                     = common['Keyword'],
    ['@keyword.coroutine']           = common['Keyword'],
    ['@keyword.function']            = common['Keyword'],
    ['@keyword.operator']            = common['Keyword'],
    ['@keyword.import']              = common['Keyword'],
    ['@keyword.type']                = common['Keyword'],
    ['@keyword.modifier']            = common['Keyword'],
    ['@keyword.repeat']              = common['Keyword'],
    ['@keyword.return']              = common['Keyword'],
    ['@keyword.debug']               = common['Keyword'],
    ['@keyword.exception']           = common['Keyword'],
    ['@keyword.conditional']         = common['Keyword'],
    ['@keyword.conditional.ternary'] = common['Keyword'],
    ['@keyword.directive']           = common['Keyword'],
    ['@keyword.directive.define']    = common['Keyword'],

    ['@operator']              = common['Operator'],
    ['@character.special']     = common['SpecialChar'],
    ['@punctuation.delimiter'] = common['Delimiter'],
    ['@punctuation.bracket']   = common['Delimiter'],
    ['@punctuation.special']   = common['Delimiter'],

    ['@attribute']           = common['Special'],
    ['@attribute.builtin']   = common['Special'],

    ['@comment']               = { fg = c.comments },
    ['@comment.documentation'] = { fg = c.comments },
    ['@comment.error']         = { fg = c.comments },
    ['@comment.warning']       = { fg = c.comments },
    ['@comment.todo']          = { fg = c.comments },
    ['@comment.note']          = { fg = c.comments },
    ['@comment.note.comment']          = { fg = c.comments },
    ['@punctuation.delimiter.comment'] = { fg = c.comments },

    ['@markup.link']       = { underline = true, fg = c.special },
    ['@markup.link.label'] = { underline = true, fg = c.special },
    ['@markup.link.url']   = { underline = true, fg = c.special },
    ['@markup.heading']    = { bold = true },
    ['@markup.heading.1']  = { bold = true, fg = c.special },
    ['@markup.heading.2']  = { bold = true, fg = c.info },
    ['@markup.heading.3']  = { bold = true, fg = c.alt },
    ['@markup.heading.4']  = { bold = true, fg = c.alt },
    ['@markup.heading.5']  = { bold = true, fg = c.alt },
    ['@markup.heading.6']  = { bold = true, fg = c.alt },

    ['@tag']           = { fg = c.alt },
    ['@tag.delimiter'] = { fg = c.alt },
    ['@tag.builtin']   = { fg = c.alt },
    ['@tag.attribute'] = { fg = c.fg1 },

    ['@diff.add']    = common['DiffAdded'],
    ['@diff.delete'] = common['DiffDeleted'],
    ['@diff.plus']   = common['DiffAdded'],
    ['@diff.minus']  = common['DiffDeleted'],
    ['@diff.delta']  = common['DiffChanged'],

    -- for some reason `constructor.lua` means curly braces
    ['@constructor.lua'] = common['Delimiter'],
  }

  local lsp = {
    ['@lsp.type.comment']                    = treesitter['@comment'],
    ['@lsp.type.enum']                       = treesitter['@type'],
    ['@lsp.type.enumMember']                 = treesitter['@constant'],
    ['@lsp.type.interface']                  = treesitter['@type'],
    ['@lsp.type.typeParameter']              = treesitter['@type'],
    ['@lsp.type.keyword']                    = treesitter['@keyword'],
    ['@lsp.type.namespace']                  = treesitter['@module'],
    ['@lsp.type.parameter']                  = treesitter['@variable.parameter'],
    ['@lsp.type.property']                   = treesitter['@property'],
    ['@lsp.type.variable']                   = treesitter['@variable'],
    ['@lsp.type.macro']                      = treesitter['@function.macro'],
    ['@lsp.type.method']                     = treesitter['@function.method'],
    ['@lsp.type.number']                     = treesitter['@number'],
    ['@lsp.type.generic']                    = treesitter['@type'],
    ['@lsp.type.builtinType']                = treesitter['@type.builtin'],
    ['@lsp.typemod.method.defaultLibrary']   = treesitter['@function'],
    ['@lsp.typemod.function.defaultLibrary'] = treesitter['@function'],
    ['@lsp.typemod.operator.injected']       = treesitter['@operator'],
    ['@lsp.typemod.string.injected']         = treesitter['@string'],
    ['@lsp.typemod.variable.injected']       = treesitter['@variable'],
    ['@lsp.typemod.variable.defaultLibrary'] = treesitter['@constant'],
    ['@lsp.typemod.variable.static']         = treesitter['@constant'],
  }

  local plugins = {
    ['MiniHipatternsFixme']   = { bold = true },
    ['MiniHipatternsHack']    = { bold = true },
    ['MiniHipatternsNote']    = { bold = true },
    ['MiniHipatternsTodo']    = { bold = true },

    ['MiniFilesTitleFocused'] = { fg = c.info },
    ['MiniFilesTitle']        = { fg = c.info },

    ['MiniPickBorderText']    = { fg = c.info },
    ['MiniPickPrompt']        = { fg = c.fg1 },
    ['MiniPickPromptCaret']   = { fg = c.fg1 },
    ['MiniPickPromptPrefix']  = { fg = c.fg1 },
    ['MiniPickMatchCurrent']  = common['CursorLine'],
    ['MiniPickMatchMarked']   = { fg = c.red },
    ['MiniPickMatchRanges']   = { fg = c.red },

    ['MiniTablineCurrent']         = { fg = c.fg1, bg = c.bg4 },
    ['MiniTablineVisible']         = { fg = c.fg2, bg = c.bg3 },
    ['MiniTablineHidden']          = { fg = c.fg2, bg = c.bg3 },
    ['MiniTablineModifiedCurrent'] = { fg = c.fg1, bg = c.bg4, italic = true },
    ['MiniTablineModifiedVisible'] = { fg = c.fg2, bg = c.bg3, italic = true },
    ['MiniTablineModifiedHidden']  = { fg = c.fg2, bg = c.bg3, italic = true },
  }

  local hl = vim.tbl_extend('error', common, treesitter, plugins, lsp)

  hl['LspDiagnosticsDefaultError']           = hl['DiagnosticError']
  hl['LspDiagnosticsDefaultWarning']         = hl['DiagnosticWarn']
  hl['LspDiagnosticsDefaultInformation']     = hl['DiagnosticInfo']
  hl['LspDiagnosticsDefaultHint']            = hl['DiagnosticHint']
  hl['LspDiagnosticsUnderlineError']         = hl['DiagnosticUnderlineError']
  hl['LspDiagnosticsUnderlineWarning']       = hl['DiagnosticUnderlineWarn']
  hl['LspDiagnosticsUnderlineInformation']   = hl['DiagnosticUnderlineInfo']
  hl['LspDiagnosticsUnderlineHint']          = hl['DiagnosticUnderlineHint']
  hl['LspDiagnosticsVirtualTextError']       = hl['DiagnosticVirtualTextError']
  hl['LspDiagnosticsVirtualTextWarning']     = hl['DiagnosticVirtualTextWarn']
  hl['LspDiagnosticsVirtualTextInformation'] = hl['DiagnosticVirtualTextInfo']
  hl['LspDiagnosticsVirtualTextHint']        = hl['DiagnosticVirtualTextHint']

  for group, opts in pairs(hl) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end

return M
