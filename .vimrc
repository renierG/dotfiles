
"" ==================== config ====================
set clipboard+=unnamedplus
set hidden
set ignorecase 
set incsearch
set laststatus=2
set lazyredraw
set matchpairs+=<:>
set mouse=a
set nohlsearch
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
Plug 'ayu-theme/ayu-vim'
Plug 'junegunn/fzf', { 'do': {-> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-sneak'
Plug 'machakann/vim-highlightedyank'
Plug 'mg979/vim-visual-multi'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/argtextobj.vim'
call plug#end()

" config
let ayucolor="mirage"
autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
colorscheme ayu


"" ==================== mappings ====================
let mapleader=" "

" fzf
nnoremap gf :Files<CR>
nnoremap gF :GFiles<CR> 
nnoremap gl :BLines<cr>

" vertically center cursor after jumps
nnoremap <C-d> <C-d>M
nnoremap <C-u> <C-u>M
nnoremap <C-f> <C-f>M
nnoremap <C-b> <C-b>M

" keep selection while indenting
vnoremap < <gv
vnoremap > >gv

" move (and keep) selection up/down with indentation context
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
  
" noob scrolling
nnoremap <C-J> 10j
nnoremap <C-K> 10k

" easier to reach
noremap <C-H> ^
noremap <C-L> $

" press v twice for linewise-visual
vnoremap v V

" always jump to exact mark with '
noremap ' `

" paste in insert mode
inoremap <C-V> <C-R>+

" split line on cursor
nnoremap <CR> i<CR><ESC>^

" makes more sense
noremap Y y$ 

" yank-delete 
nnoremap yd d

" always change in black hole
nnoremap D "_D
nnoremap d "_d
vnoremap d "_d
nnoremap C "_C
nnoremap c "_c
vnoremap c "_c
nnoremap X "_X
vnoremap X "_X
nnoremap x "_x
vnoremap x "_x

