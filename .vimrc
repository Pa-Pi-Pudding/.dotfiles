" magic word before
filetype off
filetype plugin indent off

" other vimrc source util
function! s:source_rc(path, ...) abort 
  let l:use_global = get(a:000, 0, !has('vim_starting'))
  let l:abspath = resolve(expand('~/.vim/rc/' . a:path))
  if !l:use_global
    execute 'source' fnameescape(l:abspath)
    return
  endif

  " substitute all 'set' to 'setglobal'
  let l:content = map(readfile(l:abspath),
        \ 'substitute(v:val, "^\\W*\\zsset\\ze\\W", "setglobal", "")')
  " create tempfile and source the tempfile
  let l:tempfile = tempname()
  try
    call writefile(l:content, l:tempfile)
    execute 'source' fnameescape(l:tempfile)
  finally
    if filereadable(l:tempfile)
      call delete(l:tempfile)
    endif
  endtry
endfunction

" echo message vim start up time
if has('vim_starting') && has('reltime')
    augroup VimStart
        autocmd!
        let g:startuptime = reltime()
        autocmd VimEnter * let g:startuptime = reltime(g:startuptime) | redraw | echomsg 'startuptime: ' . reltimestr(g:startuptime)
    augroup END
endif

let $CACHE = expand('~/.cache')

if !isdirectory(expand($CACHE))
  call mkdir(expand($CACHE), 'p')
endif

" Load python3
 if isdirectory(expand($PYENV_PATH))
     let g:python_host_prog = $PYENV_PATH . '/versions/neovim2/bin/python'
     let g:python3_host_prog = $PYENV_PATH . '/versions/neovim3/bin/python'
 endif
 if isdirectory(expand($ANYENV_PATH))
     let g:python_host_prog = $ANYENV_PATH . '/envs/pyenv/versions/neovim2/bin/python'
     let g:python3_host_prog = $ANYENV_PATH . '/envs/pyenv/versions/neovim3/bin/python'
 endif

" Load dein.
let s:dein_dir = finddir('dein.vim', '.;')
if s:dein_dir !=# '' || &runtimepath !~# '/dein.vim'
  if s:dein_dir ==# '' && &runtimepath !~# '/dein.vim'
    let s:dein_dir = expand('$CACHE/dein')
          \. '/repos/github.com/Shougo/dein.vim'
    if !isdirectory(s:dein_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
    endif
  endif
  execute 'set runtimepath^=' . substitute(
        \ fnamemodify(s:dein_dir, ':p') , '/$', '', '')
endif

 call s:source_rc('mappings.rc.vim')
 call s:source_rc('options.rc.vim')
 call s:source_rc('filetype.rc.vim')
 call s:source_rc('autocmd.rc.vim')
 call s:source_rc('dein.rc.vim')

" Reload .vimrc
nnoremap <Space>s :source $HOME/.vimrc<CR>

" Colors
set t_Co=256
set background=dark
colorscheme iceberg

" magic word after
filetype plugin indent on
syntax enable

" インストールされていないプラグインがあればgithub.comからインストールする
" If you want to install not installed plugins on startup.
 if dein#check_install()
   call dein#install()
 endif
" パワーラインでかっこよく
let g:airline_powerline_fonts = 1
" カラーテーマ指定してかっこよく
let g:airline_theme = 'jellybeans'
" タブバーをかっこよく
let g:airline#extensions#tabline#enabled = 1

" 選択行列の表示をカスタム(デフォルトだと長くて横幅を圧迫するので最小限に)
let g:airline_section_z = airline#section#create(['windowswap', '%3p%% ', 'linenr', ':%3v'])

" virtulenvを認識しているか確認用に、現在activateされているvirtualenvを表示(vim-virtualenvの拡張)
let g:airline#extensions#virtualenv#enabled = 1

" gitのHEADから変更した行の+-を非表示(vim-gitgutterの拡張)
let g:airline#extensions#hunks#enabled = 0
