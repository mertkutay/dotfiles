set number
set relativenumber
set splitbelow
set splitright
set cursorline
set nojoinspaces
set nostartofline
set ignorecase
set smartcase
set tabstop=4 shiftwidth=4 expandtab
set directory=~/.config/nvim/swap
set undodir=~/.config/nvim/undo
set undofile
set hidden
set nobackup
set nowritebackup
set cmdheight=1
set updatetime=200
set shortmess+=c
set signcolumn=yes:2
set clipboard+=unnamedplus
let mapleader=','

" Plugins here
call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-sensible'

Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'terryma/vim-multiple-cursors'
Plug 'jiangmiao/auto-pairs'
Plug 'FooSoft/vim-argwrap'
Plug 'scrooloose/nerdcommenter'
Plug 'tmhedberg/SimpylFold'
Plug 'Konfekt/FastFold'

Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'Yggdroot/indentLine'
Plug 'sheerun/vim-polyglot'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" Search and Replace
nmap <Leader>s :%s//g<Left><Left>

" set cursorcolumn
nmap <Space> <PageDown>

" Buffer handling
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
map <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

" LSP
source $HOME/.config/nvim/coc.vim

" Theme
set background=dark
set termguicolors
let ayucolor="dark"
colorscheme onedark

" Airline
let g:airline_theme = 'onedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_powerline_fonts = 1

" IndentLine
let g:indentLine_char = ''
let g:indentLine_first_char = ''

" Gitgutter
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '>'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = '<'
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gb :Gblame<CR>

" SimplyFold
set foldlevel=99
let g:SimpylFold_docstring_preview = 1

" Argwrap
nnoremap <silent> <leader>a :ArgWrap<CR>
let g:argwrap_tail_comma = 1

" Nerdtree
map <C-o> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['_site', '__pycache__', '\.pyc$', '\~$']
set mouse=a
let g:NERDTreeMouseMode=3

" Nerdcommenter
let g:NERDDefaultAlign = 'left'
let g:NERDSpaceDelims = 1

" fzf
nmap ; :Files<CR>
nmap \ :Rg<CR>

"python with virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    exec(open(activate_this).read(), {'__file__':activate_this})
EOF
