" Plugins {{{
  filetype off
  set runtimepath^=~/.vim/dein/repos/github.com/Shougo/dein.vim

  call dein#begin(expand('~/.vim/dein'))
  call dein#add('Shougo/dein.vim')

  call dein#add('morhetz/gruvbox')                                      " Nice color theme
  call dein#add('vim-airline/vim-airline')                              " Nice bottom bar
  call dein#add('vim-airline/vim-airline-themes')                       " Nice bottom bar

  call dein#add('tpope/vim-repeat')                                     " Repeat for plugins
  call dein#add('tpope/vim-surround')                                   " Surround
  call dein#add('tpope/vim-abolish')                                    " Substitute with Smart Case (:S//)
  call dein#add('tpope/vim-speeddating')                                " Increment dates
  call dein#add('tpope/vim-fugitive')                                   " Git integration
  call dein#add('airblade/vim-gitgutter')                               " Git gutter
  call dein#add('moll/vim-bbye')                                        " Keep window when closing a buffer
  call dein#add('Lokaltog/vim-easymotion')                              " Move to any character
  call dein#add('christoomey/vim-tmux-navigator')                       " Easy navigation between TMUX and VIM splits
  call dein#add('scrooloose/nerdtree')                                  " Folder tree
  call dein#add('junegunn/fzf', { 'build': './install --bin' })
  call dein#add('junegunn/fzf.vim')

  call dein#add('jiangmiao/auto-pairs')                                 " Insert closing brackets automatically
  call dein#add('tomtom/tcomment_vim')                                  " Comment lines
  call dein#add('junegunn/vim-easy-align')                              " Easy align around equals

  call dein#add('Shougo/deoplete.nvim')                                 " Fuzzy search on everything
  call dein#add('zchee/deoplete-jedi')                                  " Python autocomplete
  call dein#add('ternjs/tern_for_vim', {'build': 'npm install'})        " JS code navigation
  call dein#add('carlitux/deoplete-ternjs')                             " Javascript autocomplete
  call dein#add('osyo-manga/vim-monster')                               " Ruby autocomplete

  call dein#add('tpope/vim-endwise')                                    " Automatically put 'end' in ruby
  call dein#add('AndrewRadev/switch.vim')                               " Smart switch (true -> false, etc.)
  call dein#add('mattn/emmet-vim')                                      " HTML editing

  call dein#add('sheerun/vim-polyglot')                                 " Many many syntaxes
  call dein#add('PotatoesMaster/i3-vim-syntax')                         " i3 syntax
  call dein#add('ap/vim-css-color')                                     " Colors in CSS

  call dein#add('ludovicchabant/vim-gutentags')                         " Autogenerate CTags

  call dein#add('jceb/vim-orgmode')                                     " Org Mode

  call dein#add('neomake/neomake')                                      " Linter

  call dein#end()

  if dein#check_install()
    call dein#install()
  endif

" }}}
" Environment {{{
  " General {{{
    autocmd!
    filetype plugin indent on
    syntax on
    set scrolloff=5
    set sidescrolloff=10
    set expandtab
    set shiftwidth=2
    set tabstop=2
    set virtualedit=all
    set diffopt+=iwhite
    set foldmethod=marker
    set cursorline
    set hidden
    set ignorecase
    set lazyredraw
    set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz,ЖжЭэХхЪъ;\:\;\"\'{[}]
    set linebreak
    set list
    set listchars=tab:»·,trail:·,nbsp:·
    set mouse=
    set number
    set nrformats=
    set nohlsearch
    set nostartofline
    set noswapfile
    set relativenumber
    set ruler
    set smartcase
    set showcmd
    set splitbelow
    set splitright
    set updatetime=100
  "}}}
  " Theme {{{
    colorscheme gruvbox
    set background=dark
    set guifont=Powerline\ Consolas\ 11
    set guioptions+=c
    set guioptions-=T
    set guioptions-=m
  " }}}
" }}}
" Plugins configuration {{{
  " Vim-airline {{{
    set laststatus=2
    let g:airline_powerline_fonts = 1
    let g:airline_theme = "gruvbox"

    if !exists("g:airline_symbols")
      let g:airline_symbols = {}
    endif
    let g:airline_symbols.whitespace = "•"

    let g:airline_section_c = airline#section#create(["%{getcwd()}", g:airline_symbols.space, 'readonly'])
    let g:airline_section_x = "%{&filetype}"

    let g:airline#extensions#branch#empty_message = "no git"
    let g:airline#extensions#hunks#non_zero_only = 1
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#buffer_nr_show = 1
    let g:airline#extensions#tabline#fnamecollapse  = 1
    let g:airline#extensions#tabline#tab_nr_type = 1
  " }}}
  " EasyMotion {{{
    nmap s <Plug>(easymotion-s)
    xmap s <Plug>(easymotion-s)
    nmap / <Plug>(easymotion-sn)
    xmap / <Plug>(easymotion-sn)
    nmap n <Plug>(easymotion-next)
    xmap n <Plug>(easymotion-next)
    nmap N <Plug>(easymotion-prev)
    xmap N <Plug>(easymotion-prev)
    let g:EasyMotion_move_highlight = 0
    let g:EasyMotion_skipfoldedline = 0
  " }}}
  " Deoplete {{{
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#enable_smart_case = 1
  " }}}
  " Deoplete-jedi (Python completion) {{{
    let deoplete#sources#jedi#show_docstring = 1
  " }}}
  " Deoplete-ternjs (JS completion) {{{
    let g:tern_request_timeout = 1
    let g:tern#command = ["tern"]
    let g:tern#arguments = ["--persistent"]
  " }}}
  " Vim-monster (Ruby completion) {{{
    let g:monster#completion#rcodetools#backend = "async_rct_complete"
    let g:deoplete#sources#omni#input_patterns = { "ruby" : '[^. *\t]\.\w*\|\h\w*::' }
  " }}}
  " Neomake (linter) {{{
    let g:neomake_open_list = 2
  " }}}
  " NERDTree {{{
    let NERDTreeChDirMode   = 2
    let NERDTreeShowBookmarks = 1
  " }}}
" }}}
" Keyboard shortcuts {{{
  let mapleader="\\"
  nmap <Space> <Leader>
  vmap <Space> <Leader>
  " Base {{{
    nnoremap <Leader>w :w<CR>
    nnoremap U <C-R>
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
  " Increment {{{
    nmap <C-Up> <C-a>
    nmap <C-Down> <C-x>
    nmap <C-k> <C-a>
    nmap <C-j> <C-x>
  " }}}
  " Indent / unindent {{{
    nnoremap <S-Tab> <<
    inoremap <S-Tab> <C-o><<
    nnoremap <Tab> >>
    vnoremap <Tab> >gv
    vnoremap <S-Tab> <gv
  " }}}
  " NERDTree {{{
    nnoremap <Leader>t :NERDTreeFind<CR>
    nnoremap <Leader>T :NERDTreeToggle<CR>
    let g:NERDTreeMapActivateNode="<Leader>t"
  " }}}
  " Scroll & navigation {{{
    " Select All {{{
      noremap  <Leader>v ggVG
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
  " }}}
  " Smart HOME & END {{{
    nnoremap <silent><Home> :call SmartHome("n")<CR>
    nnoremap <silent><End> :call SmartEnd("n")<CR>
    inoremap <silent><Home> <C-r>=SmartHome("i")<CR>
    inoremap <silent><End> <C-r>=SmartEnd("i")<CR>
    vnoremap <silent><Home> <Esc>:call SmartHome("v")<CR>
    vnoremap <silent><End> <Esc>:call SmartEnd("v")<CR>
  " }}}
  " Switch {{{
    nnoremap <silent> - :Switch<CR>
  " }}}
  " Trim whitespaces {{{
    nnoremap <silent> <F10> :call RemoveTrailingSpaces()<CR>
  " }}}
  " FZF (fuzzy navigation) {{{
    nnoremap <silent> <Leader>f :Files<CR>
    nnoremap <silent> <Leader>p :GFiles<CR>
    nnoremap <silent> <Leader>b :Buffers<CR>
    nnoremap <silent> <Leader>g :Ag<CR>
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
  autocmd BufEnter * silent! lcd %:p:h  " Make Vim CD in the directory of the opened file

  " Highlight cursor line only in the active window
  autocmd WinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
" }}}

