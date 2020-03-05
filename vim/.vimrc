" .vimrc

"
" IMPORTANT: DO NOT ERASE TRAILING WHITESPACE! Some mappings require them.
"

" >> Preamble ---------------------------------------------------------------{{{

set shell=/bin/bash
let g:is_bash = 1          " For bash syntax highlighting
filetype plugin indent on  " Enable loading plugin and indent files for
                           " specific file types. It will turn on filetype if
                           " it's not already on.
set nocompatible

" }}}

" >> vim-plug ---------------------------------------------------------------{{{

" Load vim-plug
call plug#begin('~/.vim/plugged')
	" Movement
	Plug 'andymass/vim-matchup'	                " Matching syntax movement
	Plug 'tmhedberg/simpylfold'                     " Indentation folding
	Plug 'terryma/vim-multiple-cursors'             " Sublime-like multiple cursors

	" Nerd
	Plug 'scrooloose/nerdtree'                      " Tree explorer
	Plug 'albfan/nerdtree-git-plugin'               " Git ignore for NerdTREE
	Plug 'scrooloose/nerdcommenter'                 " Comment functions
	Plug 'ryanoasis/vim-devicons'                   " Nerd icons

	" Windows
	Plug 'qpkorr/vim-bufkill'                       " Closes buffer w/out changing layout
	Plug 'godlygeek/tabular'                        " Tabs

	" Lines
	Plug 'itchyny/lightline.vim'		        " Lightline

	" Color
	Plug 'flazz/vim-colorschemes'                   " Color schemes
	Plug 'ayu-theme/ayu-vim'                        " Ayu theme
	Plug 'micha/vim-colors-solarized'               " Solarized theme
	Plug 'joshdick/onedark.vim'                     " OneDark theme
	Plug 'chriskempson/base16-vim'	                " Base-16 theme
	Plug 'mike-hearn/base16-vim-lightline'          " Base-16 themes for lightline
	Plug 'chrisbra/colorizer'                       " Hex colors
	Plug 'dracula/vim', { 'name': 'dracula' }       " Dracula theme
	Plug 'NLKNguyen/papercolor-theme'               " Paper theme
	Plug 'vim-scripts/summerfruit256.vim'           " Summerfruit theme
	Plug 'sainnhe/vim-color-forest-night'           " Forest night theme

	" Git
	Plug 'tpope/vim-fugitive'                       " Git
	Plug 'airblade/vim-gitgutter'                   " Git gutter

	" Projects
	Plug 'airblade/vim-rooter' 			" Project Root

	" Languages
	Plug 'rust-lang/rust.vim' 	                " Rust
	Plug 'cespare/vim-toml' 			" TOML
	"Plug 'xolox/vim-easytags' 			" Ctags
	Plug 'majutsushi/tagbar' 			" Ctag bar

	" Code
	Plug 'ervandew/supertab'		        " Tab completion
	Plug 'neoclide/coc.nvim', {'branch': 'release'} " Code completion
	Plug 'raimondi/delimitmate'	                " Completion for [], '', ()
	Plug 'w0rp/ale'			                " Linter
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }  " FZF
	Plug 'junegunn/fzf.vim'                         " FZF
	Plug 'sickill/vim-pasta'                        " Better pasting
	Plug 'xolox/vim-misc' 				" For ctags

call plug#end()

" }}}}

" >> Basic Options ----------------------------------------------------------{{{

" Basic
set encoding=UTF-8
set mouse=a                      " Enable mouse clicks.
set guicursor+=n-v-c-i:blinkon0  " Disable blinking.
set autochdir
set modelines=0                  " Sets number of lines Vim checks for set commands.
set autoindent                   " Automatically indent lines (matching previous indent)
set showcmd                      " Show info about current command in the last line of screen.
set hidden                       " Under default settings, making changes and then opening a new
                                 " file will display 'No write since last change'.
                                 " When on, current buffers with unsaved changes will be hidden
                                 " instead of closed, letting you edit the new file.
set visualbell                   " Flashes the screen when EOF or EOL is hit.
set ttyfast                      " Basically speeds up scrolling.
set ruler                        " Show the line and column number of the cursor position.
                                 " On the far right, it shows Top if the 1st line can be seen,
                                 " Bot if the last line can be seen, All if both can be seen,
                                 " and X% indicating your relative position.
set backspace=indent,eol,start   " Allow backspacing over autoindent, line
                                 " breaks, and the start of insert.
set number                       " Show line numbers.
set relativenumber               " Show line numbers relative to the line you're on.
set laststatus=2                 " Show status line: 0: never, 1: only if there are 2+ windows, 2: always.
set history=1000                 " A history of : commands and search patterns (max: 10000).
set undofile
set undoreload=10000
"set list                                    " Show tabs, display $ after EOL. Useful to see tabs vs spaces.
"set listchars=tab:▸\ ,extends:❯,precedes:❮  " Set list characters
                                             " extends and precedes help show if
                                             " characters aren't showing if wrap
                                             " is off.
                                             " set listchars=tab:▸\ ,eol:¬,
                                             " extends:❯,precedes:❮
set lazyredraw   " The screen won't be redrawn while execing macros/commands
set showbreak=↪  " Character indicating start of lines that've been wrapped.
set splitbelow   " When splitting, put new window below current one.
set splitright   " When splitting, put new window to the right of current one.
set shiftround   " Tabs will be set to value of 'shiftwidth'.
set title	 " Window title will be set to value of 'titlestring'.
set linebreak    " Wrap long lines at a character in 'breakat'. It will NOT
                 " affect a file's content, just it's appearance.
set colorcolumn=+1  " highlight column after 'textwidth'
set backupskip=/tmp/*,/private/tmp/*"  " Make Vim able to edit crontab files
au FocusLost * :silent! wall  " Save when losing focus

" Leader
let mapleader = ","
let maplocalleader = "\\"  " Buffer specific leader

" GUI
if !has('gui_running')
	set guioptions-=m  " Disable Menu bar.
	set guioptions-=T  " Disable Tool bar.
endif

" Cursorline
" Only show cursorline in current window and in normal mode
augroup cline
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinLeave,InsertLeave * set cursorline
augroup END

" Trailing Whitespace
" Only show when not in insert mode
" THIS THROWS AN ERROR WHEN EXITING INSERT MODE
"augroup trailing
    "au!
    "au InsertEnter * :set listchars-=trail:
    "au InsertLeave * :set listchars+=trail:
"augroup END

" Line Return
" Make sure Vim returns to the same line when you reopen a file.
augroup line_return
    au!
    au BufReadPost *
	\ if line("'\"") > 0 && line ("'\"") <= line("$") |
	\     execute 'normal! g`"zvzz' |
	\ endif
augroup END

" Tabs
set tabstop=8	   " # of spaces a Tab counts for. Not setting it to 8 can make
               	   " your file appear wrong. So we use 'shiftwidth' and
               	   " 'softtabstop' instead.
set noexpandtab    " Don't replace tabs with spaces.
set shiftwidth=8
"set softtabstop=8  " # of spaces a Tab counts for when editing. It feels like
                   " tabs are inserted, but it's a mix of spaces and tabs.

" Wrapping
"set wrap
"set textwidth=96   " Longer lines will be broken after white space
set textwidth=80   " Longer lines will be broken after white space

" Backups
set backup      " Enable backups
set noswapfile  " It's 2018, Vim.

set undodir=~/.vim/tmp/undo/     " undo files
set backupdir=~/.vim/tmp/backup/ " backups
"set directory=~/.vim/tmp/swap/   " swap files

if !isdirectory(expand(&undodir)) " Make those folders if they don't exist.
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
	call mkdir(expand(&backupdir), "p")
endif
"if !isdirectory(expand(&directory))
   "call mkdir(expand(&directory), "p")
"endif

" Color Scheme
syntax on  " Overrule your color settings for highlighting stuff
highlight clear SignColumn
"set termguicolors

"set background=dark
set background=dark
let base16colorspace=256  " Access colors present in 256 color space

"" MONDO-BEGIN
colorscheme base16-atelier-dune
"colorscheme solarized8_light
"colorscheme base16-github
" MONDO-END

" Tabs
autocmd FileType sh setlocal tabstop=4 shiftwidth=4
autocmd FileType toml setlocal tabstop=2 shiftwidth=2

" Mail
setlocal fo+=aw

" }}}

" >> Convenient Mappings ----------------------------------------------------{{{

" Save
nnoremap s :w<cr>

" Sudo Save
nnoremap <leader>w :w !sudo tee "%"<cr>

" Source %
nnoremap <leader>S :source %<cr>

" Manpage for the word you're on
nnoremap <leader>m K

" Find file
nnoremap <leader>f :FZF<cr>

" Kill window
nnoremap K :q<cr>

" Refresh NERDTree
nmap <Leader>r :NERDTreeFocus<cr>R<c-w><c-p>

" Turn tabs to spaces
nnoremap <leader><Tab> :retab<cr>

" Make all windows equal
nnoremap - :wincmd =<cr>

" Splits
nnoremap <leader>wv :vs 
nnoremap <leader>ws :split 

" Switch to previous buffer
nnoremap <leader><leader> :b#<cr>

" Toggle line numbers
nnoremap <leader>n :setlocal number!<cr>

" Tabs (like actual tabs not the editing tabs)
nnoremap <leader>( :tabprev<cr>
nnoremap <leader>) :tabnext<cr>

" Wrap toggle
nnoremap <leader>W :set wrap!<cr>

" Insert blank lines with Enter
nnoremap <cr> o<esc>
nnoremap <S-cr> O<esc>

" Split lines
nnoremap S i<cr><esc><right>

" Copying/pasting test to system clipboard
" TODO

" Yank to EOL
nnoremap Y y$

" Clean trailing whitespace
nnoremap <leader>ww mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" Select yanked section
nnoremap <leader>V V`]

" Select entire buffer
nnoremap vaa ggvGg_
nnoremap Vaa ggVG

" Uppercase word
    " Usage: type in lowercase, and at the end, press <c-u> to uppercase it.
inoremap <C-u> <esc>mzgUiw`za

" Substitute
nnoremap <leader>s :%s/

" Select contents of current line excluding indentation
nnoremap vv ^vg_

" Typos
command! -bang E e<bang>
command! -bang Q q<bang>
command! -bang W w<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Wq wq<bang>
command! -bang WQ wq<bang>

" Open current directory in Finder
nnoremap <leader>O :!open .<cr>

" Zip Right
" Move character under cursor to EOL. Useful for when you mis-typed print()foo.
nnoremap zl :let@z=@"<cr>x$p:let @"=@z<cr>

" }}}

" >> Search & Movement ------------------------------------------------------{{{

" Ripgrep
nnoremap <leader>g :Rg<cr>

" Use sane regexes
nnoremap / /\v
vnoremap / /\v

set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set gdefault

set scrolloff=5
set sidescroll=1
set sidescrolloff=10

" Clear search highlighting
nnoremap <leader><space> :let @/=""<cr>

" Keep search matches in the middle of the window
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz
nnoremap <c-o> <c-o>zz

" Substitute
nnoremap <leader>s :%s/

" Delete to EOL
nnoremap D d$

" Aliases for start/end of line
noremap H ^
noremap L $
vnoremap L g_

" Move by displayed lines
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" Easy buffer navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

noremap <leader>v <C-w>v

" Matchit uses Tab now to go to the matching paren, brace, etc.
runtime macros/matchit.vim
map <tab> %
silent! unmap [%
silent! unmap ]%

" }}}

" >> Folding ----------------------------------------------------------------{{{

set foldlevelstart=0

" Fold Markers
set foldmethod=marker
set foldmarker={{{,}}}

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" }}}

" >> Plugin-specific --------------------------------------------------------{{{

" Ale
let g:ale_c_parse_makefile = 1
let g:ale_c_parse_compile_commands = 1
let g:ale_cpp_gcc_options='-std=c++17'

" NERDTree
noremap <leader>N :NERDTreeToggle<cr>
let NERDTreeMinimalUI = 1

	" Close Vim if NERDTree is the only open window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

	" Folders
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:DevIconsDefaultFolderOpenSymbol = ''

	" Hide file node arrows
let NERDTreeDirArrowExpandable = "\u00a0"
let NERDTreeDirArrowCollapsible = "\u00a0"
"let NERDTreeNodeDelimiter = "\x0"

	" Hide current directory line
augroup nerdtreehidecwd
	autocmd!
	autocmd FileType nerdtree setlocal conceallevel=3 | syntax match NERDTreeHideCWD #^[</].*$# conceal
augroup end

	" Automatically open NERDTree
"autocmd vimenter * NERDTree | wincmd p

" Vim-Devicons
if has("gui_running")
    let g:webdevicons_conceal_nerdtree_brackets = 1
    let g:WebDevIconsNerdTreeAfterGlyphPadding = ''
endif

" Tabular
    " Tab equal signs equally
if exists(":Tabularize")
    nmap <Leader>a= :Tabularize /=<CR>
    vmap <Leader>a= :Tabularize /=<CR>
    nmap <Leader>a: :Tabularize /:\zs<CR>
    vmap <Leader>a: :Tabularize /:\zs<CR>
endif

" Coc
let g:SuperTabDefaultCompletionType="<c-n>"

" Pasta
nnoremap <leader>p p`[v`]=

" FZF
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

	" Ripgrep
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Lightline
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'filetype' ] ],
      \ },
      \ 'colorscheme': 'base16_github',
      \ }

let g:lightline.subseparator = { 'left': '', 'right': '' }

" Tagbar
"noremap <leader>t :Tagbar<cr>

" }}}
