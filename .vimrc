set autoindent
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
set cindent
set colorcolumn=80
set number
hi Normal ctermbg=none
syntax enable
set hidden

" Mapping to make escape easier to use
ino jk <esc>
ino kj <esc>

cno jk <esc>
cno kj <esc>

" Temporary remapping to train me to not use escape
inoremap <esc> <nop>

" Spelling toggle via F9 and F10
nmap <F9> :setlocal spell spelllang=en_us<CR>
nmap <F10> :setlocal nospell<CR>

" Use the system clipboard for vim
set clipboard=unnamedplus

" ensure normal tabs in assembly files
autocmd FileType asm setlocal noexpandtab shiftwidth=8 tabstop=8

" Commit messages should be wrapped to 72 characters
au FileType gitcommit set tw=72

"Only use solarized if using gvim
if has ("gui_running")
    let g:solarized_contrast="high"
    colors solarized
    set guioptions-=m  "remove menu bar
    set guioptions-=T  "remove toolbar
    set guioptions-=r  "remove right-hand scroll bar
    set guioptions-=L  "remove left-hand scroll bar
    nnoremap <C-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
    nnoremap <C-F2> :if &go=~#'T'<Bar>set go-=T<Bar>else<Bar>set go+=T<Bar>endif<CR>
    nnoremap <C-F3> :if &go=~#'r'<Bar>set go-=r<Bar>else<Bar>set go+=r<Bar>endif<CR>

else
    " If in CLI, use solarized
    colorscheme solarized
    set t_Co=16
endif

"Create centralized backup location
set directory=~/.vim/swap//

set background=dark
let base16colorspace=256
set t_Co=256

"Set mapleader to space
let mapleader="\<Space>"

"Allow copying to register with CTRL-C
map <C-c> "+y <CR>

"Still quit when using capital q or w
command Q q
command W w

"Allow saving of profiles
nmap <Leader>fs :mksession! .session<CR>
nmap <Leader>fl :source .session<CR>

set ssop-=folds      " do not store folds

set pastetoggle=<F2>
set copyindent
set ignorecase
set incsearch
set nohlsearch
set laststatus=2
set nocompatible
filetype off
set showmatch

"Toggle highlight search
nmap <C-n> :noh<cr>

" Fix backspacing
set bs=2

"Set textwidth and formatting options
set textwidth=80
"autocmd BufNewFile,BufWinEnter * setlocal formatoptions=cqnroj

"Shortcuts to enable and disable formatting
nnoremap <Leader>fo :set textwidth=80<CR> <Bar> :set colorcolumn=80 <CR>
nnoremap <Leader>ff :set textwidth=0<CR> <Bar> :set colorcolumn= <CR>

hi ColorColumn ctermbg=0

"Prevent auto-commenting when pressing enter, o or O
inoremap <expr> <enter> getline('.') =~ '^\s*//' ? '<enter><esc>S' : '<enter>'
nnoremap <expr> O getline('.') =~ '^\s*//' ? 'O<esc>S' : 'O'
nnoremap <expr> o getline('.') =~ '^\s*//' ? 'o<esc>S' : 'o'

"Show tabs with CTRL-T
nmap <silent> <C-t> :set list!<CR> :set listchars=tab:>-<CR>

" Allow usage of mouse
set mouse=a
command! -nargs=1 Silent execute ':silent !'.<q-args> | execute ':redraw!'

" Another function to clear inactive buffers, uses command :Bdi
function! DeleteInactiveBufs()
    "From tabpagebuflist() help, get a list of all buffers in all tabs
    let tablist = []
    for i in range(tabpagenr('$'))
        call extend(tablist, tabpagebuflist(i + 1))
    endfor

    "Below originally inspired by Hara Krishna Dara and Keith Roberts
    "http://tech.groups.yahoo.com/group/vim/message/56425
    let nWipeouts = 0
    for i in range(1, bufnr('$'))
        if bufexists(i) && !getbufvar(i,"&mod") && index(tablist, i) == -1
            silent exec 'bwipeout' i
            let nWipeouts = nWipeouts + 1
        endif
    endfor
    echomsg nWipeouts . ' buffer(s) wiped out'
endfunction
command! Bdi :call DeleteInactiveBufs()

"Easy file header insert, use F4 in insert mode
function FileHeading()
  let s:line=line(".")
  call setline(s:line,"/*******************************************************************************")

  call append(s:line,"* Name:          Christopher Harris & Jonathan Luck")
  call append(s:line+1,"* UID:           C.H: A92052491; J.L: A13029781")
  call append(s:line+2,"* Date:          " .strftime("%b %d %Y"))
  call append(s:line+3,"* Filename:      " .expand("%"))
  call append(s:line+4,"* Description    TODO")
  call append(s:line+5,"* *****************************************************************************/")
  unlet s:line
endfunction

"Easy function header insert, use F5 in insert mode
function FunctionHeader()
  let b=getline(".")
  let s:line=line(".")-1
  call setline(s:line+1,"/**")
  call append(s:line+1," * Method Name: TODO")
  call append(s:line+2," * Description: TODO")
  call append(s:line+3," * Parameters:  TODO")
  call append(s:line+4," * Return:      TODO")
  call append(s:line+5," */")
  call append(s:line+6,b)
  unlet s:line
  unlet b
endfunction

map <F4> <Esc>mz:execute FileHeading()<Return>`z4j
map <F5> <Esc>mz:execute FunctionHeader()<Return>`z4j

"Easy call to Bdi
nmap <Leader>bd :Bdi<CR>

"Easy window navigation, no need to use CTRL-W first
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'majutsushi/tagbar'
Plugin 'godlygeek/tabular'
"Plugin 'Townk/vim-autoclose'
Plugin 'Valloric/YouCompleteMe'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'easymotion/vim-easymotion'
Plugin 'rdnetto/YCM-Generator'
Plugin 'sophacles/vim-processing'
Plugin 'flazz/vim-colorschemes'

call vundle#end()
filetype plugin on

set scrolloff=4 " Keep 3 lines below and above the cursor

"Fancy script for showing and removing whitespace
function ShowSpaces(...)
  let @/='\v(\s+$)|( +\ze\t)'
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    let &hlsearch=a:1
  end
  return oldhlsearch
endfunction

function TrimSpaces() range
  let oldhlsearch=ShowSpaces(1)
  execute a:firstline.",".a:lastline."substitute ///gec"
  let &hlsearch=oldhlsearch
endfunction

command -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
command -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()
nnoremap <S-F12>   m`:TrimSpaces<CR>``
vnoremap <S-F12>   :TrimSpaces<CR>

"Tabularize stuff
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>
nmap <Leader>a; :Tabularize /;\zs<CR>
vmap <Leader>a; :Tabularize /;\zs<CR>

"fugitive git bindings
nnoremap <Leader>ga :Git add %:p<CR><CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gc :Gcommit -v -q<CR>
nnoremap <Leader>gt :Gcommit -v -q %:p<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>ge :Gedit<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gw :Gwrite<CR><CR>
nnoremap <Leader>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <Leader>glg :Git lg<CR>
nnoremap <Leader>gp :Ggrep<Space>
nnoremap <Leader>gm :Gmove<Space>
nnoremap <Leader>gb :Git branch<Space>
nnoremap <Leader>go :Git checkout<Space>
nnoremap <Leader>gps :!git push<CR>
nnoremap <Leader>gpl :!git pull<CR>

"Set syntax to CPP using ,cp
map <Leader>cp :set syntax=cpp<CR>

" Toggle through buffers
nnoremap <S-Tab> :bnext<CR>

"Close preview window after leaving insert mode
let g:ycm_autoclose_preview_window_after_insertion = 1

"Use python 2 autocompletion
let g:ycm_python_binary_path = '/usr/bin/python2'

"Do not prompt to load config
let g:ycm_confirm_extra_conf = 0

"Eclim compatibility
let g:EclimCompletionMethod = 'omnifunc'

"Disable YCM for assembly files
let g:ycm_filetype_blacklist = {'asm' : 1}

let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-s)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-s2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

"Tagbar stuff
nmap <F8> :TagbarToggle<CR>

"Autoclose stuff, compatibility w/ YCM
let g:AutoClosePumvisible = {"ENTER": "<C-Y>", "ESC": "<ESC>"}

"CTRLP stuff
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
set wildignore+=*/tmp/*,*/bin/*,*.so,*.swp,*.zip,*.class,*.out,*.jar,*.o,*.pyc

" air-line
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#eclim#enabled = 0

" Use green for normal mode in solarized airline theme
let g:airline_solarized_normal_green = 1

"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1

"Set themes for airline based on GUI
if has ("gui_running")
    let g:airline_theme='solarized'
else
    let g:airline_theme='solarized'
endif

if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif

 "unicode symbols
"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.whitespace = 'Ξ'

 "airline symbols
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = ''
