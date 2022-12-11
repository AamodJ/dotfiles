set nocompatible

" Make backspace work the way it should work, and persistent undos
set backspace=indent eol
set undofile

" Wayland clipboard integration
source $HOME/.config/vim/wayland_clipboard.vim

call plug#begin() 

" Colorscheme 
Plug 'itchyny/lightline.vim'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }

Plug 'sirver/ultisnips'
    let g:UltiSnipsExpandTrigger = '<tab>'
    let g:UltiSnipsJumpForwardTrigger = '<tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

let g:UltiSnipsEditSplit="vertical"

Plug 'honza/vim-snippets'

Plug 'christoomey/vim-titlecase'

Plug 'lervag/vimtex'
    let g:tex_flavor='latex'
    let g:vimtex_view_method='zathura'
    let g:vimtex_quickfix_mode=0

Plug 'KeitaNakamura/tex-conceal.vim'
    set conceallevel=1
    let g:tex_conceal='abdmg'
    hi Conceal ctermbg=none

Plug 'tpope/vim-commentary'

setlocal spell
set spelllang=en_us
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

syntax on
filetype off
au BufNewFile,BufRead *.tikz set filetype=tex

Plug 'rhysd/vim-grammarous'

Plug 'scrooloose/nerdtree'

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>

Plug 'tpope/vim-surround'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

filetype plugin indent on

set t_Co=256
set cursorline

" Set Colorscheme
set termguicolors
source $HOME/.config/vim/themes/current-theme.vim

" fzf_action
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

" Enable Auto-complete
set wildmode=longest,list,full

" Mappings
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
