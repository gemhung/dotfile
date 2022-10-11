:color desert
:set cursorline

set nu
set hlsearch
set shellcmdflag=-ic
set shellcmdflag=-c
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set updatetime=200
set signcolumn=yes
set encoding=utf-8

set noerrorbells
set smartindent
set smartcase
set incsearch
set relativenumber
set scrolloff=8
set colorcolumn=100
set showcmd

nnoremap <F2> :set hlsearch!<CR>

"---------
"" Plugins
"---------
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'airblade/vim-gitgutter'
"Plug 'ryanoasis/vim-devicons' "  didn't work on mac
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'dyng/ctrlsf.vim'

" Rust lang
Plug 'rust-lang/rust.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'

call plug#end()

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"---------
"" vim-gitgutter
"---------
" sign customization
highlight GitGutterAdd ctermbg=29   guifg=#00875f
highlight GitGutterChange ctermbg=29   guifg=#00875f
highlight GitGutterDelete ctermbg=124  guifg=#af0000
let g:gitgutter_sign_modified = 'M'

"---------
"" nerdtree-syntax-highlight
"---------
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

"---------
"" nerdtree-git-plugin
"---------
let g:NERDTreeGitStatusIndicatorMapCustom = {
                    \ 'Modified'  :'M',
                    \ 'Dirty'     :'M', 
                    \ }
"let g:NERDTreeGitStatusIndicatorMapCustom = {
"                    \ 'Modified'  :'✹',
"                \ 'Staged'    :'✚',
"                \ 'Untracked' :'✭',
"                \ 'Renamed'   :'➜',
"                \ 'Unmerged'  :'═',
"                \ 'Deleted'   :'✖',
"                \ 'Dirty'     :'✗',
"                \ 'Ignored'   :'☒',
"                \ 'Clean'     :'✔︎',
"                \ 'Unknown'   :'?',
"                \ }

"---------
"" NERDTree
"---------
" auto show with vim
autocmd VimEnter * if !argc() | NERDTree | endif
autocmd VimEnter * if argc() | NERDTreeFind | endif
autocmd vimenter * wincmd p
" toggle
map <C-n> :NERDTreeToggle<CR>
" find where I am
map me :NERDTreeFind<CR>
" swtich tabs
map <Tab> :call CheckNerdTree(":tabnext")<CR>
map <S-Tab> :call CheckNerdTree(":tabp")<CR>
"
" auto close nerdtree if it's last window
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

"---------
"" FZF
"---------
nnoremap <C-p> :GFiles<CR>
nnoremap <S-p> :GFiles 
let g:fzf_action = { 'enter': 'tab split' }

"---------
"" ctrlsf
"---------
"nmap     <C-F>f <Plug>CtrlSFPrompt
"vmap     <C-F> <Plug>CtrlSFVwordPath
vmap     <C-F> <Plug>CtrlSFVwordExec
nmap     <C-F> <Plug>CtrlSFCwordPath
"nmap     <C-F>p <Plug>CtrlSFPwordPath
"nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F><C-F> :CtrlSFToggle<CR>
"inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

" compact view
let g:ctrlsf_default_view_mode = 'compact'
" focus at search result
let g:ctrlsf_auto_focus = {
    \ 'at': 'start',
    \ }

"--------
"" help function
"--------
function! CheckNerdTree(tab)
    execute a:tab
    NERDTreeFind
    wincmd l
endfunction

"function! CheckNerdTree_1(tab)
"   if exists("g:NERDTree") && g:NERDTree.IsOpen()
"        execute a:tab
"        NERDTreeFind
"        wincmd l
"   else
"        execute a:tab
"    endif
"endfunction

set rtp+=/usr/local/opt/fzf
