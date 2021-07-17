" Set leader for other settings to use.
let mapleader = " "
set timeoutlen=500

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"dein Scripts-----------------------------
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if &compatible
  set nocompatible
endif

" Required:
set runtimepath+=~/vim-dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('~/vim-dein/')

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" General
call dein#add('neoclide/coc.nvim', {'merged': 0, 'rev': 'release'})
call dein#add('scrooloose/nerdcommenter')
call dein#add('tpope/vim-surround')
call dein#add('w0rp/ale')
call dein#add('sheerun/vim-polyglot')
" Themes
call dein#add('morhetz/gruvbox')
call dein#add('mhartington/oceanic-next')
call dein#add('arcticicestudio/nord-vim')
call dein#add('nathanaelkane/vim-indent-guides')
" Navigation & git
call dein#add('junegunn/fzf', {'hook_post_update': 'call fzf#install()'})
call dein#add('junegunn/fzf.vim')
call dein#add('preservim/nerdtree')
call dein#add('Xuyuanp/nerdtree-git-plugin')
call dein#add('airblade/vim-gitgutter')
call dein#add('terryma/vim-multiple-cursors')
call dein#add('easymotion/vim-easymotion')
" Status bar
call dein#add('tpope/vim-fugitive')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
" Markdown
call dein#add('plasticboy/vim-markdown', {'on_ft': 'markdown'})

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" easymotion
let g:EasyMotion_keys = 'aoeusnthidlrcg12340987'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CoC

set hidden
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
\  pumvisible() ? "\<C-n>" :
\  <SID>check_back_space() ? "\<TAB>" :
\  coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Automatically close preview after completion. [^[] prevents it from running on command line editing (:C-f).
autocmd CursorMoved [^[] if &previewwindow != 1 | pclose | endif

call coc#add_extension('coc-tsserver')
call coc#add_extension('coc-emoji')
call coc#add_extension('coc-json')
call coc#add_extension('coc-emmet')
call coc#add_extension('coc-css')

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <C-f> <Plug>(coc-fix-current)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indent Lines
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ale
let g:ale_sign_error = '🙈'
let g:ale_sign_warning = '🤷'
let g:ale_statusline_format = ['X %d', '? %d', '']
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_fixers['typescript'] = ['prettier']
let g:ale_fixers['json'] = ['prettier']
let g:ale_fixers['html'] = ['prettier']
let g:ale_fixers['css'] = ['prettier']
let g:ale_fixers['scss'] = ['prettier']
let g:ale_fixers['markdown'] = ['prettier']
let g:ale_fixers['yaml'] = ['prettier']
let g:ale_fixers['graphql'] = ['prettier']
let g:ale_fixers['javascriptreact'] = ['prettier']
let g:ale_fixers['typescriptreact'] = ['prettier']
let g:ale_fixers['haskell'] = ['brittany']
let g:ale_fixers['terraform'] = ['terraform']
let g:ale_linters = {}
let g:ale_linters['haskell'] = ['stack_build']
let g:ale_linters['terraform'] = ['tflint']
let g:ale_fix_on_save = 1
nmap <silent> ]e <Plug>(ale_next_wrap)
nmap <silent> [e <Plug>(ale_previous_wrap)

" COC handles LSP, so disabled that in ale.
let g:ale_disable_lsp = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nerd-commenter
nmap <leader>c <plug>NERDCommenterToggle
vmap <leader>c <plug>NERDCommenterToggle

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nerd-tree
map <leader>t :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" theme
set termguicolors
syntax enable
colorscheme nord
set background=dark
let g:airline_theme='nord'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fzf
command! -nargs=* -bang Contents call fzf#vim#grep(
\  'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>),
\  1,
\  fzf#vim#with_preview({ 'options': '--delimiter : --nth 4..'}),
\  <bang>0
\)

noremap <C-b> :Buffers!<CR>
noremap <C-p> :Files!<CR>
noremap <C-g> :Contents!<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" easymotion
map <leader> <Plug>(easymotion-prefix)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Nvim terminal
tmap <leader><esc> <C-\><C-n>
autocmd TermOpen * setlocal bufhidden=hide
autocmd TermOpen * setlocal signcolumn=no
autocmd TermOpen * setlocal number&
autocmd TermEnter * setlocal relativenumber&
" Change window size to make space for relative numbers
autocmd TermEnter * 4winc <
autocmd TermLeave * 4winc >
autocmd TermLeave * setlocal relativenumber

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" airline:
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
set hidden
let g:airline_symbols.space = "\ua0"
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#buffer_idx_format = {
\  '0': '0 ',
\  '1': '1 ',
\  '2': '2 ',
\  '3': '3 ',
\  '4': '4 ',
\  '5': '5 ',
\  '6': '6 ',
\  '7': '7 ',
\  '8': '8 ',
\  '9': '9 ',
\}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=2000

" Set to auto read when a file is changed from the outside
set autoread

" Fix weird behavior or Y.
nmap Y y$

" n always down; N always up.
nnoremap <expr> n  'Nn'[v:searchforward]
xnoremap <expr> n  'Nn'[v:searchforward]
onoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]
xnoremap <expr> N  'nN'[v:searchforward]
onoremap <expr> N  'nN'[v:searchforward]

" Prevent replace from overwriting paste buffer.
function! IsSelectionAtEndOfLine()
  let endOfLine = virtcol('$') - 1
  let startOfSelection = virtcol('v')
  let endOfSelection = virtcol('.')
  return endOfSelection ==# endOfLine || startOfSelection ==# endOfLine
endfunction
vnoremap <expr> p IsSelectionAtEndOfLine() ? '"_dp' : '"_dP'

" Copy to system clipboard.
set clipboard+=unnamedplus

" Align blocks of text and keep them selected
vmap < <gv
vmap > >gv

" Easier change window.
nnoremap <expr> <tab> (winnr('$') == 1) ? "\<C-w>v\<C-w>\<C-w>" : "\<C-w>\<C-w>"

" Clear search highlighting.
nnoremap <silent> <esc> :noh<cr>

nnoremap Q <nop>

" Prevent nested Neovim when editing Git files.
if has('nvim')
  let $GIT_EDITOR = 'nvr -cc split --remote-wait'
endif
autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore+=*.o,*~,*.pyc

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

set relativenumber
set number

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" I don't use folds, so disable them
set nofoldenable

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Return to last edit position when opening files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufReadPost *
\  if line("'\"") > 0 && line("'\"") <= line("$") |
\    exe "normal! g`\"" |
\  endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc. anyway
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" Linebreak on 100 characters
"set lbr
"set tw=100

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

set title

set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" multi-cursor
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-u>'
let g:multi_cursor_skip_key='<C-s>'
let g:multi_cursor_quit_key='<Esc>'
let g:multi_cursor_exit_from_insert_mode=0

" prevent multi-cursors + coc to interfere.
func! Multiple_cursors_before()
  CocDisable
  ALEDisable
endfunc
func! Multiple_cursors_after()
  CocEnable
  ALEEnable
endfunc

highlight multiple_cursors_cursor gui=inverse,bold
highlight multiple_cursors_visual gui=NONE guibg=LightYellow
