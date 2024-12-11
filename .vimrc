set hidden
set nojoinspaces
set nostartofline
set autoread
set nobackup
set nowritebackup
set noswapfile
set undofile
set clipboard=unnamedplus
set completeopt=menuone,noselect
set fileencoding=utf-8
set cmdheight=1
set smartcase
set ignorecase
set hlsearch
set mouse=a
set smartindent
set splitbelow
set splitright
set updatetime=300
set expandtab
set shiftwidth=2
set tabstop=2
set number
set signcolumn=yes
set cursorline
set scrolloff=1
set sidescrolloff=5
set list
set listchars=eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨
set shortmess+=c
set guifont=monospace:h17
set pumheight=10
set foldlevel=99
set foldmethod=expr

syntax on

let mapleader=" "
let maplocalleader=" "
noremap <Space> <Nop>
nnoremap <C-Up> :resize -2<CR>
nnoremap <C-Down> :resize +2<CR>
nnoremap <C-Left> :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
vnoremap < <gv
vnoremap > >gv
vnoremap p "_dP"
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
xnoremap J :move '>+1<CR>gv-gv'
xnoremap K :move '<-2<CR>gv-gv'

map <leader>c :bp<bar>sp<bar>bn<bar>bd<CR>
map <leader>q :q<CR>
map <leader>w :w!<CR>

" Remember cursor position between vim sessions
autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif

autocmd FileType qf set nobuflisted
autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
  \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
