"         _                       _
" "__   _(_)_ __ ___        _ __ | |_   _  __ _
" "\ \ / / | '_ ` _ \ _____| '_ \| | | | |/ _` |
" " \ V /| | | | | | |_____| |_) | | |_| | (_| |
" "  \_/ |_|_| |_| |_|     | .__/|_|\__,_|\__, |
" "                        |_|            |___/
"
if empty(glob('~/.vim/autoload/plug.vim')) && empty(glob('~/.config/nvim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
            autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'airblade/vim-gitgutter'                       " Git diff
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'dyng/ctrlsf.vim' " Search
Plug 'rust-lang/rust.vim'
Plug 'dense-analysis/ale'                           " Find errors
"Plug 'neoclide/coc.nvim', {'branch': 'release'}    " Not good for performance
"Plug 'ryanoasis/vim-devicons'                      " Didn't work on mac
call plug#end()

" " ____  _             _              ____             __ _
" "|  _ \| |_   _  __ _(_)_ __  ___   / ___|___  _ __  / _(_) __ _
" "| |_) | | | | |/ _` | | '_ \/ __| | |   / _ \| '_ \| |_| |/ _` |
" "|  __/| | |_| | (_| | | | | \__ \ | |__| (_) | | | |  _| | (_| |
" "|_|   |_|\__,_|\__, |_|_| |_|___/  \____\___/|_| |_|_| |_|\__, |
" "               |___/                                      |___/
"" Ale
" Find previou error
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
" Find next error
nmap <silent> <C-j> <Plug>(ale_next_wrap)
let g:ale_open_list = 1
let g:ale_detail_to_floating_preview = 1
let g:ale_cursor_detail = 1
let g:ale_close_preview_on_insert = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 1

"" NERDTree
" auto show with vim
autocmd VimEnter * if !argc() | NERDTree | endif
autocmd VimEnter * if argc() | NERDTreeFind | endif
autocmd vimenter * wincmd p
" Auto close nerdtree if it's last window
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Toggle
map <C-n> :NERDTreeToggle<CR>
" Find where I am
map me :NERDTreeFind<CR>
" Swtich tabs
map <Tab> :call CheckNerdTree(":tabnext")<CR>
map <S-Tab> :call CheckNerdTree(":tabp")<CR>
function! CheckNerdTree(tab)
    execute a:tab
    NERDTreeFind
    wincmd l
endfunction

"" Nerdtree-git-plugin
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

"" Nerdtree-syntax-highlight
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

"" Vim-gitgutter (git diff)
" sign customization
highlight GitGutterAdd ctermbg=29   guifg=#00875f
highlight GitGutterChange ctermbg=29   guifg=#00875f
highlight GitGutterDelete ctermbg=124  guifg=#af0000
let g:gitgutter_sign_modified = 'M'

"" FZF
nnoremap <C-p> :GFiles<CR>
let g:fzf_action = { 'enter': 'tab split' }
set rtp+=/usr/local/opt/fzf

"" Ctrlsf
vmap     <C-F> <Plug>CtrlSFVwordExec
nmap     <C-F> <Plug>CtrlSFCwordPath
nnoremap <C-F><C-F> :CtrlSFToggle<CR>
"nmap     <C-F>f <Plug>CtrlSFPrompt
"vmap     <C-F> <Plug>CtrlSFVwordPath
"nmap     <C-F>p <Plug>CtrlSFPwordPath
"nnoremap <C-F>o :CtrlSFOpen<CR>
"inoremap <C-F>t <Esc>:CtrlSFToggle<CR>
" compact view
let g:ctrlsf_default_view_mode = 'compact'
" focus at search result
let g:ctrlsf_auto_focus = {
    \ 'at': 'start',
    \ }

"" COC
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)

"" NERDTree
" auto show with vim
autocmd VimEnter * if !argc() | NERDTree | endif
autocmd VimEnter * if argc() | NERDTreeFind | endif
autocmd vimenter * wincmd p
" Auto close nerdtree if it's last window
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Toggle
map <C-n> :NERDTreeToggle<CR>
" Find where I am
map me :NERDTreeFind<CR>
" Swtich tabs
map <Tab> :call CheckNerdTree(":tabnext")<CR>
map <S-Tab> :call CheckNerdTree(":tabp")<CR>
function! CheckNerdTree(tab)
    execute a:tab
    NERDTreeFind
    wincmd l
endfunction


" " _____ _
" "|_   _| |__   ___ _ __ ___   ___
" "  | | | '_ \ / _ \ '_ ` _ \ / _ \
" "  | | | | | |  __/ | | | | |  __/
" "  |_| |_| |_|\___|_| |_| |_|\___|
"
color desert

"   ____            _         ____             __ _
" "| __ )  __ _ ___(_) ___   / ___|___  _ __  / _(_) __ _
" "|  _ \ / _` / __| |/ __| | |   / _ \| '_ \| |_| |/ _` |
" "| |_) | (_| \__ \ | (__  | |__| (_) | | | |  _| | (_| |
" "|____/ \__,_|___/_|\___|  \____\___/|_| |_|_| |_|\__, |
" "                                                 |___/

set backspace=indent,eol,start  " 統一 backsapce 功能
set colorcolumn=150
set cursorline
set fileencodings=utf-8,default,big5,ucs-bom,latin1
set hlsearch                    " 顏色標記被搜尋的文字
set incsearch                   " 往後搜尋
set expandtab
set encoding=utf-8
set noerrorbells
set number                      " 顯示行數
set relativenumber
set scrolloff=8                 " 游標距離上下 N 行開始捲動螢幕
set shiftwidth=4                " tab 寬度
set shellcmdflag=-ic
set shellcmdflag=-c
set showcmd                     " 顯示命令按鍵
set signcolumn=yes
set smartcase                   " 搜尋時自動判斷是否區分大小寫
set smartindent                 " 自動縮排
set tabstop=4 softtabstop=4     " tab寬度
set updatetime=400
syntax enable
filetype plugin indent on
nnoremap <F2> :set hlsearch!<CR>

