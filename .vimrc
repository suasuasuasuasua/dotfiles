 "defaults
inoremap jk <Esc>:w<CR>
nnoremap <silent> <C-k> :nohl<CR><C-l>

syntax on
set number

let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

set ruler
set laststatus=2

set novisualbell
set noerrorbells
set t_vb=
set belloff+=ctrlg

set autoread

set ignorecase
set smartcase
set hlsearch
set incsearch

set showmatch
set mat=1

set nobackup
set nowritebackup
set noswapfile

filetype plugin indent on

set tabstop=4
set shiftwidth=4
set expandtab

"IF YOU DON'T WANT OR NEED PLUGINS, YOU CAN DELETE EVERYTHING BELOW HERE
"OTHERWISE, go to https://github.com/junegunn/vim-plug for vim-plug installation
"plugins
call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
Plug 'ackyshake/VimCompletesMe'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'airblade/vim-gitgutter'
Plug 'sheerun/vim-polyglot'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

Plug 'dracula/vim', { 'as': 'dracula' }
"Plug 'romainl/Apprentice'
call plug#end()

"lugin configurations
set noshowmode
" let g:lightline = {
" 			\ 'colorscheme': 'apprentice'
" 			\ }

nnoremap <C-b> :NERDTreeToggle<CR>
let g:NERDTreeChDirMode=2
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif


autocmd BufEnter,BufNewFile * GitGutterEnable
highlight! link SignColumn LineNr
let g:gitgutter_set_sign_background = 1
let g:gitgutter_async=0

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

nnoremap <C-/> Commentary

"themes
"set termguicolors
"set background=dark
"colorscheme apprentice
colorscheme dracula
set t_ut=""

let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
highlight Comment cterm=italic gui=italic
hi Normal guibg=NONE ctermbg=NONE