
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

local function my_on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- copy default mappings here from defaults in next section
  --vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node,          opts('CD'))
  --vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer,     opts('Open: In Place'))
  ---
  -- OR use all default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- remove a default
  vim.keymap.del('n', '<C-k>', { buffer = bufnr })
  vim.keymap.del('n', '<C-x>', { buffer = bufnr })  -- remove default open horizaontal split
  vim.keymap.del('n', '<C-e>', { buffer = bufnr })  -- remove default open horizaontal split

  -- override a default
  vim.keymap.set('n', 'i',   api.node.open.horizontal,          opts('Open: Horizontal Split'))

  -- add your mappings
  --vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
  ---
end

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  on_attach = my_on_attach,
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
    highlight_diagnostics = true,
  },
  filters = {
    dotfiles = false,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    -- show_on_open_dirs = true,
    show_on_open_dirs = false,
    debounce_delay = 50,
    severity = {
      min = vim.diagnostic.severity.HINT,
      max = vim.diagnostic.severity.ERROR,
    },
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  update_focused_file = {
    enable = true,
--    update_root = true,
  },
  git = { ignore = false, show_on_open_dirs = false },

  --renderer = {
  --  highlight_git = true,
  --  icons = { show = { folder_arrow = false, git = false } },
  --},
})

-- Configure LSP through rust-tools.nvim plugin.
-- rust-tools will configure and enable certain LSP features for us.
-- See https://github.com/simrat39/rust-tools.nvim#configuration
local opts = {
  tools = {
    --autoSetHints = false,
    --runnables = {
    --  use_telescope = true,
    --},
    inlay_hints = {
      auto = false,
      show_parameter_hints = true,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
  
  --server = {
  --  -- on_attach is a callback called when the language server attachs to the buffer
  --  on_attach = on_attach,
  --  settings = {
  --    -- to enable rust-analyzer settings visit:
  --    -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
  --    ["rust-analyzer"] = {
  --      -- enable clippy on save
  --      checkOnSave = {
  --        command = "clippy",
  --      },
  --    },
  --  },
  --},
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

      -- Maximal width of the hover window. Nil means no max.
      max_width = nil,

      -- Maximal height of the hover window. Nil means no max.
      max_height = nil,

      -- whether the hover action window gets automatically focused
      -- default: false
      auto_focus = false,
    },
}

require("rust-tools").setup(opts)

require("crates").setup()

--local function open_nvim_tree()
--
--  -- open the tree
--  require("nvim-tree.api").tree.open()
--end
--vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })


--local lspconfig = require('lspconfig')
--lspconfig.clangd.setup({
--  --cmd = {'clangd', '--background-index', '--clang-tidy', '--log=verbose'},
--  cmd = {'clangd', '--background-index', '--clang-tidy', '--log=verbose', '--inlay-hints'},
--  
--  init_options = {
--    fallback_flags = { '-std=c++17' },
--  },
--})

--require("clangd_extensions.inlay_hints").setup_autocmd()
--require("clangd_extensions.inlay_hints").set_inlay_hints()

-- To disable syntax highlight from lsp
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil
  end,
});
