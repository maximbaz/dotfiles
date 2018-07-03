""" Plugins
"""" Dein-begin

if &runtimepath !~# '/dein.vim'
  let s:dein_dir = expand('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  if !isdirectory(s:dein_dir)
    call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_dir))
  endif

  execute 'set runtimepath^=' . s:dein_dir
endif

call dein#begin(expand('~/.cache/dein'))

"""" Plugin manager
call dein#add('Shougo/dein.vim')
call dein#add('haya14busa/dein-command.vim')

"""" Look & feel
call dein#add('morhetz/gruvbox')                                      " Color theme
call dein#add('itchyny/lightline.vim')                                " Bottom bar
call dein#add('mgee/lightline-bufferline')                            " Top bar
call dein#add('maximbaz/lightline-trailing-whitespace')               " Trailing whitespace indicator
call dein#add('maximbaz/lightline-ale')                               " ALE indicator
call dein#add('gcavallanti/vim-noscrollbar')                          " Scrollbar for statusline
call dein#add('cskeeters/vim-smooth-scroll')                          " Smooth scroll
call dein#add('moll/vim-bbye')                                        " Keep window when closing a buffer
call dein#add('romainl/vim-qf')                                       " Quickfix / Loclist improvements

"""" Format code
call dein#add('tpope/vim-sleuth')                                     " Automatically detect tabs vs spaces
call dein#add('sbdchd/neoformat')                                     " Automatically format code
call dein#add('dhruvasagar/vim-table-mode')                           " Format tables

"""" Manipulate code
call dein#add('tpope/vim-repeat')                                     " Repeat for plugins
call dein#add('vim-scripts/visualrepeat')                             " Repeat for plugins in visual mode
call dein#add('tpope/vim-surround')                                   " Surround
call dein#add('tpope/vim-abolish')                                    " Substitute with Smart Case (:S//)
call dein#add('Raimondi/delimitMate')                                 " Insert closing brackets automatically
call dein#add('vim-scripts/VisIncr')                                  " Generate increasing number column
call dein#add('tomtom/tcomment_vim')                                  " Comment lines
call dein#add('junegunn/vim-easy-align')                              " Easy align around equals
call dein#add('tpope/vim-endwise')                                    " Automatically put 'end' in some langs
call dein#add('alvan/vim-closetag')                                   " Automatically put closing tag in XML
call dein#add('matze/vim-move')                                       " Move blocks of code

"""" Targets and text objects
call dein#add('wellle/targets.vim')                                   " Add more targets to operate on
call dein#add('kana/vim-textobj-user')                                " Add user-defined text objects
call dein#add('jceb/vim-textobj-uri',
      \ {'depends': 'vim-textobj-user'})                              " Text object: URI (u)
call dein#add('thinca/vim-textobj-between',
      \ {'depends': 'vim-textobj-user'})                              " Text object: between characters (f<char>)
call dein#add('glts/vim-textobj-comment',
      \ {'depends': 'vim-textobj-user'})                              " Text object: comments (c)
call dein#add('saaguero/vim-textobj-pastedtext',
      \ {'depends': 'vim-textobj-user'})                              " Text object: pasted text (gb)
call dein#add('Julian/vim-textobj-variable-segment',
      \ {'depends': 'vim-textobj-user'})                              " Text object: segments of variable_names (v)

"""" Snippets
call dein#add('SirVer/ultisnips')                                     " Snippet engine
call dein#add('honza/vim-snippets')                                   " List of snippets

"""" Navigate code
call dein#add('haya14busa/incsearch.vim')                             " Incremental search
call dein#add('haya14busa/incsearch-fuzzy.vim')                       " Fuzzy incremental search
call dein#add('osyo-manga/vim-anzu')                                  " Show search count
call dein#add('haya14busa/vim-asterisk')                              " Star * improvements
call dein#add('justinmk/vim-sneak')                                   " Improved F and T
call dein#add('t9md/vim-smalls')                                      " Quick jump anywhere
call dein#add('farmergreg/vim-lastplace')                             " Restore cursor position

"""" Navigate files, buffers and panes
call dein#add('airblade/vim-rooter')                                  " Change working directory to the project root
call dein#add('junegunn/fzf', {'build': './install --bin'})           " Fuzzy search - binary
call dein#add('junegunn/fzf.vim')                                     " Fuzzy search - vim plugin
call dein#add('benizi/vim-automkdir')                                 " Automatically create missing folders on save
call dein#add('christoomey/vim-tmux-navigator')                       " Easy navigation between vim and tmux panes

"""" Autocomplete
call dein#add('Shougo/deoplete.nvim')                                 " Autocomplete engine
call dein#add('Shougo/neco-vim')                                      " Vim
call dein#add('eagletmt/neco-ghc')                                    " Haskell
call dein#add('zchee/deoplete-jedi')                                  " Python
call dein#add('carlitux/deoplete-ternjs')                             " Javascript
call dein#add('fishbullet/deoplete-ruby')                             " Ruby
call dein#add('wellle/tmux-complete.vim')                             " Tmux panes
call dein#add('zchee/deoplete-go', {'build': 'make'})                 " Go
call dein#add('zchee/deoplete-zsh')                                   " ZSH

"""" Git
call dein#add('tpope/vim-fugitive')                                   " Git integration
call dein#add('airblade/vim-gitgutter')                               " Git gutter

"""" Render code
call dein#add('sheerun/vim-polyglot')                                 " Many many syntaxes
call dein#add('ap/vim-css-color')                                     " Colors in CSS
call dein#add('euclio/vim-markdown-composer',
      \ {'build': 'cargo build --release'})                           " Instantly preview markdown

"""" Lint code
call dein#add('w0rp/ale')

"""" Language-specific
""""" Haskell
call dein#add('neovimhaskell/haskell-vim')                            " Better syntax highlight and indentation
call dein#add('eagletmt/ghcmod-vim')                                  " Ghc Mod
call dein#add('enomsg/vim-haskellConcealPlus')                        " Use unicode symbols for haskell keywords
call dein#add('Twinside/vim-hoogle')                                  " Query hoogle
call dein#add('mpickering/hlint-refactor-vim')                        " Fix lint issues

""""" Go
call dein#add('fatih/vim-go')                                         " Go development

"""" Dein-end
call dein#end()

if dein#check_install()
  call dein#install()
endif

""" Environment
"""" General
filetype plugin indent on
syntax on
let &fillchars="vert:|,fold: ,diff: "
set cursorline                                                     " Spot the cursor easier
set diffopt+=iwhite                                                " Ignore whitespace changes
set expandtab                                                      " Use spaces by default, not tabs
set formatoptions+=l                                               " Don't wrap long lines when editing them
set formatoptions+=n                                               " Recognize numbered lists
set formatoptions+=o                                               " Continue comment when pressing o or O
set formatoptions+=r                                               " Continue comment when pressing Enter
set formatoptions-=c                                               " Don't wrap long comments
set formatoptions-=t                                               " Don't wrap long lines when typing them
set hidden                                                         " Keep buffer around even if it is not displayed right now
set ignorecase                                                     " Ignore search case
set langmap+=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ " Cyrillic layout in normal mode
set langmap+=фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz " Cyrillic layout in normal mode
set langmap+=ЖжЭэХхЪъ;\:\;\"\'{[}]                                 " Cyrillic layout in normal mode
set lazyredraw                                                     " Don't redraw when there is no need for it
set linebreak                                                      " Wrap lines intelligently, e.g. by end of words
set list                                                           " Display unusual whitespace characters
set listchars=tab:»·,trail:·,nbsp:·                                " Which whitespace characters to display and how
set mouse=a                                                        " Enable mouse support
set noshowmode                                                     " Don't show current mode in echo
set nostartofline                                                  " Don't move cursor on the line when moving around
set noswapfile                                                     " Don't use swap files, use git
set nrformats=                                                     " Use only decimal numbers base when incrementing numbers
set number                                                         " Show line numbers
set report=0                                                       " Always report how many lines substitute changed
set scrolloff=3                                                    " Number of lines to keep above and below cursor
set shiftround                                                     " Round indent to a multiple of shiftwidth
set shiftwidth=2                                                   " Tab shifts by this number of spaces
set shortmess+=I                                                   " Don't show intro msg when starting vim
set shortmess+=c                                                   " Don't echo while autocompletion in insert mode
set showcmd
set showtabline=2
set sidescrolloff=3                                                " Number of columns to keep on the left/right of the cursor
set smartcase
set spelllang=en,da,ru
set splitbelow
set splitright
set tabstop=2
set title                                                          " Change terminal title based on the file name
set updatetime=100
set virtualedit=all
set wildmode=longest,list,full

"""" Theme
set termguicolors
set background=dark
let g:gruvbox_italic=1
let g:gruvbox_invert_selection=0
colorscheme gruvbox
set guioptions+=c
set guioptions-=T
set guioptions-=m
set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
hi Normal ctermbg=NONE guibg=NONE

""" Keyboard shortcuts
"""" Leader
let mapleader="\\"
nmap <Space> <Leader>
vmap <Space> <Leader>

"""" Write buffer
nnoremap <Leader>w :w<CR>

"""" Better redo
nnoremap U <C-R>

"""" Remove annoyance
nnoremap <Del> <nop>
vnoremap <Del> <nop>
nnoremap <Backspace> <nop>
vnoremap <Backspace> <nop>
nnoremap Q <nop>

"""" Yank line without spaces
nnoremap <expr> Y 'my^"'.v:register.v:count1.'yg_`y'

"""" Repeat last substitute with flags
nnoremap & :&&<CR>
xnoremap & :&&<CR>

"""" Select most recent paste
nmap gV vgb

"""" Copy to system clipboard
nnoremap <Leader>y "+y
vnoremap <Leader>y "+y

"""" Paste from system clipboard
nnoremap <Leader>p "+p
vnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>P "+P

"""" Delete, not cut
nnoremap <Leader>d "_d
vnoremap <Leader>d "_d

"""" Paste in visual mode multiple times
xnoremap p pgvy

"""" Navigate through autocompletion
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>

""""" Navigate through location list
nmap <C-n> <Plug>(qf_loc_next)<bar><Plug>(qf_qf_next)
nmap <C-p> <Plug>(qf_loc_previous)<bar><Plug>(qf_qf_previous)

"""" Scroll command history
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>

"""" Increment
nmap <C-Up> <C-a>
nmap <C-Down> <C-x>

"""" Close buffer and window
nnoremap <silent> <Leader>cc :Bd<CR>
nnoremap <silent> <Leader>CC :Bd!<CR>
nnoremap <Leader>cw :close<CR>

"""" Write with sudo
cnoremap w!! w !sudo tee > /dev/null %

"""" Edit .vimrc
nnoremap <silent> <Leader>ec :e $MYVIMRC<CR>
nnoremap <silent> <Leader>sc :so $MYVIMRC<CR>

"""" Navigate through visual lines
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

"""" Indent / unindent
nnoremap <S-Tab> <<
nnoremap <Tab> >>
xnoremap <Tab> >gv
xnoremap <S-Tab> <gv

"""" Select all
nnoremap <Leader>v ggVG
xnoremap <Leader>v <C-C>ggVG

"""" Scroll by half of the screen
nmap <PageDown> <C-d>
nmap <PageUp> <C-u>
nmap <C-e> <C-u>

"""" Jump to previous / next cursor position
nnoremap <A-Left> <C-o>
nnoremap <A-Right> <C-i>

"""" Buffer navigation
nnoremap <silent> <C-PageUp> :bp<CR>
nnoremap <silent> <C-PageDown> :bn<CR>

"""" Fix 'gx' to support '?' in URLs
nmap gx mxviugx<Esc>`x

"""" Change tab size
nnoremap <silent><Leader>cst :setlocal ts=4 sts=4 noet <bar> retab! <bar> setlocal ts=2 sts=2 et <bar> retab<CR>

""" Plugins configuration
"""" ALE
let g:ale_open_list = 1
let g:ale_loclist_msg_format='%linter%: %code: %%s'

let g:ale_linters = {
      \ 'go': ['golint', 'go vet', 'go build', 'gometalinter'],
      \ }
let g:ale_go_gometalinter_lint_package = 1

"""" Lightline
let g:lightline = {
      \   'colorscheme': 'gruvbox',
      \   'active': {
      \     'left': [ [ 'mode' ], [ 'pwd' ] ],
      \     'right': [ [ 'linter_ok', 'linter_checking', 'linter_errors', 'linter_warnings', 'trailing', 'lineinfo' ], [ 'fileinfo' ], [ 'scrollbar' ] ],
      \   },
      \   'inactive': {
      \     'left': [ [ 'pwd' ] ],
      \     'right': [ [ 'lineinfo' ], [ 'fileinfo' ], [ 'scrollbar' ] ],
      \   },
      \   'tabline': {
      \     'left': [ [ 'buffers' ] ],
      \     'right': [ [ 'close' ] ],
      \   },
      \   'separator': { 'left': '', 'right': '' },
      \   'subseparator': { 'left': '', 'right': '' },
      \   'mode_map': {
      \     'n' : 'N',
      \     'i' : 'I',
      \     'R' : 'R',
      \     'v' : 'V',
      \     'V' : 'V-LINE',
      \     "\<C-v>": 'V-BLOCK',
      \     'c' : 'C',
      \     's' : 'S',
      \     'S' : 'S-LINE',
      \     "\<C-s>": 'S-BLOCK',
      \     't': '󰀣 ',
      \   },
      \   'component': {
      \     'lineinfo': '%l:%-v',
      \   },
      \   'component_expand': {
      \     'buffers': 'lightline#bufferline#buffers',
      \     'trailing': 'lightline#trailing_whitespace#component',
      \     'linter_ok': 'lightline#ale#ok',
      \     'linter_checking': 'lightline#ale#checking',
      \     'linter_warnings': 'lightline#ale#warnings',
      \     'linter_errors': 'lightline#ale#errors',
      \   },
      \   'component_function': {
      \     'pwd': 'LightlineWorkingDirectory',
      \     'scrollbar': 'LightlineScrollbar',
      \     'fileinfo': 'LightlineFileinfo',
      \   },
      \   'component_type': {
      \     'buffers': 'tabsel',
      \     'trailing': 'error',
      \     'linter_ok': 'left',
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \   },
      \ }

""""" Custom components
function! LightlineScrollbar()
  let top_line = str2nr(line('w0'))
  let bottom_line = str2nr(line('w$'))
  let lines_count = str2nr(line('$'))

  if bottom_line - top_line + 1 >= lines_count
    return ''
  endif

  let window_width = winwidth(0)
  if window_width < 90
    let scrollbar_width = 6
  elseif window_width < 120
    let scrollbar_width = 9
  else
    let scrollbar_width = 12
  endif

  return noscrollbar#statusline(scrollbar_width, '-', '#')
endfunction

function! LightlineFileinfo()
  if winwidth(0) < 90
    return ''
  endif

  let encoding = &fenc !=# "" ? &fenc : &enc
  let format = &ff
  let type = &ft !=# "" ? &ft : "no ft"
  return type . ' | ' . format . ' | ' . encoding
endfunction

function! LightlineWorkingDirectory()
  return &ft =~ 'help\|qf' ? '' : fnamemodify(getcwd(), ":~:.")
endfunction

"""" Lightline ALE
let g:lightline#ale#indicator_warnings = ' '
let g:lightline#ale#indicator_errors = ' '
let g:lightline#ale#indicator_checking = ' '

"""" lightline-bufferline
let g:lightline#bufferline#filename_modifier = ':~:.' " Show filename relative to current directory
let g:lightline#bufferline#unicode_symbols = 1        " Use fancy unicode symbols for various indicators
let g:lightline#bufferline#modified = ''             " Default pencil is too ugly
let g:lightline#bufferline#unnamed = '[No Name]'      " Default name when no buffer is opened
let g:lightline#bufferline#shorten_path = 0           " Don't compress ~/my/folder/name to ~/m/f/n

"""" Lightline trailing whitespace
let g:lightline#trailing_whitespace#indicator = '•'

"""" Asterisk
map *  <Plug>(incsearch-nohl0)<Plug>(asterisk-z*)
map #  <Plug>(incsearch-nohl0)<Plug>(asterisk-z#)
map g* <Plug>(incsearch-nohl0)<Plug>(asterisk-gz*)
map g# <Plug>(incsearch-nohl0)<Plug>(asterisk-gz#)

"""" DelimitMate
let delimitMate_expand_cr = 2
let delimitMate_expand_space = 1
let delimitMate_nesting_quotes = ['"', '`']
let delimitMate_excluded_regions = ""
let delimitMate_balance_matchpairs = 1

"""" Deoplete
let g:deoplete#enable_at_startup = 1

call deoplete#custom#source('_', 'min_pattern_length', 1)
call deoplete#custom#source('around', 'rank', 100)
call deoplete#custom#source('ultisnips', 'rank', 200)

"""" Deoplete-jedi (Python completion)
let deoplete#sources#jedi#show_docstring = 1

"""" Deoplete-ternjs (JS completion)
let g:tern_request_timeout = 1
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]

"""" EasyAlign
nmap <Leader>= <Plug>(EasyAlign)
xmap <Leader>= <Plug>(EasyAlign)

"""" FZF
" Make :Ag not match file names, only file contents
command! -bang -nargs=* AgContents call fzf#vim#ag(<q-args>, '--hidden', {'options': '--delimiter : --nth 4..'}, <bang>0)

nnoremap <silent> <Leader>f :Files<CR>
nnoremap <silent> <Leader>F :Files ~<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>G :AgContents<CR>

"""" Ghc-mod
nnoremap <silent> <leader>ht :w<CR>:GhcModType<CR>:GhcModTypeClear<CR>
nnoremap <silent> <leader>hT :w<CR>mh0:GhcModTypeInsert<CR>`h
nnoremap <silent> <leader>hi :w<CR>:GhcModInfo<CR>
nnoremap <silent> <leader>hI :HoogleInfo<CR>

"""" GitGutter
let g:gitgutter_map_keys = 0

nmap ]c <Plug>GitGutterNextHunk<Plug>GitGutterPreviewHunk<Bar>zv
nmap [c <Plug>GitGutterPrevHunk<Plug>GitGutterPreviewHunk<Bar>zv
nmap <Leader>ga <Plug>GitGutterStageHunk
nmap <Leader>gu <Plug>GitGutterUndoHunk
nmap <Leader>gp <Plug>GitGutterPreviewHunk

"""" Go
let g:go_fmt_autosave = 0   " This is already done by Neoformat
let g:go_auto_type_info = 1 " Show type of anything under cursor

let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_types = 1

"""" Haskell Conceal
let hscoptions="𝐒𝐓𝐄𝐌wRTBQZDC"

"""" Haskell vim
let g:haskell_indent_disable = 1

"""" Hlint refactor
let g:hlintRefactor#disableDefaultKeybindings = 1

nnoremap <silent> <leader>hr :call ApplyOneSuggestion()<CR>
nnoremap <silent> <leader>hR :call ApplyAllSuggestions()<CR>

"""" Incsearch
let g:incsearch#auto_nohlsearch = 1

map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

map z/ <Plug>(incsearch-fuzzy-/)
map z? <Plug>(incsearch-fuzzy-?)
map zg/ <Plug>(incsearch-fuzzy-stay)

map n <Plug>(incsearch-nohl)<Plug>(anzu-n-with-echo)zMzv
map N <Plug>(incsearch-nohl)<Plug>(anzu-N-with-echo)zMzv

"""" Markdown composer
let g:markdown_composer_open_browser = 0
let g:markdown_composer_custom_css = ['https://cdn.rawgit.com/maximbaz/github-markdown-css/gh-pages/github-markdown.css']

"""" Neco-ghc
let g:necoghc_enable_detailed_browse = 1

"""" Smalls
let g:smalls_auto_jump = 1

nmap s <Plug>(smalls)
xmap s <Plug>(smalls)
omap s <Plug>(smalls)

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

"""" TComment
let g:tcommentTextObjectInlineComment = ''

"""" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"

augroup fix-ultisnips-overriding-tab-visual-mode
  autocmd!
  autocmd VimEnter * xnoremap <Tab> >gv
augroup END


"""" vim-rooter
let g:rooter_use_lcd = 1
let g:rooter_silent_chdir = 1
let g:rooter_resolve_links = 1

"""" vim-smooth-scroll
let g:ms_per_line=2

"""" vim-table-mode
let g:table_mode_verbose = 0
let g:table_mode_corner = '|'
let g:table_mode_auto_align = 1

"""" vim-qf
let g:qf_auto_open_quickfix = 0
let g:qf_auto_open_loclist = 0

""" Functions
"""" Removes trailing whitespace
function! RemoveTrailingSpaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfunction

nnoremap <silent> <F10> :call RemoveTrailingSpaces()<CR>

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

nnoremap <silent><Home> :call SmartHome("n")<CR>
nnoremap <silent><End> :call SmartEnd("n")<CR>
inoremap <silent><Home> <C-r>=SmartHome("i")<CR>
inoremap <silent><End> <C-r>=SmartEnd("i")<CR>
vnoremap <silent><Home> <Esc>:call SmartHome("v")<CR>
vnoremap <silent><End> <Esc>:call SmartEnd("v")<CR>

"""" Toggle automatic code formatting
function! ToggleAutoFormatCode()
  if !exists('#AutoFormatCode#BufWritePre')
    augroup AutoFormatCode
      autocmd!
      autocmd BufWritePre * silent! Neoformat
    augroup END
  else
    augroup AutoFormatCode
      autocmd!
    augroup END
  endif
endfunction
command! ToggleAutoFormatCode :call ToggleAutoFormatCode()
call ToggleAutoFormatCode() " Enable by default

"""" Repeat macro over visual selection
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

"""" Set terminal title
function! SetTerminalTitle()
  let bufnr = bufnr('%')
  if buflisted(bufnr)
    if bufname(bufnr) == ''
      let &titlestring = 'unnamed'
    else
      let &titlestring = expand('%:~')
    endif
  endif
endfunction

xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

""" AutoCmd
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

augroup title
  autocmd!
  autocmd BufEnter * call SetTerminalTitle()
augroup END


"" vim:foldmethod=expr:foldlevel=0
"" vim:foldexpr=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'""*')-2)\:'='
