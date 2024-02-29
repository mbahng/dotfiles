
" OPTIONS ===========================================
filetype plugin indent on 
syntax on 
set background=dark
set autoindent
set expandtab
set shiftwidth=2
set tabstop=2
set nu
set cursorline      " Line where cursor is set nocompatible    " Set compatibility to vim only
set encoding=utf-8  " Encoding
set spell           " Spell check 
set scrolloff=10    " Have some lines after final line of text file 
set colorcolumn=80
set mouse=a
set ignorecase 
set textwidth=100 " previously set to 100 
set linebreak 
set relativenumber
set termguicolors

set cinkeys -=0#
set whichwrap+=<,>,[,],h,l

set breakindent
set foldmethod=indent
set foldlevel=10000

let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

let NERDTreeShowHidden=1
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Trigger a highlight only when pressing f and F.
let g:qs_highlight_on_keys = ['f', 'F']

let g:floaterm_width=0.8
let g:floaterm_height=0.9

let g:indentLine_setColors=0
let g:indentLine_char = '▏'


augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
augroup END

let g:UltiSnipsExpandTrigger='<Enter>'
let g:UltiSnipsJumpForwardTrigger='<Tab>'    " use Tab to move forward through tabstops
let g:UltiSnipsJumpBackwardTrigger='<S-Tab>'  " use Shift-Tab to move backward through tabstops
let g:UltiSnipsSnippetDirectories=['UltiSnips'] 



" REMAPS =============================================

imap <C-?> <C-h> 

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <space>e :NERDTreeToggle<cr>
nnoremap <space>u :UndotreeToggle<cr>
nnoremap <space>y :Files<cr>
nnoremap <C-\> :FloatermToggle!<cr>
tnoremap <C-\> <C-d>:FloatermToggle!<cr>

" Resize with arrows 
nnoremap <C-Up> :resize -2<cr>
nnoremap <C-Down> :resize +2<cr>
nnoremap <C-Left> :vertical resize -2<cr>
nnoremap <C-Right> :vertical resize +2<cr>

" Navigate buffers 
nnoremap <S-l> :bNext<cr> 
nnoremap <S-h> :bNext<cr> 
nnoremap <C-w> :bNext<cr> 
nnoremap <C-t> :bNext<cr> 


" Press jk fast to enter
inoremap jk <esc>

" Moving within same line
nnoremap j gj
nnoremap k gk

" Keep cursor in the middle when page up/down and when searching 
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzzzv
nnoremap N Nzzzv

" folding 
nnoremap <space>f za
nnoremap <space>zM zM
nnoremap <space>zR zR

" go to definition and error 
nnoremap gd gd 
nnoremap gl gl 

" indenting multiple lines 
vnoremap <tab> > 
vnoremap <S-tab> < 

" yank to system clipboard 
vnoremap y "+y
nnoremap yy "+yy

" vertical split 
nnoremap <space>v :vsplit<cr>


" PLUGINS ====================================

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

augroup vimrcPlug
  autocmd!
  autocmd BufWritePost .vimrc source % | PlugInstall
augroup END

" Plugins 
call plug#begin('~/.vim/plugged') 

" Essentials 
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'lambdalisue/suda.vim'         " Read/Write with sudo privilege
Plug 'Yggdroot/indentLine'          " indent line guides
Plug 'preservim/nerdtree' 

Plug 'SirVer/ultisnips'


" Syntax highlighting
Plug 'sheerun/vim-polyglot' 

" Configuration of status line 
Plug 'vim-airline/vim-airline' 

" Quick scope for smooth horizontal navigation  
Plug 'unblevable/quick-scope'

Plug 'jiangmiao/auto-pairs'         " Close parantheses, quotes ,etc. 
Plug 'voldikss/vim-floaterm'

Plug 'mbbill/undotree'
Plug 'github/copilot.vim'

Plug 'adrian5/oceanic-next-vim'
Plug 'joshdick/onedark.vim'

Plug 'bagrat/vim-buffet'

call plug#end()
colorscheme oceanicnext

