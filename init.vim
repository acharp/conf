
" ------- GENERAL -------
"
" Leader key
let mapleader=" "

" No need to press shift every time anymore
nnoremap ; :

" Fais delek!
colorscheme delek

" Activate relative line numbers
set rnu
set nu

" Set python paths for neovim
let g:python_host_prog = '/Users/Charpi/.config/neovim_python_paths/neovim2/bin/python'
let g:python3_host_prog = '/Users/Charpi/.config/neovim_python_paths/neovim3/bin/python'

" Shorter update time to triggerp lugins
set updatetime=1000

" Choose swapfile directory
set swapfile
set dir=/tmp

" Activate access to system clipboard
set clipboard=unnamed

" The width of a TAB is set to 4. But it is still a \t. 
set tabstop=4       
" Indents will have a width of 4
set shiftwidth=4    
" Pressing TAB in insert mode will have a width of 4
set softtabstop=4   
" Expand TABs to spaces
set expandtab       

" Customize windows spliting
set splitbelow
set splitright

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Reload vimrc
nnoremap <leader>rl :source ~/.vimrc<CR>

" Switch between buffers
nnoremap <leader>n :bprev<CR>
nnoremap <leader>m :bnext<CR>

" Split buffers shorctuts
nnoremap <leader>\ :exec "vert sb".bufnr("%")<CR>
nnoremap <leader>- :exec "rightbelow sb".bufnr("%")<CR>

" Select all
nnoremap <leader>a <esc>ggVG<CR>

" Select word - Copy word
nnoremap <leader>sw bve
nnoremap <leader>cw bye

" Paste on next line
nnoremap <leader>pn :pu<CR>

" Refresh file
nnoremap <leader>rf :edit<CR>

" Search recursively through all files from opening directory
" TODO : Reimplement these commands replacing grep by ag
" Search all files
noremap <leader>sa <esc>:grep -nr '
" Search the specified filename suffix (add your suffix in include after *.)
noremap <leader>sf <esc>:grep -nr --include='*.
" Default filename search is for regex, use -nrf if you want to match exact filename strings

" Delete without putting into buffer
nnoremap <leader>d "_d
vnoremap <leader>d "_d
nnoremap <leader>ld "_dd
vnoremap <leader>ld "_dd
nnoremap <leader>D "_D
vnoremap <leader>D "_D

" You want to be part of the gurus? Time to get in serious stuff and stop using
" arrow keys.
noremap <left> <nop>
noremap <up> <nop>
noremap <down> <nop>
noremap <right> <nop>
inoremap <left> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <right> <nop>

" Pretty print json
nnoremap <leader>jp :%!python -m json.tool<CR>

" Seriously, guys. It's not like :W is bound to anything anyway.
command! W :w
command! Wq :wq

" Set 5 lines to the cursor - when moving vertically
set scrolloff=5

" Yank from current cursor position to end of line
map Y y$

" Save when losing focus
au FocusLost    * :silent! wall

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Make sure that extra margin on left is removed
set foldcolumn=0

" Turn on the WiLd menu
set wildmenu
" Set command-line completion mode
set wildmode=list:longest,full

" Highlight current line - allows you to track cursor position more easily
set cursorline

" This is totally awesome - remap jj to escape in insert mode.  You'll never type jj anyway, so it's great!
inoremap jj <esc>
nnoremap JJJJ <nop>

" let's make sure we are in noncompatble mode
set nocp

" Sets how many lines of history VIM has to remember
set history=700

" Make sure that coursor is always vertically centered on j/k moves
set so=999

" Remap VIM 0 to first non-blank character
map 0 ^

" Copy to clipboad the absolute path of the directory of the current file
nnoremap <leader>p :let @*=expand("%:p:h")<CR>

" Searching {{{

    " sane regexes
    nnoremap / /\v
    vnoremap / /\v

    set infercase
    set ignorecase
    set smartcase
    set showmatch
    " set gdefault
    set hlsearch
    set incsearch

    " clear search matching
    nnoremap <leader>cl :noh<cr>:call clearmatches()<cr>

    " Don't jump when using * for search
    nnoremap * *<c-o>

    " Keep search matches in the middle of the window.
    nnoremap n nzzzv
    nnoremap N Nzzzv

    " Same when jumping around
    nnoremap g; g;zz
    nnoremap g, g,zz

    " Highlight word {{{

        nnoremap <silent> <leader>hh :execute 'match InterestingWord1 /\<<c-r><c-w>\>/'<cr>
        nnoremap <silent> <leader>h1 :execute 'match InterestingWord1 /\<<c-r><c-w>\>/'<cr>
        nnoremap <silent> <leader>h2 :execute '2match InterestingWord2 /\<<c-r><c-w>\>/'<cr>
        nnoremap <silent> <leader>h3 :execute '3match InterestingWord3 /\<<c-r><c-w>\>/'<cr>

    " }}}

" }}}


" -------- PLUGINS --------

" Start vim-plug
call plug#begin('~/.local/share/nvim/plugged')

" Explore file system as a tree
Plug 'scrooloose/nerdtree'
" Automatically open a NERDTree when vim starts
autocmd vimenter * NERDTree
" Shortcut to open/close NERDTree
map <C-n> :NERDTreeToggle<CR>
" Locate file in hierarchy quickly
map <C-t> :NERDTreeFind<cr><Paste>
" Make nerdtree well integrated with tabs
Plug 'jistr/vim-nerdtree-tabs'
" Add git features to nerdtree
Plug 'Xuyuanp/nerdtree-git-plugin'
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

" Make surrounding easier
Plug 'tpope/vim-surround'

" Better and easier commenting
Plug 'scrooloose/nerdcommenter'
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1
" Disable default mapping because was overlapping with other shortcuts
let g:NERDCreateDefaultMappings = 0
" And just enable the few commands I use:
" Comment
map <leader>cc <plug>NERDCommenterComment
" Uncomment
map <leader>cu <plug>NERDCommenterUncomment
" Invert comments
map <leader>ci <plug>NERDCommenterInvert

" Super serching : search anything from vim
Plug 'kien/ctrlp.vim'
let g:ctrlp_by_filename = 1
let g:ctrlp_regexp = 1

" Airline status bar
Plug 'vim-airline/vim-airline'
let g:airline_powerline_fonts = 1
" Not enough room in this bar!
let g:airline#extensions#tagbar#enabled = 0
let g:airline#extensions#default#layout = [
    \ [ 'a', 'b', 'c' ],
    \ [ 'x', 'z', 'error', 'warning' ]
    \ ]
" Airline themes
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='ubaryd'

" Working with CSV files effectively
Plug 'chrisbra/csv.vim'

" Killing buffers in a better way
Plug 'qpkorr/vim-bufkill'
nnoremap <leader>bd :BD<CR>

" Close all buffers except buffer in current window.
Plug 'Asheq/close-buffers.vim'
nnoremap <leader>bad :CloseOtherBuffers<CR>

" Tmux-Vim navigation
Plug 'christoomey/vim-tmux-navigator'

" Git file markers and diff showed in vim
Plug 'airblade/vim-gitgutter'

" End vim-plug initialization
call plug#end()
