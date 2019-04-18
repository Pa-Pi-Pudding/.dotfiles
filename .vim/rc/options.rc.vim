
" File encoding
if !exists ('g:encoding_set') || !has('nvim')
    set encoding=utf-8
    set fileencodings=utf-8,sjis,iso-2022-jp,cp932,euc-jp
    set fileencoding=utf-8
    let g:encoding_set=1
endif
scriptencoding utf-8

" guitter size fix
set signcolumn=yes

" more fast drawing
set lazyredraw
set ttyfast

" Don't create swp file
set writebackup
set nobackup
set noswapfile
set noundofile

" Show column number
set number
set relativenumber

" Long text
set wrap
set textwidth=0
set colorcolumn=256

" Highlight cursor line
" set cursorline

" Invisible stirng
set list
set listchars=tab:»-,extends:»,precedes:«,nbsp:%,eol:↲,trail:~

" Don't unload buffer when it is abandones
set hidden

" New load buffer is use open
set switchbuf=useopen

" Smart insert tab setting.
set smarttab

" Excahnge tab to space.
set expandtab

" Auto insert indent.
set autoindent

" Round indent by shiftwidth.
set shiftwidth=4

" Round indent to multipul of shiftwidth
set shiftround

" Space insert by autoindent
set tabstop=4
set scrolloff=15

" Splitting a window will put the new window below the current one.
set splitbelow
" Splitting a window will put the new window right the current one.
set splitright
" Set minimal width for current window.
set winwidth=30
" Set minimal height for current window.
set winheight=1
" Set maximam maximam command line window.
set cmdwinheight=5
" No equal window size.
set noequalalways
" Adjust window size of preview and help.
set previewheight=8
set helpheight=12

" show tab line
set showtabline=2

" Ignore case is search patterns
set ignorecase

" No ignore case when pattern has uppercase
set smartcase

" Search is incremental search
set incsearch

" Replace incremental
if exists('&inccommand')
  set inccommand=split
endif

" Show search result highlight
set hlsearch

" Share clipborad with system
if has('nvim')
    set clipboard+=unnamedplus
else
    set clipboard=unnamed
endif
set clipboard=unnamedplus
" Disable fold

" Use extend grep
if executable('rg')
    let &grepprg = 'rg --vimgrep --hidden'
    set grepformat=%f:%l:%c:%m
elseif executable('pt')
    let &grepprg = 'pt --nocolor --nogroup --column'
    set grepformat=%f:%l:%c:%m
endif

" jq command
command! -nargs=? Jq call s:Jq(<f-args>)
function! s:Jq(...)
    if 0 == a:0
        let l:arg = "."
    else
        let l:arg = a:1
    endif
    execute "%! jq \"" . l:arg . "\""
endfunction

" Number of characters to apply syntax per line
set synmaxcol=512

" Disable sql omni complete
let g:omni_sql_no_default_maps = 1

" コマンドライン補完
set wildmode=longest:full,full


"クリップボードからコピペするときにインテンドしないようにする

"""""""""""""""""""""""""""""""""""""""""""""""""""""
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""
" 最後のカーソル位置を復元する
""""""""""""""""""""""""""""""
if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif
""""""""""""""""""""""""""""""
"背景の透過-----------------------------------
augroup TransparentBG
  	autocmd!
	autocmd Colorscheme * highlight Normal ctermbg=none
	autocmd Colorscheme * highlight NonText ctermbg=none
	autocmd Colorscheme * highlight LineNr ctermbg=none
	autocmd Colorscheme * highlight Folded ctermbg=none
	autocmd Colorscheme * highlight EndOfBuffer ctermbg=none 
augroup END
"---------------------------------------------

set wildmenu
