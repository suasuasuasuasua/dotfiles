"Easy escaping in insert mode
inoremap jk <Esc>
inoremap Jk <Esc>
inoremap jK <Esc>
inoremap JK <Esc>

"Navigate between panes
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

"Syntax highlighting and line numbering
syntax enable
set number
"Create a column visualization to format and wrap text
set colorcolumn=80
set textwidth=80
set nowrap
set linebreak

"Set cursor shapes in insert and normal mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

"Set default encoding
set encoding=utf-8

"Keep 5 lines below and above the cursor
set scrolloff=5

"Set the update time for plugins and events
set updatetime=300

"Always show the sign column so that the screen doesn't become shifted
set signcolumn=yes

"Set ruler options at the bottom of the editor
set ruler
set laststatus=2

"Turn off annoying bells
set novisualbell
set noerrorbells
set t_vb=
set belloff+=ctrlg

"Detect if the file has been changed
set autoread

"Automatically change the directory
set autochdir

"Searching functions
set ignorecase
set smartcase
set hlsearch
set incsearch
"Clear highlighting after search
nnoremap <silent> <Leader>l :nohl<CR>

"Show matching brackets and quotes
set showmatch
set mat=1

"Removes annoying swap files
set nobackup
set nowritebackup
set noswapfile

"Set tabs to spaces and tabsize
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

"Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
                  \ if line("'\"") > 0 && line("'\"") <= line("$") |
                  \   exe "normal! g`\"" |
                  \ endif

colorscheme catppuccin 
set noshowmode
set background=dark
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
set termguicolors

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
