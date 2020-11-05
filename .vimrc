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
set clipboard=unnamedplus
set noshowmatch
set relativenumber
set noerrorbells
set incsearch
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

set colorcolumn=100

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mbbill/undotree'
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'gruvbox-community/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'phanviet/vim-monokai-pro'
Plug 'flazz/vim-colorschemes'
Plug 'tpope/vim-fugitive'
Plug 'pandysong/ghost-text.vim'

let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_symbols.linenr=''
call plug#end()

colorscheme gruvbox
set background=dark

" Custom remaps
"=============================================
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

map <tab> :tabNext<CR>
map <leader><tab> :tabprevious<CR>
map <leader>t :tabnew<CR>

map <leader>e :CocCommand explorer<CR>

map <F6> :setlocal spell! spelllang=en_us <CR>
map <Enter> o<ESC>

" Compile and run C++
map <F8> :w <CR> :!clear && g++ % -o '%:r' && ./'%:r' <CR>
"=============================================
"
augroup configFiles
	autocmd!
	autocmd BufWritePost $XDG_CONFIG_HOME/polybar/config call system('$XDG_CONFIG_HOME/polybar/launch.sh')
	autocmd BufWritePost $XDG_CONFIG_HOME/i3/config call system('i3 reload') 
augroup END

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Merlin things
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"
