local lsp = require('nvim_lsp')
local completion = require('completion')
local diagnostic = require('diagnostic')

local M = {}

-- TODO remove all instances of nvim_command

-- =============================================================================
-- =====================   General   ===========================================
-- =============================================================================

-- clipboard
vim.o.clipboard = 'unnamedplus'  -- enable system clipboard

-- completeopt
-- menuone   - pum even for a single match
-- noinstert - no text insterted until selection
-- noselect  - no auto selection
vim.o.completeopt = 'menuone,noinsert,noselect'

-- fill chars
-- use | for vertical split borders
-- no ~ for end-of-buffer lines.
vim.o.fillchars = vim.o.fillchars..'vert:|,eob: '

-- indentation
-- vim.o.softtabstop = 2       -- number of spaces to replace tabs by
-- vim.o.shiftwidth = 2        -- number of spaces for autoindent
-- vim.o.expandtab = true      -- use spaces instead of tabs
vim.api.nvim_command("set softtabstop=2")
vim.api.nvim_command("set shiftwidth=2")
vim.api.nvim_command("set expandtab")

-- miscellaneous
vim.api.nvim_command("colorscheme xres")
vim.o.hidden = true         -- hide file, don't close on file switch
vim.o.autoread = true       -- update buffer when file changed externally
vim.o.pumheight = 30        -- limits popup menu height
-- vim.o.textwidth = 80        -- length to break lines
vim.api.nvim_command("set textwidth=80")

-- safety files
vim.api.nvim_command("set noswapfile")
vim.api.nvim_command("set nobackup")
-- vim.o.noswapfile = true     -- do not create swap files
-- vim.o.nobackup = true       -- do not create backup files

-- scrolling
vim.o.scrolloff = 4         -- start scrolling 4 lines from the bottom

-- searching
vim.o.ignorecase = true     -- ignore case when searching
vim.o.smartcase = true      -- match any given captials in search

-- shortmess
-- a - all abbreviations
-- c - no 'match n of m' or 'the only match' messages
-- s - no 'search hit BOTTOM' messages
-- W - no [w] when writing a file
-- T - truncate long messages with '...'
-- I - no intro messages when starting vim
-- F - no prompt when opening multiple files
vim.o.shortmess = 'acsWTIF'

-- splitting
vim.o.splitbelow = true     -- vertical splits open below current window
vim.o.splitright = true     -- horizontal splits open right of current window

-- statusline
-- %{g:git}   git branch name
-- %<         trim from here
-- %f         path+filename
-- %m         check modifi{ed,able}
-- %r         check readonly
-- %w         check preview window
-- %=         left/right separator
-- %l/%L,%c\  rownumber/total,colnumber
vim.o.statusline = " %{g:git}%<%f %m %r %w %=%l/%L,%c "

-- visual
vim.api.nvim_command("set noshowcmd")
vim.api.nvim_command("set noshowmode")
-- vim.o.noshowcmd = true      -- don't display partial commands in bottom right
-- vim.o.noshowmode = true     -- don't display mode (e.g. -- INSERT --)

-- word wrapping
vim.o.wrap = true           -- spread long lines across multiple lines
vim.o.linebreak = true      -- do not break words on wrap
vim.api.nvim_command("set nolist")
-- vim.o.nolist = true         -- do not show characters at the end of lines

-- wildmenu
vim.o.wildignore = '*.o,*.pyc'


-- ===================== plugins
-- diagnostic-nvim
vim.g.diagnostic_show_sign = 0
vim.g.diagnostic_enable_virtual_text = 1
vim.g.diagnostic_virtual_text_prefix = ''

-- fzf.vim
vim.g.fzf_action = {
  ['ctrl-t'] = 'tab split',
  ['ctrl-x'] = 'split',
  ['ctrl-v'] = 'vsplit',
}

-- netrw
vim.g.netrw_dirhistmax = 0  -- no netrwhist file
vim.g.netrw_banner = 0      -- no top comments


-- =============================================================================
-- =====================   Autocmds   ==========================================
-- =============================================================================

-- automatically change the working path to the path of the current file
vim.api.nvim_command("autocmd BufNewFile,BufEnter * silent! lcd %:p:h")

vim.api.nvim_command("autocmd VimEnter * lua require'init'.get_root_dir()")

vim.api.nvim_command("autocmd BufEnter * lua require'completion'.on_attach()")
vim.api.nvim_command("autocmd BufEnter * lua require'init'.get_git_branch()")


-- =============================================================================
-- =====================   Functions   =========================================
-- =============================================================================

M.get_git_branch = function()
  local handle = io.popen([[
      git rev-parse --abbrev-ref HEAD 2> /dev/null \
      | sed "s/^/git:/" \
      | tr "\n" " " ]])
  vim.g.git = handle:read("*a")
  handle:close()
end


M.root_dir = ""
M.get_root_dir = function()
  local path = vim.api.nvim_exec("pwd", true)
  M.root_dir = lsp.rust_analyzer.document_config.default_config.root_dir(path)
end


-- =============================================================================
-- =====================   Mappings   ==========================================
-- =============================================================================

local leader = ' '
local map = vim.api.nvim_set_keymap

-- easy escape to normal
map('i', 'jj', '<ESC>', { noremap = true })

-- move along visual lines, not numbered ones
map('n', 'j', 'gj', { noremap = true })
map('n', 'k', 'gk', { noremap = true })
map('n', '^', 'g^', { noremap = true })
map('n', '$', 'g$', { noremap = true })
map('v', 'j', 'gj', { noremap = true })
map('v', 'k', 'gk', { noremap = true })
map('v', '^', 'g^', { noremap = true })
map('v', '$', 'g$', { noremap = true })

-- keep visual selections when indenting
map('v', '<', '<gv', {})
map('v', '>', '>gv', {})

-- simplify moving across splits
map('n', '<C-J>', '<C-W><C-J>', { noremap = true })
map('n', '<C-K>', '<C-W><C-K>', { noremap = true })
map('n', '<C-L>', '<C-W><C-L>', { noremap = true })
map('n', '<C-H>', '<C-W><C-H>', { noremap = true })

-- save when file is readonly
map('c', 'w!!', 'execute "silent! write !sudo tee % >/dev/null" <bar> edit!',
    { noremap = true })

-- clear highlights
map('n', leader..'h', ':nohls<CR>', { noremap = true, silent = true })

-- pop-up menu navigation
map('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]],
    { noremap = true, expr = true })
map('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]],
    { noremap = true, expr = true })


-- ===================== plugins
-- incsearch.vim
map('n', '/', '<Plug>(incsearch-forward)', {})
map('n', '?', '<Plug>(incsearch-backward)', {})
map('n', 'g/', '<Plug>(incsearch-stay)', {})

-- nvim-lsp
map('n', leader..'ld', '<cmd>lua vim.lsp.buf.declaration()<CR>',
    { noremap = true, silent = true })
map('n', leader..'lwd', '<cmd>sp<CR>:lua vim.lsp.buf.declaration()<CR>',
    { noremap = true, silent = true })
map('n', leader..'li', '<cmd>lua vim.lsp.buf.definition()<CR>',
    { noremap = true, silent = true })
map('n', leader..'lwi', '<cmd>sp<CR>:lua vim.lsp.buf.definition()<CR>',
    { noremap = true, silent = true })

-- tagbar
map('n', leader..'t', ':TagbarToggle<CR><C-W>=',
    { noremap = true, silent = true })

-- telescope
map('n', leader..'ff', [[:lua require'telescope.builtin'.fd{}<CR>]],
    { noremap = true, silent = true })
map('n', leader..'fp',
    ":lua require'telescope.builtin'.fd{ cwd = require'init'.root_dir }<CR>",
    { noremap = true, silent = true })

-- vim-easymotion
map('n', leader..'w', '<Plug>(easymotion-bd-w)', { silent = true })
map('n', leader..'c', '<Plug>(easymotion-s)',    { silent = true })

-- vim-easy-align
map('x', 'ga', '<Plug>(EasyAlign)', {})
map('n', 'ga', '<Plug>(EasyAlign)', {})


-- =============================================================================
-- =====================   Plugins   ===========================================
-- =============================================================================

-- ===================== language server
lsp.clangd.setup {  -- C++
  cmd = {'clangd', '--background-index', '--clang-tidy', '--log=error',
         '--pretty'};
  on_attach = function()
    completion.on_attach()
    diagnostic.on_attach()
  end;
}

lsp.jdtls.setup {  -- Java
  on_attach = function()
    completion.on_attach()
    diagnostic.on_attach()
  end;
}

lsp.metals.setup {  -- Scala
  on_attach = function()
    completion.on_attach()
    diagnostic.on_attach()
  end;
}

lsp.rust_analyzer.setup {  -- Rust
  settings = {
    cargo = {
      allFeatures = true;
    };
    checkOnSave = {
      allFeatures = true;
      command = "clippy";
      enable = true;
    };
  };
  on_attach = function()
    completion.on_attach()
    diagnostic.on_attach()
  end;
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = false
        }
      }
    }
  };
}


-- ===================== tree sitter
require('nvim-treesitter.configs').setup {
  highlight = { enable = true, },
  ensure_installed = 'all'
}


-- =============================================================================
-- =====================   Imports   ===========================================
-- =============================================================================

vim.api.nvim_command([[
if !empty(glob('~/.nvim.local.vim'))
  exe 'source' '~/.nvim.local.vim'
endif
]])


-- =============================================================================
-- =====================   Exports   ===========================================
-- =============================================================================

return M
