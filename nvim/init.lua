local lsp = require('lspconfig')

local viml = vim.api.nvim_command
local opt = vim.opt

-- =============================================================================
-- =====================   General   ===========================================
-- =============================================================================

-- clipboard
opt.clipboard = 'unnamedplus'  -- enable system clipboard

-- completeopt
-- menuone   - pum even for a single match
-- noinstert - no text insterted until selection
-- noselect  - no auto selection
-- vim.o.completeopt = 'menuone,noinsert,noselect'
opt.completeopt = 'menuone,noselect'

-- fill chars
-- use | for vertical split borders
-- no ~ for end-of-buffer lines.
opt.fillchars = vim.o.fillchars..'vert:|,eob: '

-- indentation
opt.softtabstop = 2       -- number of spaces to replace tabs by
opt.shiftwidth = 2        -- number of spaces for autoindent
opt.expandtab = true      -- use spaces instead of tabs

-- miscellaneous
opt.hidden = true         -- hide file, don't close on file switch
opt.autoread = true       -- update buffer when file changed externally
opt.updatetime = 300      -- CursorHold autocmd triggers after x milliseconds

-- netrw
vim.g.netrw_dirhistmax = 0  -- no netrwhist file
vim.g.netrw_banner = 0      -- no top comments

-- safety files
opt.swapfile = false      -- do not create swap files
opt.backup = false        -- do not create backup files

-- searching
opt.ignorecase = true     -- ignore case when searching
opt.smartcase = true      -- match any given captials in search

-- shortmess
-- a - all abbreviations
-- c - no 'match n of m' or 'the only match' messages
-- s - no 'search hit BOTTOM' messages
-- W - no [w] when writing a file
-- T - truncate long messages with '...'
-- I - no intro messages when starting vim
-- F - no prompt when opening multiple files
opt.shortmess = 'acsWTIF'

-- splitting
opt.splitbelow = true     -- vertical splits open below current window
opt.splitright = true     -- horizontal splits open right of current window

-- statusline
-- %<         trim from here
-- %f         path+filename
-- %m         check modifi{ed,able}
-- %r         check readonly
-- %w         check preview window
-- %=         left/right separator
-- %l/%L,%c\  rownumber/total,colnumber
opt.statusline = " %<%f %m %r %w %=%l/%L,%c "

-- visual
viml "colorscheme xres"
opt.linebreak = true      -- do not break words on wrap
opt.list = false          -- do not show characters at the end of lines
opt.showcmd = false       -- don't display partial commands in bottom right
opt.showmode = false      -- don't display mode (e.g. -- INSERT --)
opt.pumheight = 30        -- limits popup menu height
opt.scrolloff = 4         -- start scrolling 4 lines from the bottom
opt.textwidth = 80        -- length to break lines
opt.wrap = true           -- spread long lines across multiple lines

-- wildmenu
opt.wildignore = '*.o,*.pyc'


-- =============================================================================
-- =====================   Mappings   ==========================================
-- =============================================================================

local leader = ' '
local map = vim.api.nvim_set_keymap
local nmap = function(key, command)
  map('n', key, command, { noremap = true, silent = true })
end

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

map('c', 'W', 'w', { noremap = true })

-- clear highlights
nmap(leader..'h', ':nohls<CR>')

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

-- nvim lsp
local lsp_map = function(key, cmd, new_window)
  local window = function() return new_window and '<cmd>sp<CR>' or '' end
  nmap(leader..'l'..key, window()..'<cmd>lua vim.lsp.buf.'..cmd..'()<CR>')
end
lsp_map('d', 'declaration')
lsp_map('wd', 'declaration', true)
lsp_map('i', 'definition')
lsp_map('wi', 'definition', true)
lsp_map('f', 'formatting')
lsp_map('r', 'references')
lsp_map('a', 'codeAction')
lsp_map('h', 'hover')

-- tagbar
map('n', leader..'t', ':TagbarToggle<CR><C-W>=',
    { noremap = true, silent = true })

-- telescope
map('n', leader..'ff', [[:lua require'telescope.builtin'.fd{}<CR>]],
    { noremap = true, silent = true })
map('n', leader..'fp',
    -- is there a more efficient way to do this than calling the function every
    -- time?
    ":lua require'telescope.builtin'.fd{ cwd = vim.lsp.buf.list_workspace_folders()[1] }<CR>",
    { noremap = true, silent = true })

-- vim-easymotion
map('n', leader..'w', '<Plug>(easymotion-bd-w)', { silent = true })
map('n', leader..'c', '<Plug>(easymotion-s)',    { silent = true })

-- vim-easy-align
map('x', 'ga', '<Plug>(EasyAlign)', {})
map('n', 'ga', '<Plug>(EasyAlign)', {})


-- =============================================================================
-- =====================   Miscellaneous   =====================================
-- =============================================================================

-- automatically change the working path to the path of the current file
viml "autocmd BufNewFile,BufEnter * silent! lcd %:p:h"


-- =============================================================================
-- =====================   Plugins   ===========================================
-- =============================================================================

-- ===================== completion
local luasnip = require('luasnip')
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable,
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),

    -- consistent up nav in cmp-pum menu and normal mode
    ["<C-j>"] = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_next_item() else fallback() end
    end, {"i", "s"}),

    -- consistent down nav in cmp-pum menu and normal mode
    ["<C-k>"] = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_prev_item() else fallback() end
    end, {"i", "s"}),

    -- tab through snippet targets
    ["<Tab>"] = cmp.mapping(function(fallback)
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, {"i", "s"}),

    -- shift tab to reverse through snippet targets
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then luasnip.jump(-1) else fallback() end
    end, {"i", "s"}),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = { { name = 'buffer' } }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' },
  -- }, {
    { name = 'cmdline' }
  })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- ===================== debugger
local dap_map = function(key, cmd)
  nmap(leader..'d'..key, "<cmd>lua require'dap'."..cmd.."()<CR>")
end
dap_map('c', "continue")
dap_map('i', "step_into")
dap_map('o', "step_out")
dap_map('v', "step_over")
dap_map('b', "toggle_breakpoint")
dap_map('r', "repl.open")
dap_map('t', "run_to_cursor")

local dapui = require('dapui')
dapui.setup({
  icons = {
    expanded = 'v',
    collapsed = '>'
  },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = {"<CR>"},
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
  },
  sidebar = {
    open_on_start = true,
    elements = {
      -- You can change the order of elements in the sidebar
      "scopes",
      "breakpoints",
      "stacks",
      "watches"
    },
    width = 40,
    position = "left" -- Can be "left" or "right"
  },
  tray = {
    open_on_start = true,
    elements = { "repl" },
    height = 10,
    position = "bottom"
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil   -- Floats will be treated as percentage of your screen.
  }
})

nmap(leader..'du', "<cmd>lua require'dapui'.toggle()<CR>")


-- ===================== language server
lsp.clangd.setup {
  cmd = {'clangd', '--background-index', '--clang-tidy'};
  capabilities = capabilities;
}

lsp.pylsp.setup{
  capabilities = capabilities;
}

lsp.rust_analyzer.setup {
  settings = {
    ["rust-analyzer"] = {
      assist = {
        importGranularity = "module",
        importPrefix = "by_self",
      },
      checkOnSave = {
        allFeatures = true;
        overrideCommand = { 'cargo', 'clippy', '--message-format=json',
          '--all-targets', '--all-features', '--', '-Dclippy::all',
          '-Dclippy::pedantic' };
        enable = true;
      };
      cargo = {
        loadOutDirsFromCheck = true,
        allFeatures = true,
      },
      procMacro = {
        enable = true
      },
    }
  };
  capabilities = capabilities;
}

lsp.tsserver.setup{
  cmd = { 'typescript-language-server', '--stdio' };
}

local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

-- TODO: use some way of getting home dir. this isn't portable
local sumneko_root_path = '/home/kyle/pkg/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path,
      },
      diagnostics = {
        -- get the language server to recognize the 'vim' global
        globals = {'vim'},
      },
      workspace = {
        -- make the server aware of neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

-- diagnostics
vim.diagnostic.config({
  virtual_text = false,  -- disable inline diagnostics
  signs = false,  -- disable signs
})
viml 'autocmd CursorHold * lua vim.diagnostic.open_float()'

-- ===================== tree sitter
require('nvim-treesitter.configs').setup {
  highlight = { enable = true; };
}


-- =============================================================================
-- =====================   Imports   ===========================================
-- =============================================================================

viml [[
if !empty(glob('~/.nvim.local.vim'))
  exe 'source' '~/.nvim.local.vim'
endif
]]
