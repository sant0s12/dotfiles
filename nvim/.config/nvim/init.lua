vim.opt.autoindent 		= true
vim.opt.ignorecase		= true
vim.opt.smartcase 		= true
vim.opt.number 			= true
vim.opt.autochdir 		= true
vim.opt.smartindent 	= true
vim.opt.tabstop 		= 4
vim.opt.shiftwidth		= 4
vim.opt.listchars		= ""
vim.opt.clipboard		= "unnamedplus"
vim.opt.showmatch 		= false
vim.opt.relativenumber 	= true
vim.opt.errorbells 		= false
vim.opt.incsearch 		= true
vim.opt.backup 			= false
vim.opt.undofile 		= true
vim.opt.hlsearch 		= false
vim.opt.termguicolors 	= true
vim.opt.mouse			= "a"
vim.opt.updatetime		= 300 -- Trigger CursorHold after 300 ms
vim.opt.textwidth		= 100
vim.opt.colorcolumn		= "100"

vim.opt.completeopt		= {'menu', 'menuone', 'noselect'}

-- Avoid showing extra messages when using completion
vim.opt.shortmess:append("c")
-- For scala metals
vim.opt.shortmess:append("F")


-- Plug
----------------------------------------

local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.vim/plugged')

Plug 'neovim/nvim-lspconfig'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-omni'

-- Grammar check
Plug 'brymer-meneses/grammar-guard.nvim'
Plug 'williamboman/nvim-lsp-installer'

Plug 'simrat39/rust-tools.nvim'
Plug 'scalameta/nvim-metals'
Plug 'ray-x/go.nvim'
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})

Plug 'nvim-lua/plenary.nvim'

Plug 'lervag/vimtex'
Plug 'aspeddro/pandoc.nvim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'chrisbra/csv.vim'
Plug 'sedm0784/vim-you-autocorrect'

Plug 'mbbill/undotree'
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'gruvbox-community/gruvbox'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'chrisbra/SudoEdit.vim'
Plug 'bronson/vim-trailing-whitespace'

Plug 'tpope/vim-fugitive'

Plug 'ahmedkhalf/project.nvim'
Plug('junegunn/fzf', {['do'] = "fzf#install()"})
Plug 'junegunn/fzf.vim'

-- File explorer
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

-- Better word motions
Plug 'chaoren/vim-wordmotion'

-- Misc
Plug 'eandrju/cellular-automaton.nvim'

vim.call('plug#end')


-- Plugin settings
----------------------------------------

vim.g.airline_powerline_fonts = true

vim.g.indent_guides_guide_size = 1

vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_quickfix_open_on_warning = 0

vim.g.fzf_layout = { down = '~20%' }


-- Colorscheme
----------------------------------------

vim.cmd('colorscheme gruvbox')
vim.opt.background = 'dark'


-- Custom remaps
----------------------------------------

vim.g.mapleader = ' '

vim.keymap.set('n', '+', 			'<C-w>+')
vim.keymap.set('n', '-', 			'<C-w>-')

vim.keymap.set('n', '<leader>+', 	'<C-w>>')
vim.keymap.set('n', '<leader>-', 	'<C-w><')

vim.keymap.set('n', '<leader>h', 	':wincmd h<CR>')
vim.keymap.set('n', '<leader>j', 	':wincmd j<CR>')
vim.keymap.set('n', '<leader>k', 	':wincmd k<CR>')
vim.keymap.set('n', '<leader>l', 	':wincmd l<CR>')

vim.keymap.set('n', '<leader>s', 	':sp<CR>')
vim.keymap.set('n', '<leader>v', 	':vsp<CR>')

vim.keymap.set('n', 'tl', 			':tabnext<CR>')
vim.keymap.set('n', 'th', 			':tabprevious<CR>')
vim.keymap.set('n', '<leader>t', 	':tabnew<CR>')

vim.keymap.set('n', '<leader>u', 	':UndotreeToggle<CR>')

vim.keymap.set('n', '<F6>', 		':setlocal spell! spelllang=en_us <CR>')
vim.keymap.set('n', '<Enter>', 		'o<ESC>')

-- Shift-S for terminal in new tab
vim.keymap.set('n', '<S-s>', 		':tabnew | term<CR>')

-- Ctrl-S for terminal in new tab
vim.keymap.set('n', '<C-s>', 		':bel split | wincmd j | resize 8 | term<CR>')

-- Esc to exit terminal mode
vim.keymap.set('t', '<Esc>', 		'<C-\\><C-n>')

-- Goto previous/next diagnostic warning/error
vim.keymap.set('n', 'g[', 			vim.diagnostic.goto_prev, { silent = true })
vim.keymap.set('n', 'g]', 			vim.diagnostic.goto_next, { silent = true })

-- Lsp keybindings
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
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
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

vim.keymap.set('n', '<leader>e', 	':NvimTreeToggle<CR>')

vim.keymap.set('n', '<leader>gg', 	':Git<space>')
vim.keymap.set('n', '<leader>gs', 	':Git<CR>')
vim.keymap.set('n', '<leader>gc', 	':Git commit<CR>')
vim.keymap.set('n', '<leader>gd', 	':G diff<CR>')
vim.keymap.set('n', '<leader>ga', 	':G add<space>')
vim.keymap.set('n', '<leader>gp', 	':G push<CR>')
vim.keymap.set('n', '<leader>gP', 	':G pull<CR>')

vim.keymap.set('n', 'gl', 		    ':VimtexView<CR>')

vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>")

-- Autocmd
----------------------------------------

local configFiles = vim.api.nvim_create_augroup('configFiles', {})
vim.api.nvim_create_autocmd('BufWritePost', {
	pattern = '*/polybar/config',
	command = "call system('$XDG_CONFIG_HOME/polybar/launch.sh')",
	group = configFiles,
})
vim.api.nvim_create_autocmd('BufWritePost', {
	pattern = '*/i3/config',
	command = "call system('i3 restart')",
	group = configFiles,
})

vim.api.nvim_create_autocmd('CursorHold', {
	pattern = '*',
	callback = function() vim.diagnostic.open_float(nil, { focusable = false }) end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
	pattern = '<buffer>',
	callback = function() vim.lsp.buf.format() end,
})

local vimtexConfig = vim.api.nvim_create_augroup('vimtexConfig', {})
vim.api.nvim_create_autocmd('User', {
	pattern = 'VimtexEventQuit',
	command = 'call vimtex#compiler#clean(0)',
	group = vimtexConfig,
})

local lspMetals = vim.api.nvim_create_augroup('lspMetals', {})
vim.api.nvim_create_autocmd('Filetype', {
	pattern = 'scala, sbt',
	callback = function() require('metals').initialize_or_attach(metals_config) end,
	group = lspMetals,
})

-- Close term if the program run without error
vim.api.nvim_create_autocmd('TermClose', {
	pattern = '*',
	command = "if !v:event.status | exe 'bdelete! '..expand('<abuf>') | endif",
})

-- Start terminal in insert mode
vim.api.nvim_create_autocmd('TermOpen', {
	pattern = '*',
	command = 'startinsert',
})

-- Close quickfixlist on buffer close
local qfClose = vim.api.nvim_create_augroup('qfClose', {})
vim.api.nvim_create_autocmd('WinEnter', {
	pattern = '*',
	command = "if winnr('$') == 1 && &buftype == 'quickfix'|q|endif",
})

-- LSP
----------------------------------------
local lsp_installer = require("nvim-lsp-installer").setup({
  ui = {
         icons = {
             server_installed = "✓",
             server_pending = "➜",
             server_uninstalled = "✗"
         }
  }
})

local nvim_lsp = require'lspconfig'

require("grammar-guard").init()
nvim_lsp.grammar_guard.setup({
    cmd = { '/home/santos/.local/share/nvim/lsp_servers/ltex/ltex-ls/bin/ltex-ls' },
    settings = {
		ltex = {
			enabled = { "latex", "tex", "bib", "markdown" },
			language = "en",
			diagnosticSeverity = "information",
			setenceCacheSize = 2000,
			additionalRules = {
				enablePickyRules = true,
				motherTongue = "en",
			},
			trace = { server = "verbose" },
			dictionary = {},
			disabledRules = {en = {"TOO_LONG_SENTENCE"}},
			hiddenFalsePositives = {},
		},
	},
})

nvim_lsp.texlab.setup{
  on_attach = on_attach,
}

nvim_lsp.pylsp.setup{
  on_attach = on_attach,
  settings = {
     formatCommand = {"black"},
     pylsp = {
       plugins = {
         black = {
           enabled = true
         },
         pycodestyle = {
            maxLineLength = 100
         },
       }
     }
  }
}

nvim_lsp.clangd.setup{
  on_attach = on_attach
}

require('rust-tools').setup{
  tools = { -- rust-tools options
      autoSetHints = true,
  },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
  server = {
      -- on_attach is a callback called when the language server attachs to the buffer
      -- on_attach = on_attach,
      on_attach = on_attach,
      settings = {
          -- to enable rust-analyzer settings visit:
          -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
          ["rust-analyzer"] = {
              -- enable clippy on save
              checkOnSave = {
                  command = "clippy"
              },
          }
      }
  },
}

require 'go'.setup({
  goimport = 'gopls', -- if set to 'gopls' will use golsp format
  gofmt = 'gopls', -- if set to gopls will use golsp format
  max_line_len = 120,
  tag_transform = false,
  test_dir = '',
  comment_placeholder = '   ',
  lsp_cfg = true, -- false: use your own lspconfig
  lsp_keymaps = false,
  lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
  lsp_on_attach = true, -- use on_attach from go.nvim
  dap_debug = true,
})


local cmp = require'cmp'
cmp.setup({
  preselect = cmp.PreselectMode.None,
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-j>'] = cmp.mapping.scroll_docs(-4),
    ['<C-k>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'omni' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})

metals_config = require("metals").bare_config()

metals_config.settings = {
  	showImplicitArguments = true,
  	excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
	serverVersion = "latest.snapshot"
}

metals_config.root_patterns = {'.project_nvim'}

local capabilities = vim.lsp.protocol.make_client_capabilities()
metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- nvim-tree
----------------------------------------
require"nvim-tree".setup{
	view = {
		preserve_window_proportions = true,
		width = 25,
		adaptive_size = true,
		mappings = {
			custom_only = true,
			list = {
				{ key = "g?",                            	action = "" },
				{ key = "?",                             	action = "toggle_help" },
				{ key = ".",								action = "toggle_dotfiles" },
				{ key = { "<CR>", "o", "<2-LeftMouse>" }, 	action = "edit" },
				{ key = "q",                              	action = "close" },
				{ key = "n",                              	action = "create" },
    			{ key = "dD",                              	action = "remove" },
    			{ key = "dT",                              	action = "trash" },
    			{ key = "a",                              	action = "rename" },
				{ key = "dd",                              	action = "cut" },
    			{ key = "yy",                              	action = "copy" },
    			{ key = "yn",                              	action = "copy_name" },
    			{ key = "yp",                              	action = "copy_path" },
    			{ key = "p",                              	action = "paste" },
    			{ key = "t",                              	action = "tabnew" },
    			{ key = "s",                              	action = "split" },
    			{ key = "v",                              	action = "vsplit" },
			}
		}
	},
	trash = {
    	cmd = "trash-put",
    	require_confirm = true,
  	},
	filters = {
		dotfiles = true,
	},
	actions = {
		open_file = {
			quit_on_open = true,
		}
	},
}


-- project_nvim
----------------------------------------
require("project_nvim").setup {
	patterns = {".project_nvim", ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
}
