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

" Buffer handling
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
map <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

" LSP
source $HOME/.config/nvim/coc.vim

" Theme
syntax on
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors
set background=dark
let g:one_allow_italics=1
colorscheme one
function! AdaptColorscheme()
   highlight clear CursorLine
   highlight Normal ctermbg=none
   highlight LineNr ctermbg=none
   highlight Folded ctermbg=none
   highlight NonText ctermbg=none
   highlight SpecialKey ctermbg=none
   highlight VertSplit ctermbg=none
   highlight SignColumn ctermbg=none
endfunction
autocmd ColorScheme * call AdaptColorscheme()

highlight Normal guibg=NONE ctermbg=NONE
highlight CursorColumn cterm=NONE ctermbg=NONE ctermfg=NONE
highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE
highlight CursorLineNr cterm=NONE ctermbg=NONE ctermfg=NONE
highlight clear LineNr
highlight clear SignColumn

set t_8b=^[[48;2;%lu;%lu;%lum
set t_8f=^[[38;2;%lu;%lu;%lum

" Lightline
let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ ['close'] ]
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ }
      \ }
set showtabline=2

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

" Remember cursor position between vim sessions
autocmd BufReadPost *
      \ if line("'\"") > 0 && line ("'\"") <= line("$") |
      \   exe "normal! g'\"" |
      \ endif

" EasyMotion
let g:EasyMotion_do_mapping = 0
nmap s <Plug>(easymotion-overwin-f2)
let g:EasyMotion_smartcase = 1
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

"python with virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    exec(open(activate_this).read(), {'__file__':activate_this})
EOF
