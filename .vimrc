
" ------- GENERAL -------

" Leader key
let mapleader=" "

" Activate relative line numbers
set rnu
set nu

" Switch between relative and absolute line numbers
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc
nnoremap <leader>nn :call NumberToggle()<cr>

" Set python paths for neovim
let g:python_host_prog = '/Users/Charpi/.config/neovim_python_paths/neovim2/bin/python'
let g:python3_host_prog = '/Users/Charpi/.config/neovim_python_paths/neovim3/bin/python'

" Launch pathogen
execute pathogen#infect()

" Shorter update time to triggerp lugins
set updatetime=1000

" Choose swapfile directory
set swapfile
set dir=/tmp

" Activate access to system clipboard
set clipboard=unnamed

" Enable folding
set foldmethod=indent
set foldlevel=99

" Folding
nnoremap <leader>f za

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
nnoremap <leader>q :bprev<CR>
nnoremap <leader>w :bnext<CR>

" Split buffers shorctuts
nnoremap <leader>sv :exec "vert sb".bufnr("%")<CR>
nnoremap <leader>so :exec "rightbelow sb".bufnr("%")<CR>

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
" Search all files
noremap <leader>sa <esc>:grep -nr '
" Search the specified filename suffix (add your suffix in include after *.)
noremap <leader>sf <esc>:grep -nr --include='*.
" Default filename search is for regex, use -nrf if you want to match exact filename strings

" Search and replace in several files recursively
noremap <leader>r1 <esc>:args `grep -r -l '
noremap <leader>r2 <esc>:argdo %s/

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

" highlight trailing space
" Doesn't work as expected. Syntax highlighting + delete trailing white space
" on save are enough.
"highlight ExtraWhitespace ctermbg=red guibg=red
"match ExtraWhitespace /\s\+$/
"autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
"autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
"autocmd InsertLeave * match ExtraWhitespace /\s\+$/
"autocmd BufWinLeave * call clearmatches()

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py,*.js,*.j2,*.sh,*.sql :call DeleteTrailingWS()
" Delete trailing whitespaces manually
nnoremap <silent> <Leader>bs :call DeleteTrailingWS()<CR>

" Pretty print json
nnoremap <leader>jp :%!python -m json.tool<CR>

" Seriously, guys. It's not like :W is bound to anything anyway.
command! W :w
command! Wq :wq

" Set 5 lines to the cursor - when moving vertically
set scrolloff=5

" Yank from current cursor position to end of line
map Y y$

" Triggers {{{

    " Save when losing focus
    au FocusLost    * :silent! wall
    "
    " When vimrc is edited, reload it
    autocmd! BufWritePost vimrc source ~/.vimrc

" }}}

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

    " Open a Quickfix window for the last search.
    nnoremap <silent> <leader>? :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

    " Highlight word {{{

        nnoremap <silent> <leader>hh :execute 'match InterestingWord1 /\<<c-r><c-w>\>/'<cr>
        nnoremap <silent> <leader>h1 :execute 'match InterestingWord1 /\<<c-r><c-w>\>/'<cr>
        nnoremap <silent> <leader>h2 :execute '2match InterestingWord2 /\<<c-r><c-w>\>/'<cr>
        nnoremap <silent> <leader>h3 :execute '3match InterestingWord3 /\<<c-r><c-w>\>/'<cr>

    " }}}

" }}}

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

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
" Completion options (select longest + show menu even if a single match is found)
set completeopt=longest,menuone
set wildignore=.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,.DS_Store,*.aux,*.out,*.toc,tmp,*.scssc

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

" Insert comments easily
":autocmd FileType python nnoremap <buffer> <leader>cm I# <esc>
":autocmd FileType sql nnoremap <buffer> <leader>cm I--<esc>
":autocmd FileType go nnoremap <buffer> <leader>cm I//<esc>
" Delete comments easily
":autocmd FileType python nnoremap <buffer> <leader>uc ^2x
":autocmd FileType sql nnoremap <buffer> <leader>uc ^2x
":autocmd FileType go nnoremap <buffer> <leader>uc ^2x

" ------- CODING LANGUAGES -------

" __PYTHON__

" Python whitespace formatting (used as default)
set tabstop=4
set softtabstop=4
set shiftwidth=4
" set textwidth=80
set shiftwidth=4
" Round indent to multiple of 'shiftwidth' for > and < commands
set shiftround
" Use spaces instead of tabs
set expandtab
" Be smart when using tabs ;)
set smarttab
set autoindent
set smartindent
set fileformat=unix
set nowrap "Don't Wrap lines (it is stupid)
set colorcolumn=80
autocmd ColorScheme * highlight ColorColumn ctermbg=0

" utf8 support
set encoding=utf-8

"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

" Insert import pdb; pdb.set_trace()
nnoremap <leader>pdb o<CR>import pdb<CR>pdb.set_trace()<esc>


" __Scala__

" Scaladoc2 style
let g:scala_scaladoc_indent = 1

" Avoid looking in SBT (and Maven) target repo while searching with CtrlP
set wildignore+=*/target/*


" __GO__

let g:go_fmt_fail_silently = 1
"Explicit the formater plugin (gofmt, goimports, goreturn...)
"goimports run both gofmt + automatic importing
let g:go_fmt_command = "goimports" 
let g:go_fmt_autosave = 1 "Set to 0 to disable auto fmt on save
let g:go_play_open_browser = 0 "Disable opening browser after posting your snippet to play.golang.org
let g:go_list_type = "quickfix" "Outputs of build and test works well with syntastic
let g:go_info_mode = "guru" "gocode or guru. guru is slower but more accurate

" Show which interfaces the type under the cursor implements. Or, if the type under the cursor is an interface, 
" show which types in the current project implement it
au FileType go nmap <Leader>gm :GoImplements<CR>
" Show type info for the word under your cursor
au FileType go nmap <Leader>gi :GoInfo<CR>

" Open the relevant Godoc for the word under the cursor
au FileType go nmap <Leader>gd :GoDoc<CR>
" Open the Godoc in browser
au FileType go nmap <Leader>gb :GoDocBrowser<CR>

" Vet and Lint
au FileType go nmap <Leader>gv :GoVet!<CR>
au FileType go nmap <Leader>gl :GoLint<CR>

" Run/build/test/coverage
au FileType go nmap <leader>gr :GoRun!<CR>
au FileType go nmap <leader>gB :GoBuild!<CR>
au FileType go nmap <leader>gt :GoTest!<CR>
au FileType go nmap <leader>gc :GoCoverage!<CR>

" Insert the error check pattern
au FileType go nmap <leader>gei oif err != nil {<CR>return<CR>}<CR><esc>
au FileType go imap <leader>gei <CR>if err != nil {<CR>return<CR>}<CR>

" By default syntax-highlighting for Functions, Methods and Structs is disabled.
" Let's enable them!
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" Check if tagbar is installed under plugins or is directly under rtp
" this covers pathogen + Vundle/Bundle
"
" Also make sure the ctags command exists
"
if !executable('ctags')
  finish
elseif globpath(&rtp, 'plugin/tagbar.vim') == ""
  finish
endif

if !exists("g:go_gotags_bin")
  let g:go_gotags_bin = "gotags"
endif

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }


" ------- VUNDLE -------

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'


" -------- PLUGINS --------

" Auto-completion for code all languages
Plugin 'Valloric/YouCompleteMe'
let g:ycm_server_python_interpreter = '/Users/Charpi/.pyenv/versions/3.5.2/bin/python3.5'
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoTo<CR>
map <leader>G  :YcmCompleter GoToDefinitionElseDeclaration<CR>
map <leader>R  :YcmCompleter GoToReferences<CR>

" Auto-completion for python code, used by YouCompleteMe
Plugin 'davidhalter/jedi-vim'

" Syntax checking with syntastic
Plugin 'scrooloose/syntastic'
" Basic syntastic config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_python_python_exec = '/usr/local/bin/python3'
" Control manually syntastic checking or not
nnoremap <leader>syo :SyntasticToggleMode<CR>
nnoremap <leader>syc :SyntasticCheck<CR>
" Choose the python checkers to use. Default flake8, uncomment to change.
"let g:syntastic_python_checkers = ['pydocstyle']
" Activate python highlighting
"let python_highlight_all=1
syntax on
" Close and display syntax checking window
nnoremap <leader><Down> :lclose<CR>
nnoremap <leader><Up> :Errors<CR>

" PEP8 checking
Plugin 'nvie/vim-flake8'

" Color schemes
Plugin 'altercation/vim-colors-solarized'
syntax enable
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
" colorscheme solarized
" Solarized-dark works but I prefer delek
colorscheme delek

" GO plugin
Plugin 'fatih/vim-go'

" Displays a sidebar with the structure of tags in the current file
Plugin 'majutsushi/tagbar'
nmap <leader>t :TagbarToggle<CR>
let g:tagbar_ctags_bin = '/usr/local/Cellar/ctags/5.8_1/bin/ctags'

" Explore file system as a tree
Plugin 'scrooloose/nerdtree'
" Automatically open a NERDTree when vim starts
autocmd vimenter * NERDTree
" Shortcut to open/close NERDTree
map <C-n> :NERDTreeToggle<CR>
" Locate file in hierarchy quickly
map <C-t> :NERDTreeFind<cr>

" Make nerdtree well integrated with tabs
Plugin 'jistr/vim-nerdtree-tabs'

" Syntax highlighting for markdown files
Plugin 'tpope/vim-markdown'

" Make surrounding easier
Plugin 'tpope/vim-surround'

" Better and easier commenting
Plugin 'scrooloose/nerdcommenter'
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

" Multiple cursors selection. Sublime text stile
Plugin 'terryma/vim-multiple-cursors'
" Disable default mapping
let g:multi_cursor_use_default_mapping=0
" Create my mapping
let g:multi_cursor_start_word_key      = '<C-c>'
let g:multi_cursor_select_all_word_key = '<S-c>'
let g:multi_cursor_start_key           = 'g<C-c>'
let g:multi_cursor_select_all_key      = 'g<S-c>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" Add git features to nerdtree
Plugin 'Xuyuanp/nerdtree-git-plugin'
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

" Super serching : search anything from vim
Plugin 'kien/ctrlp.vim'
let g:ctrlp_by_filename = 1
let g:ctrlp_regexp = 1

" Airline status bar
Plugin 'vim-airline/vim-airline'
let g:airline_powerline_fonts = 1
" Airline themes
Plugin 'vim-airline/vim-airline-themes'
let g:airline_theme='ubaryd'

" Working with CSV files effectively
Plugin 'chrisbra/csv.vim'

" Gundo tree
Plugin 'sjl/gundo.vim'
nnoremap <F5> :GundoToggle<CR>

" Highlighting for jinja templates
Plugin 'mitsuhiko/vim-jinja'
au BufNewFile,BufRead *.j2,*.html,*.htm,*.shtml,*.stm set ft=jinja

" Highlighting for groovy files (and jenkinsfiles)
" au BufNewFile,BufRead *.groovy,Jenkinsfile setf groovy
" doesn't work so well for jenkinsfiles...

" Killing buffers in a better way
Plugin 'qpkorr/vim-bufkill'
nnoremap <leader>bd :BD<CR>

" Close all buffers except buffer in current window.
Plugin 'Asheq/close-buffers.vim'
nnoremap <leader>bad :CloseOtherBuffers<CR>

" Tmux-Vim navigation
Plugin 'christoomey/vim-tmux-navigator'

" Git integration in vim
 Plugin 'tpope/vim-fugitive'
 nnoremap <leader>bgh :Gbrowse<CR>
 Plugin 'airblade/vim-gitgutter'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

