syntax on
filetype plugin on

set autoindent
set ignorecase
set smartcase
set number
set autochdir
set smartindent
set tabstop=4
set shiftwidth=4
set listchars=""
set clipboard=unnamedplus
set noshowmatch
set relativenumber
set noerrorbells
set incsearch
set nobackup
set undofile
set nohlsearch
set termguicolors
set mouse=a
set updatetime=300 " Trigger CursorHold after 300 ms
set textwidth=100
set colorcolumn=100

set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c
" For scala metals
set shortmess-=F

" Cursor shapes in different modes
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"


" Plug
" ==================================================

call plug#begin('~/.vim/plugged')

Plug 'neovim/nvim-lspconfig'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/vim-vsnip'

Plug 'simrat39/rust-tools.nvim'
Plug 'scalameta/nvim-metals'

Plug 'nvim-lua/plenary.nvim'

Plug 'lervag/vimtex'
Plug 'vim-pandoc/vim-pandoc'
Plug 'dhruvasagar/vim-table-mode'
Plug 'chrisbra/csv.vim'
Plug 'sedm0784/vim-you-autocorrect'

Plug 'mbbill/undotree'
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'gruvbox-community/gruvbox'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'chrisbra/SudoEdit.vim'

Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" File explorer
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

let g:airline_powerline_fonts = 1

let g:indent_guides_guide_size = 1

let g:pandoc#command#autoexec_on_writes = 1
let g:pandoc#command#autoexec_command = "Pandoc pdf"
let g:pandoc#command#latex_engine = "pdflatex"

let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_open_on_warning = 0

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_symbols.linenr=''

let g:fzf_layout = { 'down': '~20%' }
let g:rooter_patterns = ['.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'package.json', 'build.sbt', '.rooter']

call plug#end()


" Colorscheme
" ==================================================

colorscheme gruvbox
set background=dark
set t_ut= "disable the Background Color Erase that messes with some color schemes


" Custom remaps
" ==================================================

let mapleader=" "

map + <C-w>+
map - <C-w>-
map <leader>+ <C-w>>
map <leader>- <C-w><

map <leader>h :wincmd h<CR>
map <leader>j :wincmd j<CR>
map <leader>k :wincmd k<CR>
map <leader>l :wincmd l<CR>

map <leader>s :sp<CR>
map <leader>v :vsp<CR>

nmap tl :tabnext<CR>
nmap th :tabprevious<CR>
nmap <leader>t :tabnew<CR>

nmap <leader>u :UndotreeToggle<CR>

map <F6> :setlocal spell! spelllang=en_us <CR>
map <Enter> o<ESC>

nmap zU <Plug>VimyouautocorrectUndo

" Compile and run C++
map <F8> :w <CR> :!clear && g++ % -o '%:r' && ./'%:r' <CR>

" Shift-S for terminal
nmap <S-s> :te<CR>i

"To map <Esc> to exit terminal-mode: >
tnoremap <Esc><Esc> <C-\><C-n>:q<CR>

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[    <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> g]    <cmd>lua vim.diagnostic.goto_next()<CR>

"user Code action
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>

nnoremap <leader>e 	:NvimTreeToggle<CR>

" Autocmd
" ==================================================

augroup configFiles
	autocmd!
	autocmd BufWritePost $XDG_CONFIG_HOME/polybar/config call system('$XDG_CONFIG_HOME/polybar/launch.sh')
	autocmd BufWritePost $XDG_CONFIG_HOME/i3/config call system('i3 restart')
augroup end

" Show diagnostic popup on cursor hover
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })

autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()

augroup vimtex_config
        autocmd!
        autocmd User VimtexEventQuit call vimtex#compiler#clean(0)
augroup END

if has('nvim-0.5')
  augroup lsp
    au!
    au FileType scala,sbt lua require('metals').initialize_or_attach(metals_config)
  augroup end
endif

" LSP
" ==================================================

" Configure LSP through rust-tools.nvim plugin.
" rust-tools will configure and enable certain LSP features for us.
" See https://github.com/simrat39/rust-tools.nvim#configuration
lua <<EOF
local nvim_lsp = require'lspconfig'

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
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

require('rust-tools').setup(opts)
EOF

:lua require'lspconfig'.texlab.setup{}

" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
lua <<EOF
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
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})
EOF

lua <<EOF
metals_config = require("metals").bare_config()

-- Example of settings
metals_config.settings = {
  showImplicitArguments = true,
  excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
}
-- metals_config.init_options.statusBarProvider = "on"
EOF

" nvim-tree
" ==================================================
lua <<EOF
require"nvim-tree".setup{
	view = {
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
}
EOF
