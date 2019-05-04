syntax on
set ruler
set formatoptions+=o
set textwidth=0
set modeline
set cursorline
set linespace=0
set nojoinspaces
set number relativenumber
set nu rnu
set splitbelow
set splitright
if !&scrolloff
    set scrolloff=3
endif
if !&sidescrolloff
    set sidescrolloff=5
endif
set display+=lastline
set nostartofline
set noerrorbells
set backspace=indent,eol,start
set showcmd
set showmode
set encoding=utf-8
set autowrite
set autoread
set undofile
set laststatus=2
set fileformats=unix,dos,mac
set showmatch
set incsearch
set hlsearch
set ignorecase
set smartcase
set autoindent
set tabstop=4 shiftwidth=4 expandtab
set magic
set backupdir=~/.config/nvim/backup//
set directory=~/.config/nvim/swap//
set undodir=~/.config/nvim/undo//
set list listchars=tab:>\ ,extends:>,precedes:<,nbsp:+,trail:-,eol:↵
set hidden
set updatetime=200
let mapleader=','

let g:python3_host_prog="/usr/local/bin/python3"
let g:python_host_prog="/usr/local/bin/python"

" Search and Replace
nmap <Leader>s :%s//g<Left><Left>

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
    nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" set cursorcolumn
nmap <Space> <PageDown>

" Buffer handling
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
map <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

" Plugins here
call plug#begin('~/.config/nvim/plugged')
Plug 'jiangmiao/auto-pairs'
Plug 'editorconfig/editorconfig-vim'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Konfekt/FastFold'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'Yggdroot/indentLine'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'NLKNguyen/papercolor-theme'
Plug 'tmhedberg/SimpylFold'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'FooSoft/vim-argwrap'
Plug 'dominikduda/vim_current_word'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'machakann/vim-highlightedyank'
Plug 'terryma/vim-multiple-cursors'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-surround'
call plug#end()

filetype plugin on

" Multicursor
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_quit_key='<Esc>'

" Language Client
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'python': ['/usr/local/bin/pyls', '-v'],
    \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
    \ }
let g:LanguageClient_settingsPath = '~/.config/nvim/settings.json'
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <leader>r :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> <leader>f :call LanguageClient#textDocument_formatting()<CR>
nnoremap <silent> <C-k> :cprevious<CR>
nnoremap <silent> <C-j> :cnext<CR>

" deoplete
let g:deoplete#enable_at_startup = 1

" auto completion
autocmd InsertLeave * if pumvisible() == 0 | silent! pclose | endif
inoremap <silent><expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" highlighted yank
hi HighlightedyankRegion cterm=reverse gui=reverse
let g:highlightedyank_highlight_duration = 1000

" Ulti Snips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" SimplyFold
set foldlevel=99
let g:SimpylFold_docstring_preview = 1

" Argwrap
nnoremap <silent> <leader>a :ArgWrap<CR>
let g:argwrap_tail_comma = 1

" Nerdtree
map <C-o> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['_site', '\.pyc$', '\~$']
set mouse=a
let g:NERDTreeMouseMode=3

" Nerdcommenter
let g:NERDDefaultAlign = 'left'

" fzf
nmap ; :Files<CR>

" Theme
set background=dark
set termguicolors
silent! colorscheme papercolor

" Airline
let g:airline_theme='papercolor'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_powerline_fonts=1

"python with virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    exec(open(activate_this).read(), {'__file__':activate_this})
EOF
