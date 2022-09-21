set nocompatible

set backspace=indent eol

" Clean up
source $HOME/.config/vim/xdg.vim

call vundle#begin()

" let Vundle manage Vundle, required
" Plugin 'VundleVim/Vundle.vim'

Plugin 'sirver/ultisnips'
    let g:UltiSnipsExpandTrigger = '<tab>'
    let g:UltiSnipsJumpForwardTrigger = '<tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" titlecase plugin. Press gz<text object> to titlecase it
Plugin 'christoomey/vim-titlecase'

Plugin 'lervag/vimtex'
    let g:tex_flavor='latex'
    let g:vimtex_view_method='zathura'
    let g:vimtex_quickfix_mode=0

Plugin 'KeitaNakamura/tex-conceal.vim'
    set conceallevel=1
    let g:tex_conceal='abdmg'
    hi Conceal ctermbg=none

Plugin 'tpope/vim-commentary'

setlocal spell
set spelllang=en_us
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

syntax on
filetype on
au BufNewFile,BufRead *.tikz set filetype=tex

" one half theme
Plugin 'sonph/onehalf', { 'rtp': 'vim' }

" vim-grammarous
Plugin 'rhysd/vim-grammarous'

" NERD Tree
Plugin 'scrooloose/nerdtree'

" autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
map <C-n> :NERDTreeToggle<CR>

" vim-surround
Plugin 'tpope/vim-surround'

" airline plugin
Plugin 'vim-airline/vim-airline'"
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'

call vundle#end()            " required
filetype plugin indent on    " required
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
set t_Co=256
set cursorline

" Colorscheme
Plugin 'ghifarit53/tokyonight-vim'
set termguicolors

let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 1
let g:tokyonight_transparent = 1

colorscheme tokyonight

" Lightline
let g:lightline = {
    \ 'colorscheme': 'tokyonight',
    \ 'active': {
    \   'left': [ ['mode', 'paste'],
    \             ['readonly', 'filename','kite', 'modified'] ]
    \ },
    \ 'component_function': {
    \   'kite': 'kite#statusline'
    \ }
    \ }
set laststatus=2

" colorscheme onehalfdark
" let g:airline_theme='onehalfdark'

" fzf_action, Customizable extra key bindings for opening selected files in different ways
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Makes it so that vim doesn't have a custom background opacity
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE
hi! LineNr ctermbg=NONE ctermfg=NONE

" Basic stuff
set number relativenumber
set tabstop=4
" Makes vim paste properly in insert mode
se paste noai

" Enable Auto-complete
set wildmode=longest,list,full

map <space>c :w !pdflatex % <return> 
map <space>v :!zathura --mode fullscreen %:r.pdf <return>
map <space>m :e 
map <space>n :bn <return>
map <space>p :bp <return>
map <space>g :GrammarousCheck <return>
map <space>f :FZF <return>
map E ea

" Change cursor between normal and insert mode. See
" https://stackoverflow.com/questions/6488683/how-to-change-the-cursor-between-normal-and-insert-modes-in-vim
" for more info 
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" reset the cursor on start (for older versions of vim, usually not required, needed on arch)
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END

" For calcurse notes to be in markdown
autocmd BufRead,BufNewFile /tmp/calcurse*,~/.config/calcurse/notes/* set filetype=markdown

set hlsearch
set statusline+=col:\ %c
