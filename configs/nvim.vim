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
let mapleader=','

" Search and Replace
nmap <Leader>s :%s//g<Left><Left>

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" set cursorcolumn
nmap <Space> <PageDown>

" Plugins here
call plug#begin('~/.config/nvim/plugged')
Plug 'w0rp/ale'
Plug 'jiangmiao/auto-pairs'
Plug 'Konfekt/FastFold'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'tmhedberg/SimpylFold'
Plug 'srcery-colors/srcery-vim'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'FooSoft/vim-argwrap'
Plug 'Chiel92/vim-autoformat'
Plug 'tpope/vim-commentary'
Plug 'dominikduda/vim_current_word'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-multiple-cursors'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-surround'
Plug 'Valloric/YouCompleteMe'
call plug#end()

filetype plugin on

set updatetime=750

" Ulti Snips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_semantic_triggers = {'python': ['re!from\s+\S+\s+import\s']}
let g:ycm_goto_buffer_command = 'split-or-existing-window'
map <leader>d :rightbelow vertical YcmCompleter GoToDefinitionElseDeclaration<CR>

" ALE
let g:ale_linters = {
\   'python': ['flake8'],
\   'javascript': ['eslint'],
\}
let g:ale_warn_about_trailing_whitespace = 0
let g:ale_completion_enabled = 0
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" SimplyFold
set foldlevel=99
let g:SimpylFold_docstring_preview = 1

" Argwrap
nnoremap <silent> <leader>a :ArgWrap<CR>

" Autoformat
nnoremap <silent> <leader>f :Autoformat<CR>

" Nerdtree
map <C-o> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['_site', '\.pyc$', '\~$']
set mouse=a
let g:NERDTreeMouseMode=3

" fzf
nmap ; :Files<CR>

" Theme
silent! colorscheme srcery
set termguicolors

" Airline
let g:airline_theme='srcery'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_powerline_fonts=1

" Multicursor
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_quit_key='<Esc>'

" Buffer handling
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
map <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

"python with virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  exec(open(activate_this).read(), {'__file__':activate_this})
EOF
