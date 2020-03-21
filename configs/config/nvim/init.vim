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
let mapleader=','

" Plugins
source $HOME/.config/nvim/plugins.vim

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
let g:sonokai_style = 'atlantis'
colorscheme sonokai

" Airline
let g:airline_theme = 'sonokai'
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
