
" ------- GENERAL -------

" Leader key
let mapleader=" "

" Activate line number
set nu

" Choose swapfile directory
set swapfile
set dir=/tmp

" Activate access to system clipboard
set clipboard=unnamed

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <leader>f za

" Customize windows spliting
set splitbelow
set splitright

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Switch between buffers
nnoremap <leader>q :bprev<CR>
nnoremap <leader>w :bnext<CR>

" Select all
nnoremap <leader>a <esc>ggVG<CR>

" Delete without putting into buffer
nnoremap <leader>d "_d
vnoremap <leader>d "_d
nnoremap <leader>dd "_dd
vnoremap <leader>dd "_dd

" You want to be part of the gurus? Time to get in serious stuff and stop using
" arrow keys.
noremap <left> <nop>
noremap <up> <nop>
noremap <down> <nop>
noremap <right> <nop>

" Stripping EOF blank spaces
function! <SID>StripTrailingWhitespace()
	" Preparation: save last search, and cursor position.
	let _s=@/
	let l = line(".")
	let c = col(".")
	" Do the business:
	%s/\s\+$//e
	" Clean up: restore previous search history, and cursor position
	let @/=_s
	call cursor(l, c)
endfunction
nnoremap <silent> <Leader>bs :call <SID>StripTrailingWhitespace()<CR>

" Pretty print json
nnoremap <leader>jp :%!python -m json.tool<CR>

" Seriously, guys. It's not like :W is bound to anything anyway.
command! W :w
command! Wq :wq

" Triggers {{{

    " Save when losing focus
    au FocusLost    * :silent! wall
    "
    " When vimrc is edited, reload it
    autocmd! BufWritePost vimrc source ~/.vimrc

" }}}

" ------- CODING LANGUAGES -------

    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |

" Flagging unnecesary whitespace
highlight BadWhitespace ctermbg=red guibg=darkred
" Don't flag whitespace in insert mode
au InsertEnter * match BadWhitespace /\s\+\%#\@<!$/
au InsertLeave * match BadWhitespace /\s\+$/

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
nnoremap <leader>pdb iimport pdb; pdb.set_trace()<esc>


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

" Assure proper folding in python code
Plugin 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview = 1

" Auto-completion for code all languages
Plugin 'Valloric/YouCompleteMe'
let g:ycm_server_python_interpreter = '/usr/local/bin/python2'
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

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
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_python_exec = '/usr/local/bin/python3'
" Choose the python checkers to use. Default flake8, uncomment to change.
"let g:syntastic_python_checkers = ['pydocstyle']
" Activate python highlighting
let python_highlight_all=1
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
colorscheme solarized

" Explore file system as a tree
Plugin 'scrooloose/nerdtree'
" Automatically open a NERDTree when vim starts
autocmd vimenter * NERDTree
" Shortcut to open/close NERDTree
map <C-n> :NERDTreeToggle<CR>

" Make nerdtree well integrated with tabs
Plugin 'jistr/vim-nerdtree-tabs'

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

" Powerline customized status bar
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
set guifont=Inconsolata\ for\ Powerline:h15
let g:Powerline_symbols = 'fancy'
set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8

" Working with CSV files effectively
Plugin 'chrisbra/csv.vim'

" Highlighting for jinja templates
Plugin 'mitsuhiko/vim-jinja'
au BufNewFile,BufRead *.j2,*.html,*.htm,*.shtml,*.stm set ft=jinja

" Highlighting whitespaces
Plugin 'ntpeters/vim-better-whitespace'
nnoremap <leader>b :ToggleWhitespace<CR>
highlight ExtraWhitespace ctermbg=red

" Killing buffers in a better way
Plugin 'qpkorr/vim-bufkill'
nnoremap <leader>bd :BD<CR>

" Git integration in vim. Currently not used.
" Plugin 'tpope/vim-fugitive'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on




