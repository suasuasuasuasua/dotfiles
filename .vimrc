"Easy escaping in insert mode
inoremap jk <Esc>

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

"IF YOU DON'T WANT OR NEED PLUGINS, YOU CAN DELETE EVERYTHING BELOW HERE
"OTHERWISE, go to https://github.com/junegunn/vim-plug for vim-plug installation
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"Plugins begin
call plug#begin('~/.vim/plugged')

"Autocomplete and language support
"""General
Plug 'github/copilot.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'

"Show and navigate filesystem
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

"Git integration
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

"Tmux
Plug 'christoomey/vim-tmux-navigator'

"Better status bar
Plug 'itchyny/lightline.vim'

"Text Manipulation
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-user'
Plug 'michaeljsmith/vim-indent-object'
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-repeat'

"Highlighting
Plug 'RRethy/vim-illuminate'

"Strip whitespace
Plug 'ntpeters/vim-better-whitespace'

"Comments
Plug 'tpope/vim-commentary'

"Indent visuals
Plug 'yggdroot/indentline'

"Help
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

"Themes
"Plug 'sainnhe/everforest'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }

call plug#end()

"Plugin configurations
let g:mapleader = "\<Space>"
let g:maplocalleader = ','

"Remap the leader key to the space bar
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>
"Set the timeout length before for Vim Which Key
set timeoutlen=400

"Strip the whitespaces
let g:strip_whitespace_on_save=1

"Toggle the nerd tree file system
nnoremap <C-t> :NERDTreeToggle<CR>
"Focus on the NERDTree view
nnoremap <leader>n :NERDTreeFocus<CR>
"Make the current file the root of the tree
nnoremap <C-n> :NERDTree<CR>
"Double space to find the current file in the tree
nnoremap <Leader><Leader> :NERDTreeFind<cr>

let g:NERDTreeChDirMode=2
" Start NERDTree and put the cursor back in the other window.
"autocmd VimEnter * NERDTree | wincmd p
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

"Enable the git gutter on the left
autocmd BufEnter,BufNewFile * GitGutterEnable
highlight! link SignColumn LineNr
let g:gitgutter_set_sign_background = 1
let g:gitgutter_async=0

"View files with FZF
let g:fzf_preview_window = ['right,60%', 'ctrl-/']
nnoremap <silent> <C-f> :Files<CR>
"Find phrases with regex
set grepprg=rg\ --vimgrep\ --smart-case\ --follow
command! -bang -nargs=* RG
                  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1,
                  \   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)
nnoremap <silent> <Leader>f :Rg<CR>

"Viewer options: One may configure the viewer either by specifying a built-in
"viewer method:
let g:vimtex_view_method = 'skim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"COC LSP configurations
"Use tab for trigger completion with characters ahead and navigate
"NOTE: There's always complete item selected by default, you may want to enable
"no select by `"suggest.noselect": true` in your configuration file
"NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
"other plugin before putting this into your config
let g:coc_snippet_next = '<TAB>'
inoremap <silent><expr> <TAB>
                  \ coc#pum#visible() ? coc#pum#next(1) :
                  \ CheckBackspace() ? "\<Tab>" :
                  \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
"Make <CR> to accept selected completion item or notify coc.nvim to format
"<C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                  \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
function! CheckBackspace() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
endfunction


"Scroll through documentation with C-f and C-b
if has('nvim-0.4.3') || has('patch-8.2.0750')
          nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
          nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
          inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
          inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
endif

"Use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()
"Use `[g` and `]g` to navigate diagnostics
"Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
"GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
"Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
      if CocAction('hasProvider', 'hover')
            call CocActionAsync('doHover')
      else
            call feedkeys('K', 'in')
      endif
endfunction

"Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

"Symbol renaming
nmap cd <Plug>(coc-rename)
augroup mygroup
      autocmd!
      "Setup formatexpr specified filetype(s)
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      "Update signature help on jump placeholder
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

"Applying code actions to the selected code block
"Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
"Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
"Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
"Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)
"Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
"Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)
"Map function and class text objects
"NOTE: Requires 'textDocument.documentSymbol' support from the language server xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
"Use CTRL-S for selections ranges
"Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)
"Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

"Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

"Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

"Add (Neo)Vim's native statusline support
"NOTE: Please see `:h coc-status` for integrations with external plugins that
"provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

"Mappings for CoCList
"Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
"Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
"Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
"Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
"Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
"Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
"Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
"Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Themes
set noshowmode
colorscheme catppuccin_mocha

let g:lightline = {'colorscheme': 'catppuccin_mocha'}

let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

set termguicolors
