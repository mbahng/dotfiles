filetype plugin indent on 
syntax on 
set background=dark
set expandtab ts=2 sw=2 ai
set nu
set cursorline      " Line where cursor is set nocompatible    " Set compatibility to vim only
set wrap            " Auto wrap text
set encoding=utf-8  " Encoding
set spell           " Spell check 
set scrolloff=10    " Have some lines after final line of text file 
set ruler
set ignorecase 
set textwidth=0 " previously set to 100 
set shiftwidth=4
set linebreak 
set relativenumber

" restore cursor to last position in file:
autocmd BufReadPost *
	\ if line("'\"") > 1 && line("'\"") <= line("$") |
	\   exe "normal! g`\"" |
	\ endif

let g:vimtex_view_method = 'zathura'
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1

" Map Ctrl-backspace to delete previous word in insert mode 
inoremap <C-j> <esc>dvbi
inoremap jk <esc>
nnoremap <C-h> ge
nnoremap <C-l> w

" Mapping navigation between split windows
nnoremap <C-Left> <C-W>h
nnoremap <C-Down> <C-W>j
nnoremap <C-Up> <C-W>k
nnoremap <C-Right> <C-W>l

" Mapping resizing vertically and horizontally windows 
nnoremap <C-S-Left> :vertical resize -5<CR> 
nnoremap <C-S-Right> :vertical resize +5<CR> 
nnoremap <C-S-Up> : resize +5<CR> 
nnoremap <C-S-Down> :resize -5<CR> 

command Toc VimtexTocToggle

autocmd FileType tex setlocal breakindent

" lines 
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'
nnoremap <C-S-j> 5j 
nnoremap <C-S-k> 5k 

nmap <c-m> <Bslash>lv

" Plugins 
call plug#begin('~/.vim/plugged') 

"Plug 'tpope/vim-fugitive'           " fugitive vim github wrapper 
Plug 'neoclide/coc.nvim'            " Conquerer of Completion
Plug 'jiangmiao/auto-pairs'         " Close parantheses, quotes ,etc. 
Plug 'gruvbox-community/gruvbox'    " Color theme 
Plug 'vim-airline/vim-airline' 
" Plug 'vim-airline/vim-airline-themes' 
Plug 'preservim/nerdtree'
Plug 'lervag/vimtex'                " Latex with vim 
Plug 'nathanaelkane/vim-indent-guides'  " Indenting guides
"Plug 'terryma/vim-smooth-scroll' 
Plug 'vimwiki/vimwiki'
Plug 'sirver/ultisnips'
Plug 'TaDaa/vimade'         " Fades whatever window you're not working on
" Plug 'vim-voom/VOoM'        " for tree like structure in file directory

call plug#end()

let g:UltiSnipsExpandTrigger = '<tab>'

" use <tab> to trigger completion and navigate to the next complete item
function! CheckBackspace() abort
let col = col('.') - 1
return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
\ coc#pum#visible() ? coc#pum#next(1) :
\ CheckBackspace() ? "\<Tab>" :
\ coc#refresh()


" Need the following code
" It essentially allows Vim to compile with the --clientserver argument
" which is needed to compile using \ll on vimtex on zathura 
" If you do 'vim --version' you can see which features are included 
" make sure that clientserver is included, which can be
" https://unix.stackexchange.com/questions/594076/how-do-i-compile-vim-with-clientserver-on-arch-linux
" You actually need to install gvim rather than vim

"if empty(v:servername) && exists('*remote_startserver')
"call remote_startserver('VIM')
"endif

set termguicolors
colo gruvbox

nnoremap <c-x> <Esc>:NERDTreeToggle<cr>
