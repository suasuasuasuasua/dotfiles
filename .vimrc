syntax enable

set autochdir
set autoread
set background=dark
set belloff+=ctrlg
set colorcolumn=80
set encoding=utf-8
set expandtab
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set linebreak
set mat=1
set nobackup
set noerrorbells
set noshowmode
set noswapfile
set novisualbell
set nowrap
set nowritebackup
set number
set ruler
set scrolloff=5
set shiftwidth=4
set showmatch
set signcolumn=yes
set smartcase
set t_vb=
set tabstop=4
set termguicolors
set textwidth=80
set updatetime=300

let &t_EI = "\e[2 q"
let &t_SI = "\e[6 q"
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
let mapleader = " "
let maplocalleader = " "

inoremap JK <Esc>
inoremap Jk <Esc>
inoremap jK <Esc>
inoremap jk <Esc>
nnoremap <silent> <Leader>l :nohl<CR>
nnoremap <silent> <Leader>sn :find ~/.vimrc<CR>
nnoremap <silent> <Leader>so :source ~/.vimrc<CR>

nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

filetype plugin indent on

"Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
                  \ if line("'\"") > 0 && line("'\"") <= line("$") |
                  \   exe "normal! g`\"" |
                  \ endif

colorscheme catppuccin 

"Optional plugins (highly recommended)
"These are generally available in package managers.
"```
"Discover plugins
"dnf search vim
"```
"
"To see what the runtime path for plugin discovery is. I recommend using `tree`
"to find these files.
"```
":set runtimepath
"```
"To disable certain paths, 
"```
":set runtimepath-=~/.vim/bundle/vimacs
"```
"
"or find the 'enable' line and manually 'disable' individual plugins. note, it
"is set to 1 not 0 (weird).
"```
"let g:loaded_ctrlp = 1
"```
"
"alternatively, create folders under ~/.vim/pack
"mkdir -p ~/.vim/pack/{color,syntax,plugins}/{opt/start}
"clone in repositories under the opt (for optional) and start (for required)
"git -C https://github.com/tpope/vim-commentary clone ~/.vim/pack/plugins/start
"
"for optional packages, use :packadd to include them
"
"vim-ale
":AleX to interact with LSP
"
"vim-commentary
":Commentary to comment out lines of code
"gcc motion
"
"vim-ctrlp
":CtrlPX to pull up the fuzzy finder
"ctrl-p shortcut
"ctrl-{jk} to navigate the list
"ctrl-{np} to cycle the searches
"
"vim-fugitive
":GitX commands to interact with git
"
"vim-gitgutter
":GitGutterX commands to interact with the gutter (left of numbers)
"
"vim-go
":GoX commands to interact with go project
"
"vim-nerdtree
":NERDTreeX commands to interact with tree browser
"
"vim-powerline
"Adds a prettier statusline
