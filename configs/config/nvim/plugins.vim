function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release --locked
    else
      !cargo build --release --locked --no-default-features --features json-rpc
    endif
  endif
endfunction

" Plugins here
call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-sensible'

" Plug 'joshdick/onedark.vim'
Plug 'sainnhe/sonokai'
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

Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }

Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

let g:polyglot_disabled = ['markdown']
