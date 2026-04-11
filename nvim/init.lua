-- =============================================================================
-- =====================   General   ===========================================
-- =============================================================================

-- clipboard
vim.opt.clipboard = 'unnamedplus'  -- enable system clipboard

-- completeopt
-- menuone   - pum even for a single match
-- noinstert - no text insterted until selection
-- noselect  - no auto selection
vim.opt.completeopt = 'menuone,noselect'

-- fill chars
-- use | for vertical split borders
-- no ~ for end-of-buffer lines.
vim.opt.fillchars:append({ vert = '|', eob = ' ' })

-- indentation
vim.opt.softtabstop = 2       -- number of spaces to replace tabs by
vim.opt.shiftwidth  = 2       -- number of spaces for autoindent
vim.opt.expandtab   = true    -- use spaces instead of tabs

-- miscellaneous
vim.opt.updatetime = 300      -- CursorHold autocmd triggers after x milliseconds

-- netrw
vim.g.netrw_dirhistmax = 0    -- no netrwhist file
vim.g.netrw_banner     = 0    -- no top comments

-- safety files
vim.opt.swapfile = false      -- do not create swap files
vim.opt.backup   = false      -- do not create backup files

-- searching
vim.opt.ignorecase = true     -- ignore case when searching
vim.opt.smartcase  = true     -- match any given captials in search

-- shortmess
-- a - all abbreviations
-- c - no 'match n of m' or 'the only match' messages
-- s - no 'search hit BOTTOM' messages
-- W - no [w] when writing a file
-- T - truncate long messages with '...'
-- I - no intro messages when starting vim
-- F - no prompt when opening multiple files
vim.opt.shortmess = 'acsWTIF'

-- splitting
vim.opt.splitbelow = true     -- vertical splits open below current window
vim.opt.splitright = true     -- horizontal splits open right of current window

-- statusline
-- %<         trim from here
-- %f         path+filename
-- %m         check modifi{ed,able}
-- %r         check readonly
-- %w         check preview window
-- %=         left/right separator
-- %l/%L,%c\  rownumber/total,colnumber
vim.opt.statusline = " %<%f %m %r %w %=%l/%L,%c "

-- visual
require("colors.xres")
vim.opt.linebreak = true      -- do not break words on wrap
vim.opt.list      = false     -- do not show characters at the end of lines
vim.opt.showcmd   = false     -- don't display partial commands in bottom right
vim.opt.showmode  = false     -- don't display mode (e.g. -- INSERT --)
vim.opt.pumheight = 30        -- limits popup menu height
vim.opt.scrolloff = 4         -- start scrolling 4 lines from the bottom
-- vim.opt.textwidth = 80        -- length to break lines
vim.opt.wrap      = true      -- spread long lines across multiple lines

-- wildmenu
vim.opt.wildignore = '*.o,*.pyc'


-- =============================================================================
-- =====================   Mappings   ==========================================
-- =============================================================================

vim.g.mapleader = ' '

-- easy escape to normal
vim.keymap.set('i', 'jj', '<ESC>')

-- move along visual lines, not numbered ones
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('n', '^', 'g^')
vim.keymap.set('n', '$', 'g$')
vim.keymap.set('v', 'j', 'gj')
vim.keymap.set('v', 'k', 'gk')
vim.keymap.set('v', '^', 'g^')
vim.keymap.set('v', '$', 'g$')

-- keep visual selections when indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- simplify moving across splits
vim.keymap.set('n', '<C-J>', '<C-W><C-J>')
vim.keymap.set('n', '<C-K>', '<C-W><C-K>')
vim.keymap.set('n', '<C-L>', '<C-W><C-L>')
vim.keymap.set('n', '<C-H>', '<C-W><C-H>')

-- clear highlights
vim.keymap.set('n', '<leader>h', ':nohls<CR>:<DEL>')


-- =============================================================================
-- =====================   Language Server   ===================================
-- =============================================================================

local new_window = function() vim.cmd('sp') end
local noop = function() end
local lsp_map = function(key, cmd, extra)
  vim.keymap.set('n', '<leader>l'..key, function() extra() cmd() end)
end
lsp_map('d', vim.lsp.buf.declaration, noop)
lsp_map('wd', vim.lsp.buf.declaration, new_window)
lsp_map('i', vim.lsp.buf.definition, noop)
lsp_map('wi', vim.lsp.buf.definition, new_window)
lsp_map('f', function() vim.lsp.buf.format { async = true } end, noop)
lsp_map('r', vim.lsp.buf.references, noop)
lsp_map('a', vim.lsp.buf.code_action, noop)
lsp_map('h', vim.lsp.buf.hover, noop)
lsp_map('n', vim.lsp.buf.rename, noop)

vim.lsp.enable({'clangd', 'rust_analyzer'})

-- automatically change the working path to the path of the current file
vim.api.nvim_create_autocmd({'BufNewFile', 'BufEnter'}, {
  pattern = '*',
  command = 'silent! lcd %:p:h'
})

-- diagnostics
vim.diagnostic.config({
  virtual_text = false,  -- disable inline diagnostics
  signs        = false,  -- disable signs
})

local diag_float_group =
    vim.api.nvim_create_augroup("DiagFloat", { clear = true })
vim.api.nvim_create_autocmd('CursorHold', {
  pattern  = '*',
  group    = diag_float_group,
  callback = function(args)
    vim.diagnostic.open_float()
  end
})
