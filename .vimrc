
"" ==================== config ====================
set clipboard+=unnamedplus
set cpoptions+=x
set timeout
set timeoutlen=200
set hidden
set ignorecase 
set incsearch
set laststatus=2
set lazyredraw
set matchpairs+=<:>
set mouse=a
set nohlsearch
set noswapfile
set nowrap
set relativenumber number
set showcmd
set showmatch
set showmode
set signcolumn=yes
set smartcase
set syntax=on
set termguicolors
set updatetime=50

set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4


"" ==================== plug ====================
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'lifepillar/vim-gruvbox8'
Plug 'junegunn/fzf', { 'do': {-> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-sneak'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-user'
Plug 'machakann/vim-highlightedyank'
Plug 'mg979/vim-visual-multi'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/argtextobj.vim'
call plug#end()

" autocmd ColorScheme * highlight Normal guibg=NONE
colorscheme gruvbox8_hard


"" ==================== mappings ====================
let mapleader=" "

" fzf
nnoremap gf :Files<CR>
vnoremap gf :Files<CR>
nnoremap gF :GFiles<CR> 
vnoremap gF :GFiles<CR> 

" keep selection while indenting
vnoremap < <gv
vnoremap > >gv

" move selection up/down
vnoremap <C-J> :m '>+1<CR>gv=gv
vnoremap <C-K> :m '<-2<CR>gv=gv

" comfy mappings
noremap gh ^
noremap gj G
noremap gk gg
noremap gl $

" feels right
nnoremap U <C-R>
vnoremap U <C-R>

" always jump to exact mark with '
noremap ' `
noremap Q @w

" split line
nnoremap K i<CR><ESC>^

" yank paste
nnoremap <C-P> "0p
vnoremap <C-P> "0p
inoremap <C-V> <C-R>0
