"" VUNDLE STUFF
set nocompatible              " Required by Vundle
filetype off                  " Required by Vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" My bundles
Plugin 'tpope/vim-rails'
Plugin 'tComment'
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'thoughtbot/vim-rspec'
Plugin 'terryma/vim-expand-region'
Plugin 'scrooloose/nerdtree'
Plugin 'ggreer/the_silver_searcher'
Plugin 'rking/ag.vim'
Plugin 'mattn/emmet-vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.

" All of your Plugins must be added before the following line
call vundle#end()            " Required by Vundle
filetype plugin indent on    " Required by Vundle

"" VIM CONFIGURATION
let mapleader = "\<Space>"      " Map leader key to space bar
syntax enable                   " syntax highlighting
set encoding=utf-8
set showcmd                     " display incomplete commands
set number                      " show line numbers
set noswapfile                  " Disable swapfile from creating
set wildmenu                    " visual autocomplete for command menu
set cursorline                  " horizontal highlighting
set noswapfile                  " Disable swapfile from creating
set timeoutlen=1000             " used for mapping delays
set ttimeoutlen=0               " used for keycode delays
filetype plugin indent on       " load file type plugins + indentation

"" THE SILVER SEARCHER
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Ag.vim will always search from project root
let g:ag_working_path_mode="r"

"" THEME
set background=dark             "dark background
colorscheme solarized           "set colorscheme to solarized

"" EMMET MAPPING
" tab for Emmet completion
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

"" WHITESPACE
set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode
set list listchars=tab:»·,trail:·     " Display extra whitespace
nnoremap <Leader>rt :%s/\s\+$//e<CR>  " Clear trailing whitespace
au BufWritePre *.rb :%s/\s\+$//e      " Remove trailing whitespace on save for ruby files

"" SEARCHING
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

"" MAPPINGS
" Map jk to escape
inoremap jk <ESC>
vnoremap jk <ESC>
" Type <Space>w to save file
nnoremap <Leader>w :w<CR>
" Enter visual mode with space space
nmap <Leader><Leader> V
" Go to related mdel with <Space>m
nnoremap <leader>m :Emodel<CR>
" Go to related controller with <Space>c
nnoremap <leader>c :Econtroller<CR>
" Drop in Pry to debug. <Space> bp
nmap <leader>bp obinding.pry<esc>^
" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" Enable copying to clipboard using `CTRL + c`
map <C-c> y:e ~/clipsongzboard<CR>P:w !pbcopy<CR><CR>:bdelete!<CR>

" VIM-EXPAND REGION MAPPINGS
" Press v to enter visual mode, vv to select word, vvv to select line, etc.
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" NERDTREE MAPPINGS
" Toggle nerd tree with <SPACE> n
map <Leader>n :NERDTreeToggle<CR>

" RSpec.vim MAPPINGS
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" Copy & paste to system clipboard with <Space>p and <Space>y
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Git Blame mapping with <SPACE> b
vmap <Leader>b :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

" Navigate panes with <CTRL> + h,j,k,l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Open VIMRC file with <SPACE> vm
nmap <Leader>vm :tabedit $MYVIMRC<CR>

" Source VIMRC with <SPACE> so
nmap <Leader>so :source $MYVIMRC<CR>

"" Search and Replace
" Search with /something
" Hit 'cs' to replace first match, then <ESC>
" 'n.n.n.n.' to review then replace
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
      \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap s :normal vs<CR>
