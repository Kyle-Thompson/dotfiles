local viml = vim.api.nvim_command

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
vim.opt.fillchars = vim.o.fillchars..'vert:|,eob: '

-- indentation
vim.opt.softtabstop = 2       -- number of spaces to replace tabs by
vim.opt.shiftwidth  = 2       -- number of spaces for autoindent
vim.opt.expandtab   = true    -- use spaces instead of tabs

-- miscellaneous
vim.opt.hidden     = true     -- hide file, don't close on file switch
vim.opt.autoread   = true     -- update buffer when file changed externally
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
vim.opt.textwidth = 80        -- length to break lines
vim.opt.wrap      = true      -- spread long lines across multiple lines

-- wildmenu
vim.opt.wildignore = '*.o,*.pyc'


-- =============================================================================
-- =====================   Mappings   ==========================================
-- =============================================================================

local leader = ' '
local map = vim.keymap.set

-- easy escape to normal
map('i', 'jj', '<ESC>')

-- move along visual lines, not numbered ones
map('n', 'j', 'gj')
map('n', 'k', 'gk')
map('n', '^', 'g^')
map('n', '$', 'g$')
map('v', 'j', 'gj')
map('v', 'k', 'gk')
map('v', '^', 'g^')
map('v', '$', 'g$')

-- keep visual selections when indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- simplify moving across splits
map('n', '<C-J>', '<C-W><C-J>')
map('n', '<C-K>', '<C-W><C-K>')
map('n', '<C-L>', '<C-W><C-L>')
map('n', '<C-H>', '<C-W><C-H>')

-- clear highlights
map('n', leader..'h', ':nohls<CR>:<DEL>')


-- ===================== plugins
-- nvim lsp
local new_window = function() viml ':sp' end
local noop = function() end
local lsp_map = function(key, cmd, extra)
  map('n', leader..'l'..key, function() extra() cmd() end)
end
lsp_map('d', vim.lsp.buf.declaration, noop)
lsp_map('wd', vim.lsp.buf.declaration, new_window)
lsp_map('i', vim.lsp.buf.definition, noop)
lsp_map('wi', vim.lsp.buf.definition, new_window)
lsp_map('f', function() vim.lsp.buf.format { async = true } end, noop)
lsp_map('r', vim.lsp.buf.references, noop)
lsp_map('a', vim.lsp.buf.codeAction, noop)
lsp_map('h', vim.lsp.buf.hover, noop)
lsp_map('n', vim.lsp.buf.rename, noop)

-- auto-pairs
require("nvim-autopairs").setup {}

-- vim-easymotion
map('n', leader..'w', '<Plug>(easymotion-bd-w)')
map('n', leader..'c', '<Plug>(easymotion-s)')


-- =============================================================================
-- =====================   Miscellaneous   =====================================
-- =============================================================================

-- automatically change the working path to the path of the current file
viml "autocmd BufNewFile,BufEnter * silent! lcd %:p:h"


-- =============================================================================
-- =====================   Plugins   ===========================================
-- =============================================================================

-- vim.lsp.enable('clangd')
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'cpp' },
  callback = function(args)
    vim.lsp.start({
      name = "clangd",
      cmd = { "clangd" },
      root_dir = vim.fs.dirname(
        vim.fs.find({ ".clangd", ".git" }, { upward = true })[1]
      ),
    })
  end
})

-- diagnostics
vim.diagnostic.config({
  virtual_text = false,  -- disable inline diagnostics
  signs = false,  -- disable signs
})
viml 'autocmd CursorHold * lua vim.diagnostic.open_float()'
