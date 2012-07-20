" ===== Basic settings ===== "
set nocompatible
set incsearch
set nohlsearch
set nobackup
set textwidth=79
set linebreak
set undodir=~/.vim/undodir
set undofile
set hidden
set ruler

" remap leader key to space
let mapleader=" "

" default indentation: tabs, 4 wide
" in existing files, indentation is set by the vim-sleuth plugin
set expandtab
set tabstop=4

if v:version < 704
  set shiftwidth=4
else
  set shiftwidth=0
endif

" make the autocomplete match the longest substring, and display even if there's
" only one match
set completeopt=longest,menuone

" align at the same level when there's unclosed parenthesis, as in:
" foo(argument_1,
"     argument_2)
set cino=(0

" conceal characters with their unicode versions in Latex and stuff
set conceallevel=2

syntax on

" ===== plugin manager ===== "
call plug#begin('~/.vim/bundle')

" let Vundle manage Vundle, required
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-commentary'
Plug 'kien/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'godlygeek/tabular'
Plug 'Rip-Rip/clang_complete'
Plug 'LaTeX-Box-Team/LaTeX-Box'
Plug 'davidhalter/jedi-vim'
Plug 'hynek/vim-python-pep8-indent'
Plug 'ervandew/supertab'
Plug 'wting/rust.vim'
Plug 'vivkin/flatland.vim'
Plug 'itchyny/lightline.vim'
Plug 'Raimondi/delimitMate'

call plug#end()

filetype plugin indent on

" ===== Appearance ===== "
set background=dark
let g:zenburn_high_Contrast=1
colorscheme flatland
if has('gui_running')
  set guioptions=e
  set guiheadroom=0
  set gfn=Dejavu\ Sans\ Mono\ 10
  set visualbell
endif
hi Conceal guibg=bg guifg=fg


" ===== Plugin settings ===== "

" CtrlP
noremap <C-p> :CtrlP<CR>
noremap <C-o> :CtrlPBufTag<CR>
noremap <Leader>b :CtrlPBuffer<CR>

" nerdtree and taglist toggle
noremap <F2> :NERDTreeToggle<CR>
noremap <F3> :TagbarToggle<CR>

" clang_complete
let g:clang_snippets = 1
let g:clang_snippets_engine = 'ultisnips'
let g:clang_close_preview = 1
let g:clang_library_path = '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib'

" ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" jedi
let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = 1

" supertab
autocmd FileType *
\ if &omnifunc != '' |
\   call SuperTabChain(&omnifunc, "<c-p>") |
\   call SuperTabSetDefaultCompletionType("<c-x><c-u>") |
\ endif

set laststatus=2
