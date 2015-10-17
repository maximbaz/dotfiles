" First-priority configuration {{{
  set nocompatible
  let &encoding = "utf-8"
  scriptencoding utf-8
  set mousehide
  autocmd!
" }}}
" Bundles {{{
  filetype off
  " NeoBundle configuration {{{
    if has("vim_starting")
      set rtp+=~/.vim/bundle/neobundle.vim/
    endif
    let path = "~/.vim/bundle"
    call neobundle#begin(expand(path))
  " }}}
  " Core plugins {{{
    NeoBundleFetch 'Shougo/neobundle.vim'

    NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \   'windows' : 'nmake -f make_msvc.mak nodebug=1',
      \   'cygwin': 'make -f make_cygwin.mak',
      \   'mac': 'make -f make_mac.mak',
      \   'linux': 'make',
      \   'unix': 'gmake',
      \  }
      \ }
    NeoBundle 'Shougo/unite.vim'                " Fuzzy search on everything
    NeoBundle 'bling/vim-airline'               " Nice bottom bar
    NeoBundle 'tpope/vim-repeat'                " Repeat for plugins
    NeoBundle 'tpope/vim-abolish'               " Substitute with Smart Case (:S//)
    NeoBundle 'tomasr/molokai'                  " Nice color theme
    NeoBundle 'scrooloose/nerdtree'             " Folder tree
    NeoBundle 'Lokaltog/vim-easymotion'         " Move to any character
    NeoBundle 'christoomey/vim-tmux-navigator'  " Easy navigation between TMUX and VIM splits
    NeoBundle 'moll/vim-bbye'                   " Keep window when closing a buffer
  " }}}
  " Development {{{
    NeoBundle 'scrooloose/syntastic'            " Linters
    NeoBundle 'tomtom/tcomment_vim'             " Comment lines
    " Haskell {{{
      NeoBundle 'eagletmt/ghcmod-vim'
      NeoBundle 'eagletmt/neco-ghc'
      NeoBundle 'bitc/vim-hdevtools'
    " }}}
    " HTML {{{
      NeoBundle 'othree/html5.vim'
      NeoBundle 'mattn/emmet-vim'
    " }}}
    " Jade {{{
      NeoBundle 'digitaltoad/vim-jade'
    " }}}
    " Python {{{
      NeoBundle 'klen/python-mode'
      NeoBundle 'wmvanvliet/vim-ipython'
    "}}}
    " Ruby {{{
      NeoBundle 'tpope/vim-rails'
      NeoBundle 'tpope/vim-endwise'
    " }}}
    " Rust {{{
      NeoBundle 'wting/rust.vim'
    " }}}
    " Switch (true -> false, etc.) {{{
      NeoBundle 'AndrewRadev/switch.vim'
    " }}}
    " Syntaxes {{{
      NeoBundle 'elzr/vim-json'
      NeoBundle 'ap/vim-css-color'
      NeoBundle 'slim-template/vim-slim'
      NeoBundle 'lcharlick/vim-coffee-script'
      NeoBundle 'travitch/hasksyn'
      NeoBundle 'z0rch/vim-markdown'
    " }}}
    " Snippets {{{
      NeoBundle 'Shougo/neosnippet.vim'
      NeoBundle 'honza/vim-snippets.git'
    " }}}
    " Version control systems {{{
      NeoBundle 'tpope/vim-fugitive'
      NeoBundle 'mhinz/vim-signify'
    " }}}
  " }}}
   " Text editing {{{
     NeoBundle 'godlygeek/tabular'              " Align text
     NeoBundle 'Shougo/neocomplete.vim'         " Autocomplete
     NeoBundle 'tpope/vim-surround'             " Surround
     NeoBundle 'Raimondi/delimitMate'           " Automatically insert closing brackets
     NeoBundle 'vim-scripts/LargeFile'          " Open large file
   " }}}
   call neobundle#end()
" }}}
" Environment {{{
  " General {{{
    syntax on
    filetype plugin indent on
    set backspace=2
    set scrolloff=5
    set sidescrolloff=10
    set selection=inclusive
    set selectmode=
    set virtualedit=all
    set diffopt+=iwhite
    set foldmethod=marker
    set formatoptions+=j
    set keymodel-=stopsel
    set autoindent
    set cursorline
    set cursorcolumn
    set hidden
    set nohlsearch
    set ignorecase
    set incsearch
    set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz,ЖжЭэХхЪъ;\:\;\"\'{[}]
    set linebreak
    set list
    set listchars=tab:»·,trail:·,nbsp:·
    set number
    set nrformats=
    set nostartofline
    set relativenumber
    set ruler
    set smartcase
    set showcmd
    set nospell
    set splitbelow
    set splitright
    set wildmenu
    set wrap
  "}}}
  " Tabs {{{
    set expandtab
    set shiftwidth=2
    set tabstop=2
  " }}}
  " Theme {{{
    colorscheme molokai
    let &term="xterm-256color"
    let &t_Co = 256
    set t_ut=
    let g:rehash256 = 1
    let g:molokai_original = 1
    let &background = "dark"
    let &guifont = "Powerline\ Consolas\ 11"
    set guioptions+=c
    set guioptions-=T
    set guioptions-=m
    hi Normal guibg=none ctermbg=none
    hi LineNr guibg=none ctermbg=none
  " }}}
  " Backup {{{
    let &history = 100
    let &undolevels = 100
    set nobackup
    set noswapfile
  " }}}
" }}}
NeoBundleCheck
" Plugins configuration {{{
  " Airline {{{
    let &laststatus = "2"
    if !exists("g:airline_symbols")
      let g:airline_symbols = {}
    endif

    let g:airline_powerline_fonts                   = 1
    let g:airline_section_c                         = airline#section#create(["%{getcwd()}", g:airline_symbols.space, 'readonly'])
    let g:airline_section_x                         = "%{&filetype}"
    let g:airline#extensions#branch#empty_message   = "no git"
    let g:airline#extensions#hunks#non_zero_only    = 1
    let g:airline#extensions#tabline#buffer_nr_show = 1
    let g:airline#extensions#tabline#enabled        = 1
    let g:airline#extensions#tabline#fnamecollapse  = 1
    let g:airline#extensions#tabline#tab_nr_type    = 1
    let g:airline_symbols.whitespace                = "•"
    let g:airline_theme                             = "powerlineish"
    let g:airline_loaded                            = 1
  " }}}
  " EasyMotion {{{
    nmap s <Plug>(easymotion-s)
    xmap s <Plug>(easymotion-s)
    omap z <Plug>(easymotion-s)
    nmap / <Plug>(easymotion-sn)
    xmap / <Plug>(easymotion-sn)
    omap / <Plug>(easymotion-sn)
    nmap n <Plug>(easymotion-next)
    xmap n <Plug>(easymotion-next)
    nmap N <Plug>(easymotion-prev)
    xmap N <Plug>(easymotion-prev)
    nmap L <Plug>(easymotion-bd-jk)
    xmap L <Plug>(easymotion-bd-jk)
    let g:EasyMotion_move_highlight = 0
    let g:EasyMotion_skipfoldedline = 0
  " }}}
  " IPython {{{
    let g:ipy_completefunc     = 0
    let g:ipy_cell_folding     = 0
    let g:ipy_perform_mappings = 0
  " }}}
  " NeoComplete {{{
    let g:neocomplete#enable_at_startup   = 1
    let g:neocomplete#enable_ignore_case  = 1
    let g:neocomplete#enable_smart_case   = 0
    let g:neocomplete#enable_refresh_always = 1 " TODO: only for python?

    if !exists('g:neocomplete#force_omni_input_patterns')
      let g:neocomplete#force_omni_input_patterns = {}
    endif
    let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
  " }}}
  " NeoSnippet {{{
    " Plugin key-mappings.
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)

    " SuperTab like snippets behavior.
    imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)"
    \: pumvisible() ? "\<C-n>" : "\<TAB>"
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)"
    \: "\<TAB>"

    " For snippet_complete marker.
    if has('conceal')
      set conceallevel=2 concealcursor=i
    endif

    let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
  " }}}
  " Jedi-vim {{{
    let g:jedi#popup_select_first   = 0
    let g:jedi#completions_enabled    = 0
    let g:jedi#auto_vim_configuration = 0
  " }}}
  " NERDTree {{{
    let NERDTreeChDirMode   = 2
    let NERDTreeShowBookmarks = 1
  " }}}
  " Pymode {{{
    " let g:pymode_python = 'python3'
    let g:pymode_folding = 0
    let g:pymode_rope = 0
    let g:pymode_rope_completion = 0
    let g:pymode_rope_complete_on_dot = 0
    let g:pymode_rope_lookup_project = 0
    let g:pymode_lint_checkers = ['pyflakes', 'mccabe']
  " }}}
  " Unite {{{
    let s:unite_ignores = [
      \ '\.git', '\.sass-cache', '\.cabal-sandbox', '/img/', '/tmp/' ]

    call unite#custom#source('file_rec,file_rec/async,file_mru,file,buffer,grep',
      \ 'ignore_pattern', unite#get_all_sources('file_rec')['ignore_pattern'] .
      \ join(s:unite_ignores, '\|'))

    call unite#filters#matcher_default#use(['matcher_fuzzy', 'matcher_project_ignore_files'])
    call unite#filters#sorter_default#use(['sorter_rank'])
    let g:unite_source_history_yank_enable = 1
    " TODO silversearcher
    " if executable('ag')
    "   let g:unite_source_grep_command   = 'ag'
    "   let g:unite_source_grep_default_opts  = '--line-numbers --nocolor --nogroup --hidden --smart-case'
    "   let g:unite_source_grep_recursive_opt = ''
    " endif
  " }}}
" }}}
" Keyboard shortcuts {{{
  let mapleader="\\"
  nmap <Space> <Leader>
  vmap <Space> <Leader>
  " Base {{{
    nnoremap <Leader>w :w<CR>
    nnoremap <Leader>qq ZZ

    nnoremap <Del> <nop>
    vnoremap <Del> <nop>

    nnoremap <Backspace> <nop>
    vnoremap <Backspace> <nop>
  " }}}
  " Close buffer {{{
    nnoremap <silent> <Leader>cc :Bd<CR>
    nnoremap <silent> <Leader>CC :Bd!<CR>
  " }}}
  " Edit .vimrc {{{
    nnoremap <silent> <Leader>ec :e $MYVIMRC<CR>
    nnoremap <silent> <Leader>sc :so $MYVIMRC<CR>
  " }}}
  " Format json {{{
    nnoremap <silent> <Leader>json :%!python -m json.tool<CR>
    vnoremap <silent> <Leader>json :!python -m json.tool<CR>
  " }}}
  " Go to definition {{{
    nnoremap <C-g> <C-]>
  " }}}
  " Gundo {{{
    nnoremap <F12> :GundoToggle<CR>
  " }}}
  " Increment {{{
    nnoremap <C-Up> <C-a>
    nnoremap <C-Down> <C-x>
    nnoremap <C-k> <C-a>
    nnoremap <C-j> <C-x>
  " }}}
  " Indent / unindent {{{
    nnoremap <S-Tab> <<
    inoremap <S-Tab> <C-o><<
    nnoremap <Tab> >>
    vnoremap <Tab> >gv
    vnoremap <S-Tab> <gv
  " }}}
  " IPython {{{
    nmap <Leader>ipr  <Plug>(IPython-RunLine)
    vmap <Leader>ipr  <Plug>(IPython-RunLines)
    nmap <Leader>ipc  <Plug>(IPython-RunCell)
    nmap <Leader>ipf  <Plug>(IPython-RunFile)
    nmap <Leader>ipfc <Plug>(IPython-EnableFoldByCell)
  " }}}
  " Hdevtools {{{
    nnoremap <F5> :HdevtoolsType<CR>
    nnoremap <F6> :HdevtoolsInfo<CR>
  " }}}
  " NeoBundle {{{
    nnoremap <Leader>NBi :so $MYVIMRC<CR> :NeoBundleInstall<CR>
    nnoremap <Leader>NBc :so $MYVIMRC<CR> :NeoBundleClean!<CR>
    nnoremap <Leader>NBu :so $MYVIMRC<CR> :NeoBundleUpdate<CR>
  " }}}
  " NERDTree {{{
    nnoremap <F2> :NERDTreeToggle<CR>
    nnoremap <F3> :NERDTreeFind<CR>

    let g:NERDTreeMapActivateNode="<F3>"
    let g:NERDTreeMapPreview="<F4>"
  " }}}
  " Paste & select {{{
    nnoremap gp p`[v`]
    vnoremap gp p`[v`]
    nnoremap gP P`[v`]
    vnoremap gP P`[v`]
  " }}}
  " Redo {{{
    nnoremap U <C-R>
  " }}}
  " Scroll & navigation {{{
    " Select All {{{
      noremap  <Leader>v ggVG
      inoremap <Leader>v <C-O>gg<C-O>VG
      cnoremap <Leader>v <C-C>ggVG
      onoremap <Leader>v <C-C>ggVG
      snoremap <Leader>v <C-C>ggVG
      xnoremap <Leader>v <C-C>ggVG
    " }}}
    " PageUp / PageDown by half {{{
      nnoremap <PageDown> <C-d>
      nnoremap <PageUp> <C-u>
    " }}}
    " Previous / next cursor position {{{
      nnoremap <A-Left> <C-o>
      nnoremap <A-Right> <C-i>
    " }}}
    " Windows {{{
      nnoremap <silent> <C-PageUp> :bp<CR>
      nnoremap <silent> <C-PageDown> :bn<CR>
    " }}}
    " Diff {{{
       nnoremap <F7> [c
       nnoremap <F8> ]c
    " }}}
  " }}}
  " Set syntax {{{
    nnoremap <silent> <Leader>Tmd :set filetype=markdown<CR>
    nnoremap <silent> <Leader>Tpy :set filetype=python<CR>
    nnoremap <silent> <Leader>Tru :set filetype=ruby<CR>
  " }}}
  " Smart HOME & END {{{
    nnoremap <silent><Home> :call SmartHome("n")<CR>
    nnoremap <silent><End> :call SmartEnd("n")<CR>
    inoremap <silent><Home> <C-r>=SmartHome("i")<CR>
    inoremap <silent><End> <C-r>=SmartEnd("i")<CR>
    vnoremap <silent><Home> <Esc>:call SmartHome("v")<CR>
    vnoremap <silent><End> <Esc>:call SmartEnd("v")<CR>
    " Tmux fixes {{{
      if $TERM =~ '^screen-256color'
        map  <Esc>OH <Home>
        map! <Esc>OH <Home>
        map  <Esc>[1~ <Home>
        map! <Esc>[1~ <Home>
        map  <Esc>OF <End>
        map! <Esc>OF <End>
        map  <Esc>[4~ <End>
        map! <Esc>[4~ <End>
      endif
    " }}}
  " }}}
  " Switch {{{
    nnoremap <silent> - :Switch<CR>
  " }}}
  " Tagbar {{{
    nnoremap <silent> <F9> :TagbarToggle<CR>
  " }}}
  " Trim whitespaces {{{
    nnoremap <silent> <F10> :call RemoveTrailingSpaces()<CR>
  " }}}
  " Unite {{{
    nnoremap <Leader>f :Unite -start-insert -auto-preview file_rec/async<CR>
    nnoremap <Leader>y :Unite -start-insert history/yank<CR>
    nnoremap <Leader>b :Unite -start-insert buffer<CR>
    nnoremap <Leader>g :Unite -start-insert -auto-preview grep<CR>
    nnoremap <Leader>r :UniteResume<CR>

    function! s:unite_settings()
      nmap <buffer> <Esc> <Plug>(unite_exit)
    endfunction

    autocmd FileType unite call s:unite_settings()
  " }}}
  " Write with sudo {{{
    cmap w!! w !sudo tee > /dev/null %
  " }}}
" }}}
" Functions {{{
  " Removes trailing whitespaces {{{
    function! RemoveTrailingSpaces()
      let l = line(".")
      let c = col(".")
      %s/\s\+$//e
      call cursor(l, c)
    endfunction
  " }}}
  " Smart HOME & END {{{
    function! SmartHome(mode)
      let curcol = col(".")
      "gravitate towards beginning for wrapped lines
      if curcol > indent(".") + 2
        call cursor(0, curcol - 1)
      endif
      if curcol == 1 || curcol > indent(".") + 1
        if &wrap
          normal g^
        else
          normal ^
        endif
      else
        if &wrap
          normal g0
        else
          normal 0
        endif
      endif
      if a:mode == "v"
        normal msgv`s
      endif
      return ""
    endfunction

    function! SmartEnd(mode)
      let prev_virtualedit = &virtualedit
      set virtualedit=
      let curcol = col(".")
      let lastcol = a:mode == "i" ? col("$") : col("$") - 1
      "gravitate towards ending for wrapped lines
      if curcol < lastcol - 1
        let l:charlen = byteidx(getreg('1'), 1)
        call cursor(0, curcol + l:charlen)
      endif
      if curcol < lastcol
        if &wrap
          normal g$
        else
          normal $
        endif
      else
        normal g_
      endif
      "correct edit mode cursor position, put after current character
      if a:mode == "i"
        let l:charlen = byteidx(getreg('1'), 1)
        call cursor(0, col(".") + l:charlen)
      endif
      if a:mode == "v"
        normal msgv`s
      endif
      let &virtualedit = prev_virtualedit
      return ""
    endfunction
  " }}}
" }}}
" AutoCmd {{{
  autocmd BufWritePost *.hs :GhcModCheckAndLintAsync
  autocmd FileType haskell       setlocal omnifunc=necoghc#omnifunc
  autocmd FileType css           setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript    setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python        setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml           setlocal omnifunc=xmlcomplete#CompleteTags
" }}}
