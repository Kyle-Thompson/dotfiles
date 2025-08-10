local pick = require('mini.pick')

-- TODO: trim down to only the necessary settings. most of these are default
-- TODO: do not show icons
pick.setup {
  -- Delays (in ms; should be at least 1)
  delay = {
    -- Delay between forcing asynchronous behavior
    async = 10,

    -- Delay between computation start and visual feedback about it
    busy = 50,
  },

  -- Keys for performing actions. See `:h MiniPick-actions`.
  mappings = {
    caret_left  = '<Left>',
    caret_right = '<Right>',

    choose            = '<CR>',
    choose_in_split   = '<C-x>',
    choose_in_tabpage = '<C-t>',
    choose_in_vsplit  = '<C-v>',
    choose_marked     = '<M-CR>',

    delete_char       = '<BS>',
    delete_char_right = '<Del>',
    delete_left       = '<C-u>',
    delete_word       = '<C-w>',

    mark     = '<C-x>',
    mark_all = '<C-a>',

    move_down  = '<C-n>',
    move_start = '<C-g>',
    move_up    = '<C-p>',

    paste = '<C-r>',

    refine        = '<C-Space>',
    refine_marked = '<M-Space>',

    scroll_down  = '<C-f>',
    scroll_left  = '<C-h>',
    scroll_right = '<C-l>',
    scroll_up    = '<C-b>',

    stop = '<Esc>',

    toggle_info    = '<S-Tab>',
    toggle_preview = '<Tab>',
  },

  -- General options
  options = {
    -- Whether to show content from bottom to top
    content_from_bottom = false,

    -- Whether to cache matches (more speed and memory on repeated prompts)
    use_cache = true,
  },

  -- Source definition. See `:h MiniPick-source`.
  source = {
    items = nil,
    name  = nil,
    cwd   = nil,

    match   = nil,
    show    = nil,
    preview = nil,

    choose        = nil,
    choose_marked = nil,
  },

  -- Window related options
  window = {
    -- Float window config (table or callable returning it)
    config = nil,

    -- String to use as caret in prompt
    prompt_caret = '▏',

    -- String to use as prefix in prompt
    prompt_prefix = '> ',
  },
}

vim.keymap.set('n', ' ff', pick.builtin.files)
vim.keymap.set('n', ' fp',
  function()
    local folder = vim.lsp.buf.list_workspace_folders()[1]
    if folder:find("/work/", 1, true) then
      require('mini.pick').builtin.cli({
        command = { 'fd', '--type', 'f', '--exclude', '3rd', '.', folder }
      })
    else
      -- TODO: replace with a direct call to `start`
      require('mini.pick').builtin.cli({
        command = { 'fd', '--type', 'f', '.', folder }
      })
    end
  end)
