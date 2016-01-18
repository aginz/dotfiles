"" VUNDLE STUFF
set nocompatible              " Required by Vundle
filetype off                  " Required by Vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" My bundles
Plugin 'airblade/vim-gitgutter'
Plugin 'bling/vim-airline'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'christoomey/vim-tmux-runner'
Plugin 'ggreer/the_silver_searcher'
Plugin 'godlygeek/tabular'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'kien/ctrlp.vim'
Plugin 'rizzatti/dash.vim'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tComment'
Plugin 'terryma/vim-expand-region'
Plugin 'thoughtbot/vim-rspec'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'unblevable/quick-scope'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.

" All of your Plugins must be added before the following line
call vundle#end()            " Required by Vundle
filetype plugin indent on    " Required by Vundle

"" VIM CONFIGURATION
let mapleader = "\<Space>"      " Map leader key to space bar
syntax enable                   " syntax highlighting
set encoding=utf-8
set laststatus=2                " Always display the status line
set number                      " show line numbers
set noshowmode                  " Remove duplicate status
set noswapfile                  " Disable swapfile from creating
set wildmenu                    " visual autocomplete for command menu
set wildmode="list:longest"
set cursorline                  " horizontal highlighting
" set cursorcolumn                " vertical highlighting
set shell=/bin/sh               " Load correct ruby
set showcmd                     " display incomplete commands
set si                          " smart indent
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

" Ag.vim will always search from project root
let g:ag_working_path_mode="r"
" Show 20 results in CtrlP
let g:ctrlp_match_window = 'max:20'

" Use Rspec.vim with Dispatch
let g:rspec_command = "Dispatch rspec {spec}"

""""""""""""""""
"THEME
""""""""""""""""
set background=dark

"" grb256
:set t_Co=256 " 256 colors
:set background=dark
:color grb256

"" Solarized
" let g:solarized_termcolors=16
" let g:solarized_termtrans = 1      "make solarized work with tmux
" let g:airline_theme="solarized"    "vim airline theme
" colorscheme solarized

" Manually toggle solarized background with leader bg
function! BgToggleSol()
  if &background == "light"
    execute ":set background=dark"
  else
    execute ":set background=light"
  endif
endfunction
nnoremap <leader>bg :call BgToggleSol()<cr>

"" WHITESPACE
set nowrap                      " don't wrap lines
set tabstop=2 softtabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
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
set scrolloff=3

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
" Zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>
" Breakout into a new tab
nnoremap <Leader>bt <C-w>T
" Open CTRL P
nnoremap <Leader>o :CtrlP o<CR>
" Change panes
nnoremap <Leader>e <C-w>w
" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" TMUX RUNNER
nnoremap <leader>irb :VtrOpenRunner {'orientation': 'h', 'percentage': 50, 'cmd': 'irb'}<cr>
nnoremap <leader>pry :VtrOpenRunner {'orientation': 'h', 'percentage': 50, 'cmd': 'pry'}<cr>
nnoremap <leader>fr :VtrFocusRunner<cr>
nnoremap <leader>kr :VtrKillRunner<cr>
nnoremap <leader>va :VtrAttachToPane<cr>
nmap <C-f> :VtrSendLinesToRunner<cr>
vmap <C-f> <Esc>:VtrSendLinesToRunner<cr>

" VIM-EXPAND REGION MAPPINGS
" Press v to enter visual mode, vv to select word, vvv to select line, etc.
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" NERDTREE MAPPINGS
" Toggle nerd tree with <SPACE> nt
map <Leader>nt :NERDTreeToggle<CR>

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
" nnoremap <C-h> <C-w>h
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-l> <C-w>l

" Open VIMRC file with <SPACE> vm
nmap <Leader>vm :tabedit $MYVIMRC<CR>

" Source VIMRC with <SPACE> so
nmap <Leader>so :source $MYVIMRC<CR>

" Trigger a highlight only when pressing f and F. (quick-scope)
let g:qs_highlight_on_keys = ['f', 'F']

" Make cursor vertical line in insert mode
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
