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
set hidden
set nobackup
set nowritebackup
set cmdheight=1
set updatetime=200
set shortmess+=c
set autoread
syntax on
let mapleader=','

set hlsearch
nnoremap <C-L> :nohlsearch<CR><C-L>

" Search and Replace
nmap <Leader>s :%s//g<Left><Left>

" Buffer handling
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
map <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

" Theme
set termguicolors
set background=dark

" Remember cursor position between vim sessions
autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif

autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
    \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
autocmd FileChangedShellPost *
    \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
