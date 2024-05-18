local lsp_zero = require('lsp-zero').preset({
  name = 'recommended',
  float_border = 'single'
})

local lspconfig = require('lspconfig')

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({ buffer = bufnr })

  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', function()
    vim.api.nvim_command('set eventignore=CursorHold')
    vim.lsp.buf.hover()
    vim.api.nvim_command('autocmd CursorMoved <buffer> ++once set eventignore=""')
  end, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
end)

-- see :help lsp-zero-guide:integrate-with-mason-nvim
-- to learn how to use mason.nvim with lsp-zero
require('mason').setup({})
require('mason-lspconfig').setup({
  handlers = {
    lsp_zero.default_setup,
  }
})

-- (Optional) Configure lua language server for neovim
lspconfig.lua_ls.setup(lsp_zero.nvim_lua_ls())

lspconfig.clangd.setup({})

lspconfig.rust_analyzer.setup{}

lsp_zero.ensure_installed({
  -- Replace these with whatever servers you want to install
  'pylsp',

  'clangd',

  'texlab',
})


-- Flutter and Dart

local dart_lsp = lsp_zero.build_options('dartls', {})

require('flutter-tools').setup({
  lsp = {
    capabilities = dart_lsp.capabilities
  },
  widget_guides = {
    enabled = true,
  },
})

-- Completion

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  formatting = {
    fields = { 'menu', 'abbr', 'kind' },
    format = require("tailwindcss-colorizer-cmp").formatter
  },

  preselect = cmp.PreselectMode.None,

  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
    ['<Tab>'] = cmp_action.luasnip_supertab(),

    ['<C-j>'] = cmp.mapping.scroll_docs(-4),
    ['<C-k>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = false,
    })
  },

  sources = {
    { name = 'async_path' },
    { name = 'nvim_lsp' },
    { name = 'buffer',    keyword_length = 3 },
    { name = 'luasnip',   keyword_length = 2 },
  },

  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})
