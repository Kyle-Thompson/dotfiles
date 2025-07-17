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
-- vim.o.completeopt = 'menuone,noinsert,noselect'
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

-- save when file is readonly
map('c', 'w!!', 'execute "silent! write !sudo tee % >/dev/null" <bar> edit!')

-- clear highlights
map('n', leader..'h', ':nohls<CR>')

-- pop-up menu navigation
map('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
map('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })


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

-- tagbar
map('n', leader..'t', ':TagbarToggle<CR><C-W>=')

-- auto-pairs
require("nvim-autopairs").setup {}

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


-- =============================================================================
-- =====================   Miscellaneous   =====================================
-- =============================================================================

-- automatically change the working path to the path of the current file
viml "autocmd BufNewFile,BufEnter * silent! lcd %:p:h"


-- =============================================================================
-- =====================   Plugins   ===========================================
-- =============================================================================

-- ===================== completion
-- local luasnip = require('luasnip')
-- local cmp = require'cmp'

-- cmp.setup({
--   snippet = {
--     expand = function(args) luasnip.lsp_expand(args.body) end,
--   },
--   mapping = {
--     ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
--     ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
--     ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
--     ['<C-e>'] = cmp.mapping({
--       i = cmp.mapping.abort(),
--       c = cmp.mapping.close(),
--     }),
--     ['<CR>'] = cmp.mapping.confirm({ select = false }),

--     -- consistent up nav in cmp-pum menu and normal mode
--     ["<C-j>"] = cmp.mapping(function(fallback)
--       if cmp.visible() then cmp.select_next_item() else fallback() end
--     end, {"i", "s"}),
--     ["<C-n>"] = cmp.mapping(function(fallback)
--       if cmp.visible() then cmp.select_next_item() else fallback() end
--     end, {"i", "s"}),

--     -- consistent down nav in cmp-pum menu and normal mode
--     ["<C-k>"] = cmp.mapping(function(fallback)
--       if cmp.visible() then cmp.select_prev_item() else fallback() end
--     end, {"i", "s"}),

--     -- tab through snippet targets
--     ["<Tab>"] = cmp.mapping(function(fallback)
--       if luasnip.expand_or_jumpable() then
--         luasnip.expand_or_jump()
--       else
--         fallback()
--       end
--     end, {"i", "s"}),

--     -- shift tab to reverse through snippet targets
--     ["<S-Tab>"] = cmp.mapping(function(fallback)
--       if luasnip.jumpable(-1) then luasnip.jump(-1) else fallback() end
--     end, {"i", "s"}),
--   },
--   sources = cmp.config.sources({
--     { name = 'nvim_lsp' },
--     { name = 'nvim_lua' },
--     { name = 'luasnip' },
--     { name = 'buffer' },
--     { name = 'path' },
--     -- { name = 'crates' },
--   })
-- })

-- -- Use buffer source for `/`
-- cmp.setup.cmdline('/', {
--   sources = { { name = 'buffer' } }
-- })

-- -- Use cmdline & path source for ':'
-- cmp.setup.cmdline(':', {
--   sources = cmp.config.sources({
--     { name = 'path' },
--     { name = 'cmdline' }
--   })
-- })

-- Setup lspconfig.
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- vim.lsp.config['clangd'] = {
--   cmd = {
--     'clangd',
--     '--background-index=false',
--     '--pch-storage=disk',
--     '--malloc-trim',
--     '--clang-tidy=false',
--     '-j=4'
--   };
-- }

vim.lsp.enable('clangd')

-- diagnostics
vim.diagnostic.config({
  virtual_text = false,  -- disable inline diagnostics
  signs = false,  -- disable signs
})
viml 'autocmd CursorHold * lua vim.diagnostic.open_float()'

-- ===================== tree sitter
-- require('nvim-treesitter.configs').setup {
--   auto_install = true,
--   highlight = {
--     enable = true,
--     additional_vim_regex_highlighting = false,
--   };
-- }

-- TODO: move this into ftplugin/cpp.lua
local comment_string_group = vim
  .api
  .nvim_create_augroup("comment_string", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = "c,cpp",
    command = [[setlocal commentstring=//\ %s]],
    group = comment_string_group,
})

-- ===================== telescope
-- require('telescope').setup{
--   defaults = {
--     -- Default configuration for telescope goes here:
--     -- config_key = value,
--     mappings = {
--       i = {
--         -- map actions.which_key to <C-h> (default: <C-/>)
--         -- actions.which_key shows the mappings for your picker,
--         -- e.g. git_{create, delete, ...}_branch for the git_branches picker
--         ["<C-h>"] = "which_key"
--       }
--     },
--     preview = false  -- TODO: revert
--   },
--   pickers = {
--     -- Default configuration for builtin pickers goes here:
--     -- picker_name = {
--     --   picker_config_key = value,
--     --   ...
--     -- }
--     -- Now the picker_config_key will be applied every time you call this
--     -- builtin picker
--   },
--   extensions = {
--     -- Your extension configuration goes here:
--     -- extension_name = {
--     --   extension_config_key = value,
--     -- }
--     -- please take a look at the readme of the extension you want to configure
--   }
-- }
