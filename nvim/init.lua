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

-- save when file is readonly
map('c', 'w!!', 'execute "silent! write !sudo tee % >/dev/null" <bar> edit!')

map('c', 'W', 'w')

-- clear highlights
map('n', leader..'h', ':nohls<CR>')

-- pop-up menu navigation
map('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
map('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })


-- ===================== plugins
-- incsearch.vim
map('n', '/', '<Plug>(incsearch-forward)')
map('n', '?', '<Plug>(incsearch-backward)')
map('n', 'g/', '<Plug>(incsearch-stay)')

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
lsp_map('f', vim.lsp.buf.formatting, noop)
lsp_map('r', vim.lsp.buf.references, noop)
lsp_map('a', vim.lsp.buf.codeAction, noop)
lsp_map('h', vim.lsp.buf.hover, noop)

-- tagbar
map('n', leader..'t', ':TagbarToggle<CR><C-W>=')

-- telescope
map('n', leader..'ff', require'telescope.builtin'.fd)
map('n', leader..'fp',
  function()
    local folder = vim.lsp.buf.list_workspace_folders()[1]
    require'telescope.builtin'.fd{ cwd = folder }
  end)

-- vim-easymotion
map('n', leader..'w', '<Plug>(easymotion-bd-w)')
map('n', leader..'c', '<Plug>(easymotion-s)')

-- vim-easy-align
map('x', 'ga', '<Plug>(EasyAlign)')
map('n', 'ga', '<Plug>(EasyAlign)')


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
    ['<CR>'] = cmp.mapping.confirm({ select = false }),

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
    { name = 'cmdline' }
  })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp')
  .update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- ===================== debugger
map('n', leader..'dc', require'dap'.continue)
map('n', leader..'di', require'dap'.step_into)
map('n', leader..'do', require'dap'.step_out)
map('n', leader..'dv', require'dap'.step_over)
map('n', leader..'db', require'dap'.toggle_breakpoint)
map('n', leader..'dr', require'dap'.repl.open)
map('n', leader..'dt', require'dap'.run_to_cursor)

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

map('n', leader..'du', require'dapui'.toggle)


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
