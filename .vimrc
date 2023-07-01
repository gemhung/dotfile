"   ____            _         ____             __ _
" " _____ _
" "|_   _| |__   ___ _ __ ___   ___
" "  | | | '_ \ / _ \ '_ ` _ \ / _ \
" "  | | | | | |  __/ | | | | |  __/
" "  |_| |_| |_|\___|_| |_| |_|\___|
"
"color desert
"color molokai
colorscheme molokai


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
set noswapfile

syntax enable
filetype plugin indent on
" Toggle hightlight search
nnoremap <F2> :set hlsearch!<CR>
" Toggle scrollbind
nnoremap <F3> :windo set cursorbind!<CR>:windo set scrollbind!<CR>:wincmd p<CR>
" Highlight all instances of word under cursor, when idle.
" " Useful when studying strange source code.
" " Type z/ to toggle highlighting on/off.
nnoremap zw :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
    let @/ = ''
    if exists('#auto_highlight')
        au! auto_highlight
        augroup! auto_highlight
        setl updatetime=4000
        echo 'Highlight current word: off'
        return 0
    else
        augroup auto_highlight
            au!
            au CursorHold * let @/ ='\V\<'.escape(expand('<cword>'),'\').'\>'
        augroup end
        setl updatetime=500
        echo'Highlight current word:ON'
        return 1
    endif
endfunction

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
            autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'                          " Nerdtree
Plug 'Xuyuanp/nerdtree-git-plugin'                  " Nerdtree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'      " Nerdtree
Plug 'airblade/vim-gitgutter'                       " Git diff
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " FZF
Plug 'junegunn/fzf.vim'                             " FZF
Plug 'dyng/ctrlsf.vim'                              " Search
Plug 'rust-lang/rust.vim'                           " Rust
Plug 'ervandew/supertab'                            " AutoComplete
Plug 'itchyny/lightline.vim'                        " Status bar
Plug 'itchyny/vim-gitbranch'                        " Status bar
Plug 'neoclide/coc.nvim', {'branch': 'release'}    " !Not good for performance
Plug 'ruanyl/vim-gh-line'                            " Get github link
"Plug 'knsh14/vim-github-link'
"Plug 'tpope/vim-fugitive'
"Plug 'tpope/vim-rhubarb'

Plug 'ryanoasis/vim-devicons'                      " !Didn't work on mac
"Plug 'dense-analysis/ale'                           " Find errors
"Plug 'gemhung/rust-aledetail-pretty.vim'            " AutoComplete
call plug#end()

" " ____  _             _              ____             __ _
" "|  _ \| |_   _  __ _(_)_ __  ___   / ___|___  _ __  / _(_) __ _
" "| |_) | | | | |/ _` | | '_ \/ __| | |   / _ \| '_ \| |_| |/ _` |
" "|  __/| | |_| | (_| | | | | \__ \ | |__| (_) | | | |  _| | (_| |
" "|_|   |_|\__,_|\__, |_|_| |_|___/  \____\___/|_| |_|_| |_|\__, |
" "               |___/                                      |___/

" " Lightline
set noshowmode
let g:lightline = {
    \ 'colorscheme': 'one',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'absolutepath', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'gitbranch#name',
    \   'modified': 'LightlineModified',
    \   'filetype': 'MyFiletype',
    \   'fileformat': 'MyFileformat',
    \ },
    \ }

function! LightlineModified()
    let modified = &modified ? ' M' : ''
    return modified
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

"" Ale
" Find previou error
nmap <silent><C-k> <Plug>(ale_previous_wrap)
" Find next error
nmap <silent><C-j> <Plug>(ale_next_wrap)
nmap <silent><C-l> <C-l>:ALEToggle<CR>
let g:ale_open_list = 1
let g:ale_detail_to_floating_preview = 1
let g:ale_close_preview_on_insert = 1
let g:ale_cursor_detail = 1
let g:ale_lint_on_save = 1
"let g:ale_lint_on_enter = 1
let g:ale_floating_window_border  = ['│', '─', '╭', '╮', '╯', '╰', '│', '─']
"For wide montior
"let g:ale_list_vertical = 1
let g:ale_linters = {'rust': ['analyzer']}
let g:ale_set_highlights = 0
let g:ale_sign_error = 'XX'


"" NERDTree
let NERDTreeShowHidden=1
" auto show with vim
autocmd VimEnter * if !argc() | NERDTree | endif
autocmd VimEnter * if argc() | NERDTreeFind | endif
autocmd vimenter * wincmd p
" Auto close nerdtree if it's last window
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Toggle
nnoremap <silent> <C-n> :NERDTreeToggle <Bar> if &filetype ==# 'nerdtree' <Bar> wincmd p <Bar> endif<CR>
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
" you can add these colors to your .vimrc to help customizing
let s:brown = "905532"
let s:aqua =  "3AFFDB"
let s:blue = "689FB6"
let s:darkBlue = "44788E"
let s:purple = "834F79"
let s:lightPurple = "834F79"
let s:red = "AE403F"
let s:beige = "F5C06F"
let s:yellow = "F09F17"
let s:orange = "D4843E"
let s:darkOrange = "F16529"
let s:pink = "CB6F6F"
let s:salmon = "EE6E73"
let s:green = "8FAA54"
let s:lightGreen = "31B53E"
let s:white = "FFFFFF"
let s:rspec_red = 'FE405F'
let s:git_orange = 'F54D27'
let g:NERDTreeExtensionHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExtensionHighlightColor['css'] = s:blue " sets the color of css files to blue
let g:NERDTreeExactMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:git_orange " sets the color for .gitignore files
let g:NERDTreeExactMatchHighlightColor['Cargo.toml'] = s:git_orange " sets the color for Cargo.toml files
let g:NERDTreePatternMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreePatternMatchHighlightColor['.*_spec\.rb$'] = s:rspec_red " sets the color for files ending with _spec.rb
let g:WebDevIconsDefaultFolderSymbolColor = s:beige " sets the color for folders that did not match any rule
let g:WebDevIconsDefaultFileSymbolColor = s:blue " sets the color for files that did not match any rule

let g:WebDevIconsDisableDefaultFolderSymbolColorFromNERDTreeDir = 1
let g:WebDevIconsDisableDefaultFileSymbolColorFromNERDTreeFile = 1
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name

"" Vim-gitgutter (git diff)
" sign customization
highlight GitGutterAdd ctermbg=29   guifg=#00875f
highlight GitGutterChange ctermbg=29   guifg=#00875f
highlight GitGutterDelete ctermbg=124  guifg=#af0000
let g:gitgutter_sign_modified = 'M'

"" FZF
nnoremap <C-p> :Files<CR>
let g:fzf_action = { 'enter': 'tab split' }
set rtp+=/usr/local/opt/fzf
let $FZF_DEFAULT_OPTS="--preview-window 'right:57%' --bind ctrl-y:preview-up,ctrl-e:preview-down,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down"

"" Ctrlsf
vmap     <C-F> <Plug>CtrlSFVwordExec
nmap     <C-F> <Plug>CtrlSFCCwordPath
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
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Inlay color
hi CocInlayHint guifg=Grey ctermfg=Grey
hi CocWarningSign ctermbg=DarkYellow
hi CocInfoSign ctermbg=DarkYellow
hi CocErrorSign ctermbg=Red
hi CocHintSign ctermbg=DarkYellow
nmap <silent> <C-J> :call CocAction('diagnosticNext')<cr>
nmap <silent> <C-K> :call CocAction('diagnosticPrevious')<cr>
" Toggle inlay
nnoremap zi :CocCommand document.toggleInlayHint<CR>

" vim-gh-line
" also paste to clipboard
let g:gh_open_command = 'fn() { echo "$@" | pbcopy; }; fn '

"" Devicon
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:webdevicons_gui_glyph_fix = 1
"let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
let g:webdevicons_enable_nerdtree = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
"let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
"let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
"let g:DevIconsEnableFolderExtensionPatternMatching = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
"let g:WebDevIconsNerdTreeBeforeGlyphPadding = '        '

