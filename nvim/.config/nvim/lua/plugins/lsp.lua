-- (Optional) Configure lua language server for neovim
vim.lsp.enable("lua_ls")

vim.lsp.enable("clangd")

vim.lsp.enable("rust_analyzer")

vim.lsp.enable("texlab")

vim.lsp.enable("svelte")

-- Completion

local cmp = require('cmp')
local luasnip = require("luasnip")

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
    -- ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
    -- ['<Tab>'] = cmp_action.luasnip_supertab(),

    ['<C-j>'] = cmp.mapping.scroll_docs(-4),
    ['<C-k>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.close(),
	['<CR>'] = cmp.mapping(function(fallback)
        if cmp.visible() and cmp.get_active_entry() then
            if luasnip.expandable() then
                luasnip.expand()
            else
                cmp.confirm({
                    select = true,
                })
            end
        else
            fallback()
        end
    end),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.locally_jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
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
