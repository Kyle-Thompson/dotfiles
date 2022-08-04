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
lsp_map('n', vim.lsp.buf.rename, noop)

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
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),

    -- consistent up nav in cmp-pum menu and normal mode
    ["<C-j>"] = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_next_item() else fallback() end
    end, {"i", "s"}),
    ["<C-n>"] = cmp.mapping(function(fallback)
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
    { name = 'crates' },
  })
})

-- Use buffer source for `/`
cmp.setup.cmdline('/', {
  sources = { { name = 'buffer' } }
})

-- Use cmdline & path source for ':'
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
    ['rust-analyzer'] = {
      assist = {
        importGranularity = 'module',
        importPrefix = 'self',
      },
      checkOnSave = {
        enable = true,
        overrideCommand = {
          'cargo',
          'clippy',
          '--message-format=json',
          '--all-targets',
          '--all-features',
          '--',
          '-Dclippy::all',
          '-Dclippy::pedantic',
          '-Aclippy::module_name_repetitions'
        },
      },
      cargo = {
        loadOutDirsFromCheck = true,
        allFeatures = true,
      },
      completion = {
        addCallParanthesis = false,
        snippets = nil,
      },
      -- TODO
      -- diagnostics = {
      --   disabled = {'inactive-code'},
      -- }
    }
  },
  capabilities = capabilities,
}

viml "packadd crates.nvim"
local crate_opts = {
  smart_insert = true,
  insert_closing_quote = true,
  avoid_prerelease = true,
  autoload = true,
  autoupdate = true,
  loading_indicator = true,
  date_format = "%Y-%m-%d",
  notification_title = "Crates",
  disable_invalid_feature_diagnostic = false,
  text = {
    loading = "  ...loading",
    version = "",
    prerelease = "  pre:%s",
    yanked = "  y:%s",
    nomatch = "  No match",
    upgrade = "  u:%s",
    error = "  Error fetching crate",
  },
  highlight = {
    loading = "CratesNvimLoading",
    version = "CratesNvimVersion",
    prerelease = "CratesNvimPreRelease",
    yanked = "CratesNvimYanked",
    nomatch = "CratesNvimNoMatch",
    upgrade = "CratesNvimUpgrade",
    error = "CratesNvimError",
  },
  popup = {
    autofocus = false,
    copy_register = '"',
    style = "minimal",
    border = "none",
    show_version_date = false,
    show_dependency_version = true,
    max_height = 30,
    min_width = 20,
    padding = 1,
    text = {
      title = "# %s",
      pill_left = "",
      pill_right = "",
      created_label = "created        ",
      updated_label = "updated        ",
      downloads_label = "downloads      ",
      homepage_label = "homepage       ",
      repository_label = "repository     ",
      documentation_label = "documentation  ",
      crates_io_label = "crates.io      ",
      categories_label = "categories     ",
      keywords_label = "keywords       ",
      prerelease = "%s pre-release",
      yanked = "%s yanked",
      enabled = "* s",
      transitive = "~ s",
      optional = "? %s",
      loading = " ...",
    },
    highlight = {
      title = "CratesNvimPopupTitle",
      pill_text = "CratesNvimPopupPillText",
      pill_border = "CratesNvimPopupPillBorder",
      description = "CratesNvimPopupDescription",
      created_label = "CratesNvimPopupLabel",
      created = "CratesNvimPopupValue",
      updated_label = "CratesNvimPopupLabel",
      updated = "CratesNvimPopupValue",
      downloads_label = "CratesNvimPopupLabel",
      downloads = "CratesNvimPopupValue",
      homepage_label = "CratesNvimPopupLabel",
      homepage = "CratesNvimPopupUrl",
      repository_label = "CratesNvimPopupLabel",
      repository = "CratesNvimPopupUrl",
      documentation_label = "CratesNvimPopupLabel",
      documentation = "CratesNvimPopupUrl",
      crates_io_label = "CratesNvimPopupLabel",
      crates_io = "CratesNvimPopupUrl",
      categories_label = "CratesNvimPopupLabel",
      keywords_label = "CratesNvimPopupLabel",
      version = "CratesNvimPopupVersion",
      prerelease = "CratesNvimPopupPreRelease",
      yanked = "CratesNvimPopupYanked",
      version_date = "CratesNvimPopupVersionDate",
      feature = "CratesNvimPopupFeature",
      enabled = "CratesNvimPopupEnabled",
      transitive = "CratesNvimPopupTransitive",
      dependency = "CratesNvimPopupDependency",
      optional = "CratesNvimPopupOptional",
      dependency_version = "CratesNvimPopupDependencyVersion",
      loading = "CratesNvimPopupLoading",
    },
    keys = {
      hide = { "q", "<esc>" },
      open_url = { "<cr>" },
      select = { "<cr>" },
      select_alt = { "s" },
      toggle_feature = { "<cr>" },
      copy_value = { "yy" },
      goto_item = { "gd", "K", "<C-LeftMouse>" },
      jump_forward = { "<c-i>" },
      jump_back = { "<c-o>", "<C-RightMouse>" },
    },
  },
  src = {
    insert_closing_quote = true,
    text = {
      prerelease = "  pre-release ",
      yanked = "  yanked ",
    },
    coq = {
      enabled = false,
      name = "Crates",
    },
  },
}
require('crates').setup(crate_opts)

local opts = {
  tools = { -- rust-tools options
    autoSetHints = false,

    -- whether to show hover actions inside the hover window
    hover_with_actions = true,

    -- how to execute terminal commands (termopen / quickfix)
    executor = require("rust-tools/executors").termopen,

    -- callback to execute once rust-analyzer is done initializing the workspace
    -- The callback receives one parameter indicating the `health` of the server: "ok" | "warning" | "error"
    on_initialized = nil,

    -- These apply to the default RustSetInlayHints command
    inlay_hints = {
      only_current_line = true,

      -- Event which triggers a refersh of the inlay hints
      only_current_line_autocmd = "CursorHold",

      -- whether to show parameter hints with the inlay hints or not
      show_parameter_hints = true,

      -- show variable name before inlay type hints
      show_variable_name = false,

      -- prefix for parameter hints
      parameter_hints_prefix = "<- ",

      -- prefix for all the other hints (type, chaining)
      other_hints_prefix = "=> ",

      -- whether to align to the lenght of the longest line in the file
      max_len_align = false,

      -- padding from the left if max_len_align is true
      max_len_align_padding = 1,

      -- whether to align to the extreme right or not
      right_align = false,

      -- padding from the right if right_align is true
      right_align_padding = 7,

      -- The color of the hints
      highlight = "Comment",
    },

    -- options same as lsp hover / vim.lsp.util.open_floating_preview()
    hover_actions = {
      -- the border that is used for the hover window
      -- see vim.api.nvim_open_win()
      border = {
        { "╭", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╮", "FloatBorder" },
        { "│", "FloatBorder" },
        { "╯", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╰", "FloatBorder" },
        { "│", "FloatBorder" },
      },

      -- whether the hover action window gets automatically focused
      auto_focus = false,
    },
  },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
  -- server = {
  --   -- standalone file support
  --   -- setting it to false may improve startup time
  --   standalone = true,
  -- }, -- rust-analyer options

  -- debugging stuff
  -- dap = {
  --   adapter = {
  --     type = "executable",
  --     command = "lldb-vscode",
  --     name = "rt_lldb",
  --   },
  -- },
}

require('rust-tools').setup(opts)

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

local f = io.open('$HOME/.dotfiles/nvim/local.lua', 'r')
if f ~= nil then
  require('local')
  io.close(f)
end
