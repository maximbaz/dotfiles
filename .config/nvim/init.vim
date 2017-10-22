""" Plugins
filetype off
set runtimepath^=~/.cache/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.cache/dein'))
call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim', {'build' : 'make'})

call dein#add('morhetz/gruvbox')                                      " Nice color theme
call dein#add('vim-airline/vim-airline')                              " Nice bottom bar
call dein#add('vim-airline/vim-airline-themes')                       " Nice bottom bar themes
call dein#add('osyo-manga/vim-anzu')                                  " Show search count
call dein#add('yuttie/comfortable-motion.vim')                        " Smooth scroll
call dein#add('tpope/vim-sleuth')                                     " Automatically detect tabs vs spaces

call dein#add('tpope/vim-repeat')                                     " Repeat for plugins
call dein#add('vim-scripts/visualrepeat')                             " Repeat for plugins in visual mode
call dein#add('tpope/vim-surround')                                   " Surround
call dein#add('tpope/vim-abolish')                                    " Substitute with Smart Case (:S//)
call dein#add('tpope/vim-speeddating')                                " Increment dates
call dein#add('tpope/vim-fugitive')                                   " TODO Git integration
call dein#add('airblade/vim-gitgutter')                               " Git gutter
call dein#add('moll/vim-bbye')                                        " Keep window when closing a buffer
call dein#add('haya14busa/incsearch.vim')                             " Incremental search
call dein#add('haya14busa/incsearch-fuzzy.vim')                       " Fuzzy incremental search
call dein#add('justinmk/vim-sneak')                                   " Improved F and T
call dein#add('t9md/vim-smalls')                                      " Quick jump anywhere
call dein#add('haya14busa/vim-asterisk')                              " Star * improvements
call dein#add('christoomey/vim-tmux-navigator')                       " Easy navigation between TMUX and VIM splits
call dein#add('airblade/vim-rooter')                                  " Change working directory to the project root
call dein#add('junegunn/fzf', {'build': './install --bin'})           " Fuzzy search - binary
call dein#add('junegunn/fzf.vim')                                     " Fuzzy search - vim plugin

call dein#add('Raimondi/delimitMate')                                 " Insert closing brackets automatically
call dein#add('tomtom/tcomment_vim')                                  " Comment lines
call dein#add('junegunn/vim-easy-align')                              " Easy align around equals
call dein#add('vim-scripts/VisIncr')                                  " Generate increasing number column

call dein#add('SirVer/ultisnips')                                     " Snippet engine
call dein#add('honza/vim-snippets')                                   " List of snippets

call dein#add('Shougo/deoplete.nvim')                                 " Fuzzy search on everything
call dein#add('Shougo/neco-vim')                                      " Vim autocomplete
call dein#add('eagletmt/neco-ghc')                                    " Haskell autocomplete
call dein#add('zchee/deoplete-jedi')                                  " Python autocomplete
call dein#add('carlitux/deoplete-ternjs')                             " Javascript autocomplete
call dein#add('fishbullet/deoplete-ruby')                             " Ruby autocomplete
call dein#add('wellle/tmux-complete.vim')                             " Autocomplete from Tmux panes
call dein#add('Shougo/neoinclude.vim')                                " Included files autocomplete
call dein#add('zchee/deoplete-go', {'build': 'make'})                 " Go autocomplete

call dein#add('tpope/vim-endwise')                                    " Automatically put 'end' in ruby
call dein#add('alvan/vim-closetag')                                   " Automatically put closing tag in XML
call dein#add('mattn/emmet-vim')                                      " TODO HTML editing
call dein#add('AndrewRadev/splitjoin.vim')                            " TODO Toggle single-line and multi-line expressions

call dein#add('sheerun/vim-polyglot')                                 " Many many syntaxes
call dein#add('ap/vim-css-color')                                     " Colors in CSS
call dein#add('vim-scripts/SyntaxRange')                              " A different syntax for a region of file
call dein#add('suan/vim-instant-markdown',
      \ {'build': 'npm -g install instant-markdown-d'})               " Instantly preview markdown

call dein#add('sbdchd/neoformat')                                     " Automatically format code

call dein#add('neovimhaskell/haskell-vim')                            " Better syntax highlight and indentation
call dein#add('eagletmt/ghcmod-vim')                                  " Ghc Mod
call dein#add('enomsg/vim-haskellConcealPlus')                        " Use unicode symbols for haskell keywords
call dein#add('Twinside/vim-hoogle')                                  " Query hoogle
call dein#add('mpickering/hlint-refactor-vim')                        " Fix lint issues
call dein#add('fatih/vim-go')                                         " Go development

call dein#add('neomake/neomake')                                      " Linter

call dein#add('wellle/targets.vim')                                                   " Add more targets to operate on
call dein#add('kana/vim-textobj-user')                                                " Add user-defined text objects
call dein#add('jceb/vim-textobj-uri', {'depends': 'vim-textobj-user'})                " TODO Text object: URI
call dein#add('thinca/vim-textobj-between', {'depends': 'vim-textobj-user'})          " TODO Text object: between characters
call dein#add('zandrmartin/vim-textobj-blanklines', {'depends': 'vim-textobj-user'})  " TODO Text object: blank lines
call dein#add('glts/vim-textobj-comment', {'depends': 'vim-textobj-user'})            " TODO Text object: comments
call dein#add('kana/vim-textobj-datetime', {'depends': 'vim-textobj-user'})           " TODO Text object: date and time
call dein#add('kana/vim-textobj-fold', {'depends': 'vim-textobj-user'})               " TODO Text object: fold
call dein#add('gilligan/textobj-gitgutter', {'depends': 'vim-textobj-user'})          " TODO Text object: git gutter hunk
call dein#add('kana/vim-textobj-indent', {'depends': 'vim-textobj-user'})             " TODO Text object: similarly indented text
call dein#add('kana/vim-textobj-line', {'depends': 'vim-textobj-user'})               " TODO Text object: line
call dein#add('saaguero/vim-textobj-pastedtext', {'depends': 'vim-textobj-user'})     " TODO Text object: pasted text
call dein#add('paulhybryant/vim-textobj-path', {'depends': 'vim-textobj-user'})       " TODO Text object: file path
call dein#add('saihoooooooo/vim-textobj-space', {'depends': 'vim-textobj-user'})      " TODO Text object: space characters
call dein#add('Julian/vim-textobj-variable-segment', {'depends': 'vim-textobj-user'}) " TODO Text object: segments of variable_names
call dein#add('whatyouhide/vim-textobj-xmlattr', {'depends': 'vim-textobj-user'})     " TODO Text object: XML attributes

call dein#end()

if dein#check_install()
  call dein#install()
endif

""" Environment
"""" General
filetype plugin indent on
syntax on
set scrolloff=5
set sidescrolloff=10
set expandtab
set shiftwidth=2
set tabstop=2
set virtualedit=all
set diffopt+=iwhite
let &fillchars="vert:|,fold:-,diff: "
set complete+=kspell
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
set nostartofline
set noswapfile
set report=0
set ruler
set smartcase
set showcmd
set nospell
set spelllang=en,da,ru
set splitbelow
set splitright
set updatetime=100
set wildmode=longest,list,full

"""" Theme
set termguicolors
set background=dark
let g:gruvbox_italic=1
colorscheme gruvbox
set guifont=Consolas\ 11
set guioptions+=c
set guioptions-=T
set guioptions-=m
set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20

""" Plugins configuration
"""" Airline
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
let g:airline#extensions#tabline#fnamecollapse  = 1

"""" DelimitMate
let delimitMate_expand_cr = 1

"""" FZF
" Make :Ag not match file names, only file contents
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

"""" Go
let g:go_fmt_autosave = 0   " This is already done by Neoformat
let g:go_auto_type_info = 1 " Show type of anything under cursor
let g:go_updatetime = 0     " Do not override updatetime

let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_types = 1

"""" GitGutter
let g:gitgutter_map_keys = 0

"""" Incsearch
let g:incsearch#auto_nohlsearch = 1

"""" Smalls
let g:smalls_auto_jump = 1

"""" Deoplete
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#max_menu_width = 80

"""" Deoplete-jedi (Python completion)
let deoplete#sources#jedi#show_docstring = 1

"""" Deoplete-ternjs (JS completion)
let g:tern_request_timeout = 1
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]

"""" Haskell Conceal
let hscoptions="𝐒𝐓𝐄𝐌wRTBQZDC"

"""" Haskell vim
let g:haskell_indent_disable = 1

"""" Neco-ghc
let g:necoghc_enable_detailed_browse = 1

"""" Hlint refactor
let g:hlintRefactor#disableDefaultKeybindings = 1

"""" Neomake (linter)
let g:neomake_open_list = 2

"""" TComment
let g:tcommentTextObjectInlineComment = ''

"""" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"

""" Keyboard shortcuts
"""" Base
let mapleader="\\"
nmap <Space> <Leader>
vmap <Space> <Leader>

" Write buffer
nnoremap <Leader>w :w<CR>

" Better redo
nnoremap U <C-R>

" Remove annoyance
nnoremap <Del> <nop>
vnoremap <Del> <nop>
nnoremap <Backspace> <nop>
vnoremap <Backspace> <nop>
nnoremap Q <nop>

" Yank line without spaces
nnoremap <expr> Y 'my^"'.v:register.v:count1.'yg_`y'

" Repeat last substitute with flags
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" Select most recent paste
nmap gV vgb

" Copy to system clipboard
nnoremap <Leader>y "+y
vnoremap <Leader>y "+y

" Paste from system clipboard
nnoremap <Leader>p "+p
vnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>P "+P

" Delete, not cut
nnoremap <Leader>d "_d
vnoremap <Leader>d "_d

" Paste in visual mode multiple times
xnoremap p pgvy

" Navigate through autocompletion
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>

" Navigate through location list
nmap <C-n> :lnext<CR>
nmap <C-p> :lprev<CR>

" Scroll command history
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>

" Increment
nmap <C-Up> <C-a>
nmap <C-Down> <C-x>

" Close buffer and window
nnoremap <silent> <Leader>cc :Bd<CR>
nnoremap <silent> <Leader>CC :Bd!<CR>
nnoremap <Leader>cw :close<CR>

" Write with sudo
cnoremap w!! w !sudo tee > /dev/null %

" Edit .vimrc
nnoremap <silent> <Leader>ec :e $MYVIMRC<CR>
nnoremap <silent> <Leader>sc :so $MYVIMRC<CR>

" Navigate through visual lines
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" Indent / unindent
nnoremap <S-Tab> <<
nnoremap <Tab> >>
xnoremap <Tab> >gv
xnoremap <S-Tab> <gv

" Select all
nnoremap <Leader>v ggVG
xnoremap <Leader>v <C-C>ggVG

" PageUp / PageDown by half of the screen
nmap <PageDown> <C-d>
nmap <PageUp> <C-u>

" Jump to previous / next cursor position
nnoremap <A-Left> <C-o>
nnoremap <A-Right> <C-i>

" Buffer navigation
nnoremap <silent> <C-PageUp> :bp<CR>
nnoremap <silent> <C-PageDown> :bn<CR>

" Fix 'gx' to support '?' in URLs
nmap gx mxviugx<Esc>`x

" Change tab size
nnoremap <silent><Leader>cst :setlocal ts=4 sts=4 noet <bar> retab! <bar> setlocal ts=2 sts=2 et <bar> retab<CR>

"""" Asterisk
map *  <Plug>(incsearch-nohl0)<Plug>(asterisk-z*)
map #  <Plug>(incsearch-nohl0)<Plug>(asterisk-z#)
map g* <Plug>(incsearch-nohl0)<Plug>(asterisk-gz*)
map g# <Plug>(incsearch-nohl0)<Plug>(asterisk-gz#)

"""" EasyAlign
nmap <Leader>= <Plug>(EasyAlign)
xmap <Leader>= <Plug>(EasyAlign)

"""" FZF (fuzzy navigation)
nnoremap <silent> <Leader>f :Files<CR>
nnoremap <silent> <Leader>F :Files ~<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>G :Ag<CR>

"""" Ghc-mod
nnoremap <silent> <leader>ht :w<CR>:GhcModType<CR>:GhcModTypeClear<CR>
nnoremap <silent> <leader>hT :w<CR>mh0:GhcModTypeInsert<CR>`h
nnoremap <silent> <leader>hi :w<CR>:GhcModInfo<CR>
nnoremap <silent> <leader>hI :HoogleInfo<CR>

"""" GitGutter
nmap ]c <Plug>GitGutterNextHunk<Plug>GitGutterPreviewHunk<Bar>zv
nmap [c <Plug>GitGutterPrevHunk<Plug>GitGutterPreviewHunk<Bar>zv
nmap <Leader>ga <Plug>GitGutterStageHunk
nmap <Leader>gu <Plug>GitGutterUndoHunk
nmap <Leader>gp <Plug>GitGutterPreviewHunk

"""" Hlint refactor
nnoremap <silent> <leader>hr :call ApplyOneSuggestion()<CR>
nnoremap <silent> <leader>hR :call ApplyAllSuggestions()<CR>

"""" Incsearch
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

map z/ <Plug>(incsearch-fuzzy-/)
map z? <Plug>(incsearch-fuzzy-?)
map zg/ <Plug>(incsearch-fuzzy-stay)

map n <Plug>(incsearch-nohl)<Plug>(anzu-n-with-echo)zMzv
map N <Plug>(incsearch-nohl)<Plug>(anzu-N-with-echo)zMzv

"""" Neomake
nnoremap <Leader>m :w <bar> Neomake<CR>

"""" Repeat macro over visual selection
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

"""" Smalls
nmap s <Plug>(smalls)
xmap s <Plug>(smalls)
omap s <Plug>(smalls)

"""" Smart HOME & END
nnoremap <silent><Home> :call SmartHome("n")<CR>
nnoremap <silent><End> :call SmartEnd("n")<CR>
inoremap <silent><Home> <C-r>=SmartHome("i")<CR>
inoremap <silent><End> <C-r>=SmartEnd("i")<CR>
vnoremap <silent><Home> <Esc>:call SmartHome("v")<CR>
vnoremap <silent><End> <Esc>:call SmartEnd("v")<CR>

"""" Sneak
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F

nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T

"""" Switch
nnoremap <silent> - :Switch<CR>

"""" TextManip
nmap <A-j> <Plug>(textmanip-move-down)
nmap <A-k> <Plug>(textmanip-move-up)
xmap <A-j> <Plug>(textmanip-move-down)
xmap <A-k> <Plug>(textmanip-move-up)

""""" Trim whitespaces
nnoremap <silent> <F10> :call RemoveTrailingSpaces()<CR>

""" Functions
"""" Removes trailing whitespaces
function! RemoveTrailingSpaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfunction

"""" Smart HOME & END
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

"""" Toggle automatic code formatting
function! ToggleAutoFormatCode()
  if !exists('#AutoFormatCode#BufWritePre')
    augroup AutoFormatCode
      autocmd!
      autocmd BufWritePre * Neoformat
    augroup END
  else
    augroup AutoFormatCode
      autocmd!
    augroup END
  endif
endfunction
command! ToggleAutoFormatCode :call ToggleAutoFormatCode()
call ToggleAutoFormatCode() " Enable by default

"""" Incsearch keymap fixes
function! s:incsearch_keymap()
  IncSearchNoreMap <C-j> <Down>
  IncSearchNoreMap <C-k> <Up>
endfunction

"""" Repeat macro over visual selection
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

""" Commands
"""" Loop cnext / cprev / lnext / lprev
command! Cnext try | cnext | catch | cfirst | catch | endtry
command! Cprev try | cprev | catch | clast | catch | endtry
command! Lnext try | lnext | catch | lfirst | catch | endtry
command! Lprev try | lprev | catch | llast | catch | endtry
cabbrev cnext Cnext
cabbrev cprev CPrev
cabbrev lnext Lnext
cabbrev lprev Lprev

""" AutoCmd
augroup incsearch-keymap
  autocmd!
  autocmd VimEnter * call s:incsearch_keymap()
augroup END

augroup helper-windows-close
  autocmd!
  autocmd BufWinEnter * if &buftype == 'quickfix' | nnoremap <buffer> q :cclose <bar> :lclose <CR> | endif
  autocmd BufWinEnter * if &buftype == 'help' | nnoremap <buffer> q :helpclose <CR> | endif
  autocmd InsertLeave * pclose
augroup END

augroup reload-files-changed-outside
  autocmd!
  autocmd BufEnter,FocusGained * checktime
augroup END

augroup fix-ultisnips-overriding-tab-visual-mode
  autocmd!
  autocmd VimEnter * xnoremap <Tab> >gv
augroup END


"" vim:foldmethod=expr:foldlevel=0
"" vim:foldexpr=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'""*')-2)\:'='
