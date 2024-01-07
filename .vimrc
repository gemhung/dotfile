" " _____ _
" "|_   _| |__   ___ _ __ ___   ___
" "  | | | '_ \ / _ \ '_ ` _ \ / _ \
" "  | | | | | |  __/ | | | | |  __/
" "  |_| |_| |_|\___|_| |_| |_|\___|
"
"color desert
"color molokai
colorscheme molokai

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
set noswapfile

autocmd BufRead,BufNewFile *.htm,*.html setlocal tabstop=2 shiftwidth=2 softtabstop=2

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
"Plug 'itchyny/lightline.vim'                        " Status bar
Plug 'itchyny/vim-gitbranch'                        " Status bar
Plug 'neoclide/coc.nvim', {'branch': 'release'}    " !Not good for performance
Plug 'ruanyl/vim-gh-line'                            " Get github link
"Plug 'knsh14/vim-github-link'
"Plug 'tpope/vim-fugitive'
"Plug 'tpope/vim-rhubarb'
Plug 'ryanoasis/vim-devicons'                      " !Didn't work on mac
"Plug 'dense-analysis/ale'                           " Find errors
"Plug 'gemhung/rust-aledetail-pretty.vim'            " AutoComplete
Plug 'christoomey/vim-tmux-navigator'                " Navigate between vim and tmux
call plug#end()


" " ____  _             _              ____             __ _
" "|  _ \| |_   _  __ _(_)_ __  ___   / ___|___  _ __  / _(_) __ _
" "| |_) | | | | |/ _` | | '_ \/ __| | |   / _ \| '_ \| |_| |/ _` |
" "|  __/| | |_| | (_| | | | | \__ \ | |__| (_) | | | |  _| | (_| |
" "|_|   |_|\__,_|\__, |_|_| |_|___/  \____\___/|_| |_|_| |_|\__, |
" "               |___/                                      |___/

" " Lightline
"set noshowmode
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
"" Find previou error
"nmap <silent><C-k> <Plug>(ale_previous_wrap)
"" Find next error
"nmap <silent><C-j> <Plug>(ale_next_wrap)
"nmap <silent><C-l> <C-l>:ALEToggle<CR>
"let g:ale_open_list = 1
"let g:ale_detail_to_floating_preview = 1
"let g:ale_close_preview_on_insert = 1
"let g:ale_cursor_detail = 1
"let g:ale_lint_on_save = 1
""let g:ale_lint_on_enter = 1
"let g:ale_floating_window_border  = ['│', '─', '╭', '╮', '╯', '╰', '│', '─']
""For wide montior
""let g:ale_list_vertical = 1
"let g:ale_linters = {'rust': ['analyzer']}
"let g:ale_set_highlights = 0
"let g:ale_sign_error = 'XX'


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
"map <Tab> :call CheckNerdTree(":tabnext")<CR>
"map <S-Tab> :call CheckNerdTree(":tabp")<CR>
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
nnoremap <S-p> :Rg<CR>
let g:fzf_action = { 'enter': 'tab split' }
set rtp+=/usr/local/opt/fzf
let $FZF_DEFAULT_OPTS="--preview-window 'right:57%' --bind ctrl-y:preview-up,ctrl-e:preview-down,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down"

"" Ctrlsf
"vmap     <C-F> <Plug>CtrlSFVwordExec
"nmap     <C-F> <Plug>CtrlSFCCwordPath
"nnoremap <C-F><C-F> :CtrlSFToggle<CR>
""nmap     <C-F>f <Plug>CtrlSFPrompt
""vmap     <C-F> <Plug>CtrlSFVwordPath
""nmap     <C-F>p <Plug>CtrlSFPwordPath
""nnoremap <C-F>o :CtrlSFOpen<CR>
""inoremap <C-F>t <Esc>:CtrlSFToggle<CR>
"" compact view
"let g:ctrlsf_default_view_mode = 'compact'
"" focus at search result
"let g:ctrlsf_auto_focus = {
"    \ 'at': 'start',
"    \ }

"" COC
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gn :call CocAction('diagnosticNext')<cr>
nmap <silent> gp :call CocAction('diagnosticPrevious')<cr>
" Inlay color
hi CocInlayHint guifg=Grey ctermfg=Grey
hi CocUnusedHighlight cterm=underline   ctermbg=16
hi CocHintFloat         ctermfg=Yellow
hi CocFloatDividingLine ctermfg=DarkYellow
hi CocMarkdownLink      ctermfg=DarkYellow
hi CocPumSearch         ctermfg=Yellow  
hi CocNotificationProgress ctermfg=Yellow
"hi CocWarningSign   ctermbg=DarkYellow
"hi CocInfoSign      ctermbg=DarkYellow
"hi CocErrorSign     ctermbg=Red
"hi CocHintSign      ctermbg=DarkYellow
"hi CocHintSign      ctermbg=Red
" Navigate errors
" Toggle inlay
nnoremap zi :CocCommand document.toggleInlayHint<CR>
nnoremap zr :CocListResume<CR>
" Use K to show documentation in preview window
nnoremap <silent> gh :call ShowDocumentation()<CR>
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif CocAction('hasProvider', 'hover')
    if coc#float#has_float()
      call coc#float#jump()
      nnoremap <buffer> q <Cmd>close<CR>
    else
      call CocActionAsync('doHover')
    endif
  else
    call feedkeys('K', 'in')
  endif
endfunction
call coc#config('list', { 'maxPreviewHeight': 50 })

map <F3> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>
" a little more informative version of the above
nmap <Leader>sI :call <SID>SynStack()<CR>

function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

"CocWarningHighlight xxx cterm=underline ctermfg=3 gui=undercurl guifg=#EBCB8B
"CocErrorHighlight xxx cterm=underline ctermfg=1 gui=undercurl guifg=#BF616A
"CocInfoHighlight xxx links to CocUnderline
"CocHintHighlight xxx links to CocUnderline
"CocDeprecatedHighlight xxx links to CocStrikeThrough
"CocUnusedHighlight xxx links to CocFadeOut
"CocHighlightText xxx guifg=#d8dee9 guibg=#516f7a
"CocWarningSign xxx ctermfg=3 guifg=#d08770
"CocErrorSign   xxx ctermfg=1 guifg=#bf616a
"CocInfoSign    xxx ctermfg=6 guifg=#88C0D0
"CocHintSign    xxx ctermfg=12 guifg=#5E81AC
"CocFadeOut     xxx links to Comment
"CocErrorVirtualText xxx guifg=#bf616a
"CocWarningVirtualText xxx guifg=#d08770
"CocMenuSel     xxx ctermbg=8 guibg=#4C566A
"CocListLine    xxx ctermbg=17 guibg=#3e434e
"CocTreeSelected xxx links to CursorLine
"CocSelectedText xxx ctermfg=12 guifg=#fb4934
"CocCodeLens    xxx ctermfg=7 guifg=#999999
"CocUnderline   xxx term=underline cterm=underline gui=underline guisp=#ebdbb2
"CocBold        xxx term=bold cterm=bold gui=bold
"CocItalic      xxx term=italic cterm=italic gui=italic
"CocStrikeThrough xxx term=strikethrough cterm=strikethrough gui=strikethrough
"CocMarkdownLink xxx ctermfg=9 guifg=#15aabf
"CocDisabled    xxx ctermfg=7 guifg=#999999
"CocSearch      xxx ctermfg=9 guifg=#15aabf
"CocLink        xxx term=underline cterm=underline gui=underline guisp=#15aabf
"CocFloating    xxx links to Pmenu
"CocFloatThumb  xxx links to PmenuThumb
"CocFloatSbar   xxx links to PmenuSbar
"CocFloatActive xxx links to CocSearch
"CocMarkdownCode xxx links to markdownCode
"CocMarkdownHeader xxx links to markdownH1
"CocListSearch  xxx links to CocSearch
"CocListMode    xxx links to ModeMsg
"CocListPath    xxx links to Comment
"CocHoverRange  xxx links to Search
"CocCursorRange xxx links to Search
"CocLinkedEditing xxx links to CocCursorRange
"CocHighlightRead xxx links to CocHighlightText
"CocHighlightWrite xxx links to CocHighlightText
"CocNotificationProgress xxx ctermfg=9 guifg=#15aabf
"CocNotificationButton xxx links to CocUnderline
"CocNotificationError xxx links to CocErrorFloat
"CocErrorFloat  xxx ctermfg=1 ctermbg=0 guifg=#bf616a guibg=#434C5E
"CocNotificationWarning xxx links to CocWarningFloat
"CocWarningFloat xxx ctermfg=3 ctermbg=0 guifg=#d08770 guibg=#434C5E
"CocNotificationInfo xxx links to CocInfoFloat
"CocInfoFloat   xxx ctermfg=6 ctermbg=0 guifg=#88C0D0 guibg=#434C5E
"CocSnippetVisual xxx links to Visual
"CocTreeTitle   xxx links to Title
"CocTreeDescription xxx links to Comment
"CocTreeOpenClose xxx links to CocBold
"CocSelectedRange xxx links to CocHighlightText
"CocSymbolDefault xxx links to MoreMsg
"CocPumSearch   xxx links to CocSearch
"CocPumDetail   xxx links to Comment
"CocPumMenu     xxx links to CocFloating
"CocPumShortcut xxx links to Comment
"CocPumDeprecated xxx links to CocStrikeThrough
"CocVirtualText xxx ctermfg=12 guifg=#504945
"CocPumVirtualText xxx links to CocVirtualText
"CocInputBoxVirtualText xxx links to CocVirtualText
"CocFloatDividingLine xxx links to CocVirtualText
"CocInfoVirtualText xxx ctermfg=6 ctermbg=16 guifg=#88C0D0 guibg=#2E3440
"CocHintVirtualText xxx ctermfg=12 ctermbg=16 guifg=#5E81AC guibg=#2E3440
"CocHintFloat   xxx ctermfg=12 ctermbg=0 guifg=#5E81AC guibg=#434C5E
"CocInlayHint   xxx ctermfg=12 ctermbg=16 guifg=#5E81AC guibg=#2E3440
"CocInlayHintParameter xxx links to CocInlayHint
"CocInlayHintType xxx links to CocInlayHint
"CocListBlackBlack xxx guifg=#3B4252 guibg=#3B4252
"CocListBlackBlue xxx guifg=#3B4252 guibg=#81A1C1
"CocListBlackGreen xxx guifg=#3B4252 guibg=#A3BE8C
"CocListBlackGrey xxx guifg=#3B4252 guibg=#4C566A
"CocListBlackWhite xxx guifg=#3B4252 guibg=#E5E9F0
"CocListBlackCyan xxx guifg=#3B4252 guibg=#88C0D0
"CocListBlackYellow xxx guifg=#3B4252 guibg=#EBCB8B
"CocListBlackMagenta xxx guifg=#3B4252 guibg=#B48EAD
"CocListBlackRed xxx guifg=#3B4252 guibg=#BF616A
"CocListFgBlack xxx ctermfg=0 guifg=#3B4252
"CocListBgBlack xxx ctermbg=0 guibg=#3B4252
"CocListBlueBlack xxx guifg=#81A1C1 guibg=#3B4252
"CocListBlueBlue xxx guifg=#81A1C1 guibg=#81A1C1
"CocListBlueGreen xxx guifg=#81A1C1 guibg=#A3BE8C
"CocListBlueGrey xxx guifg=#81A1C1 guibg=#4C566A
"CocListBlueWhite xxx guifg=#81A1C1 guibg=#E5E9F0
"CocListBlueCyan xxx guifg=#81A1C1 guibg=#88C0D0
"CocListBlueYellow xxx guifg=#81A1C1 guibg=#EBCB8B
"CocListBlueMagenta xxx guifg=#81A1C1 guibg=#B48EAD
"CocListBlueRed xxx guifg=#81A1C1 guibg=#BF616A
"CocListFgBlue  xxx ctermfg=9 guifg=#81A1C1
"CocListBgBlue  xxx ctermbg=9 guibg=#81A1C1
"CocListGreenBlack xxx guifg=#A3BE8C guibg=#3B4252
"CocListGreenBlue xxx guifg=#A3BE8C guibg=#81A1C1
"CocListGreenGreen xxx guifg=#A3BE8C guibg=#A3BE8C
"CocListGreenGrey xxx guifg=#A3BE8C guibg=#4C566A
"CocListGreenWhite xxx guifg=#A3BE8C guibg=#E5E9F0
"CocListGreenCyan xxx guifg=#A3BE8C guibg=#88C0D0
"CocListGreenYellow xxx guifg=#A3BE8C guibg=#EBCB8B
"CocListGreenMagenta xxx guifg=#A3BE8C guibg=#B48EAD
"CocListGreenRed xxx guifg=#A3BE8C guibg=#BF616A
"CocListFgGreen xxx ctermfg=10 guifg=#A3BE8C
"CocListBgGreen xxx ctermbg=10 guibg=#A3BE8C
"CocListGreyBlack xxx guifg=#4C566A guibg=#3B4252
"CocListGreyBlue xxx guifg=#4C566A guibg=#81A1C1
"CocListGreyGreen xxx guifg=#4C566A guibg=#A3BE8C
"CocListGreyGrey xxx guifg=#4C566A guibg=#4C566A
"CocListGreyWhite xxx guifg=#4C566A guibg=#E5E9F0
"CocListGreyCyan xxx guifg=#4C566A guibg=#88C0D0
"CocListGreyYellow xxx guifg=#4C566A guibg=#EBCB8B
"CocListGreyMagenta xxx guifg=#4C566A guibg=#B48EAD
"CocListGreyRed xxx guifg=#4C566A guibg=#BF616A
"CocListFgGrey  xxx ctermfg=7 guifg=#4C566A
"CocListBgGrey  xxx ctermbg=7 guibg=#4C566A
"CocListWhiteBlack xxx guifg=#E5E9F0 guibg=#3B4252
"CocListWhiteBlue xxx guifg=#E5E9F0 guibg=#81A1C1
"CocListWhiteGreen xxx guifg=#E5E9F0 guibg=#A3BE8C
"CocListWhiteGrey xxx guifg=#E5E9F0 guibg=#4C566A
"CocListWhiteWhite xxx guifg=#E5E9F0 guibg=#E5E9F0
"CocListWhiteCyan xxx guifg=#E5E9F0 guibg=#88C0D0
"CocListWhiteYellow xxx guifg=#E5E9F0 guibg=#EBCB8B
"CocListWhiteMagenta xxx guifg=#E5E9F0 guibg=#B48EAD
"CocListWhiteRed xxx guifg=#E5E9F0 guibg=#BF616A
"CocListFgWhite xxx ctermfg=15 guifg=#E5E9F0
"CocListBgWhite xxx ctermbg=15 guibg=#E5E9F0
"CocListCyanBlack xxx guifg=#88C0D0 guibg=#3B4252
"CocListCyanBlue xxx guifg=#88C0D0 guibg=#81A1C1
"CocListCyanGreen xxx guifg=#88C0D0 guibg=#A3BE8C
"CocListCyanGrey xxx guifg=#88C0D0 guibg=#4C566A
"CocListCyanWhite xxx guifg=#88C0D0 guibg=#E5E9F0
"CocListCyanCyan xxx guifg=#88C0D0 guibg=#88C0D0
"CocListCyanYellow xxx guifg=#88C0D0 guibg=#EBCB8B
"CocListCyanMagenta xxx guifg=#88C0D0 guibg=#B48EAD
"CocListCyanRed xxx guifg=#88C0D0 guibg=#BF616A
"CocListFgCyan  xxx ctermfg=11 guifg=#88C0D0
"CocListBgCyan  xxx ctermbg=11 guibg=#88C0D0
"CocListYellowBlack xxx guifg=#EBCB8B guibg=#3B4252
"CocListYellowBlue xxx guifg=#EBCB8B guibg=#81A1C1
"CocListYellowGreen xxx guifg=#EBCB8B guibg=#A3BE8C
"CocListYellowGrey xxx guifg=#EBCB8B guibg=#4C566A
"CocListYellowWhite xxx guifg=#EBCB8B guibg=#E5E9F0
"CocListYellowCyan xxx guifg=#EBCB8B guibg=#88C0D0
"CocListYellowYellow xxx guifg=#EBCB8B guibg=#EBCB8B
"CocListYellowMagenta xxx guifg=#EBCB8B guibg=#B48EAD
"CocListYellowRed xxx guifg=#EBCB8B guibg=#BF616A
"CocListFgYellow xxx ctermfg=14 guifg=#EBCB8B
"CocListBgYellow xxx ctermbg=14 guibg=#EBCB8B
"CocListMagentaBlack xxx guifg=#B48EAD guibg=#3B4252
"CocListMagentaBlue xxx guifg=#B48EAD guibg=#81A1C1
"CocListMagentaGreen xxx guifg=#B48EAD guibg=#A3BE8C
"CocListMagentaGrey xxx guifg=#B48EAD guibg=#4C566A
"CocListMagentaWhite xxx guifg=#B48EAD guibg=#E5E9F0
"CocListMagentaCyan xxx guifg=#B48EAD guibg=#88C0D0
"CocListMagentaYellow xxx guifg=#B48EAD guibg=#EBCB8B
"CocListMagentaMagenta xxx guifg=#B48EAD guibg=#B48EAD
"CocListMagentaRed xxx guifg=#B48EAD guibg=#BF616A
"CocListFgMagenta xxx ctermfg=13 guifg=#B48EAD
"CocListBgMagenta xxx ctermbg=13 guibg=#B48EAD
"CocListRedBlack xxx guifg=#BF616A guibg=#3B4252
"CocListRedBlue xxx guifg=#BF616A guibg=#81A1C1
"CocListRedGreen xxx guifg=#BF616A guibg=#A3BE8C
"CocListRedGrey xxx guifg=#BF616A guibg=#4C566A
"CocListRedWhite xxx guifg=#BF616A guibg=#E5E9F0
"CocListRedCyan xxx guifg=#BF616A guibg=#88C0D0
"CocListRedYellow xxx guifg=#BF616A guibg=#EBCB8B
"CocListRedMagenta xxx guifg=#BF616A guibg=#B48EAD
"CocListRedRed  xxx guifg=#BF616A guibg=#BF616A
"CocListFgRed   xxx ctermfg=12 guifg=#BF616A
"CocListBgRed   xxx ctermbg=12 guibg=#BF616A
"CocSemNumber   xxx links to Number
"CocSemFunction xxx links to Function
"CocSemKeyword  xxx links to Keyword
"CocSemParameter xxx links to Identifier
"CocSemEvent    xxx links to Keyword
"CocSemModifier xxx links to StorageClass
"CocSemMacro    xxx links to Define
"CocSemDeprecated xxx links to CocDeprecatedHighlight
"CocSemClass    xxx links to Special
"CocSemDecorator xxx links to Identifier
"CocSemOperator xxx links to Operator
"CocSemStruct   xxx links to Identifier
"CocSemRegexp   xxx links to String
"CocSemMethod   xxx links to Function
"CocSemComment  xxx links to Comment
"CocSemEnum     xxx links to Type
"CocSemInterface xxx links to Type
"CocSemType     xxx links to Type
"CocSemProperty xxx links to Identifier
"CocSemTypeParameter xxx links to Identifier
"CocSemEnumMember xxx links to Constant
"CocSemBoolean  xxx links to Boolean
"CocSemNamespace xxx links to Include
"CocSemString   xxx links to String
"CocSemVariable xxx links to Identifier
"CocSymbolUnit  xxx ctermfg=6 guifg=#88C0D0
"CocSymbolNumber xxx ctermfg=5 guifg=#B48EAD
"CocSymbolFunction xxx ctermfg=6 guifg=#88C0D0
"CocSymbolKey   xxx ctermfg=223 guifg=#D8DEE9
"CocSymbolKeyword xxx ctermfg=4 guifg=#81A1C1
"CocSymbolReference xxx ctermfg=223 guifg=#D8DEE9
"CocSymbolFolder xxx ctermfg=6 guifg=#88C0D0
"CocSymbolVariable xxx ctermfg=223 guifg=#D8DEE9
"CocSymbolNull  xxx ctermfg=4 guifg=#81A1C1
"CocSymbolValue xxx ctermfg=6 guifg=#88C0D0
"CocSymbolConstant xxx ctermfg=223 guifg=#D8DEE9
"CocSymbolText  xxx ctermfg=6 guifg=#88C0D0
"CocSymbolModule xxx ctermfg=4 guifg=#81A1C1
"CocSymbolPackage xxx ctermfg=4 guifg=#81A1C1
"CocSymbolClass xxx ctermfg=223 guifg=#D8DEE9
"CocSymbolOperator xxx ctermfg=4 guifg=#81A1C1
"CocSymbolStruct xxx ctermfg=4 guifg=#81A1C1
"CocSymbolObject xxx ctermfg=6 guifg=#88C0D0
"CocSymbolMethod xxx ctermfg=6 guifg=#88C0D0
"CocSymbolArray xxx ctermfg=6 guifg=#88C0D0
"CocSymbolEnum  xxx ctermfg=6 guifg=#88C0D0
"CocSymbolField xxx ctermfg=223 guifg=#D8DEE9
"CocSymbolInterface xxx ctermfg=6 guifg=#88C0D0
"CocSymbolProperty xxx ctermfg=223 guifg=#D8DEE9
"CocSymbolColor xxx ctermfg=5 guifg=#B48EAD
"CocSymbolFile  xxx ctermfg=4 guifg=#81A1C1
"CocSymbolEvent xxx ctermfg=223 guifg=#D8DEE9
"CocSymbolTypeParameter xxx ctermfg=223 guifg=#D8DEE9
"CocSymbolConstructor xxx ctermfg=223 guifg=#D8DEE9
"CocSymbolSnippet xxx ctermfg=6 guifg=#88C0D0
"CocSymbolBoolean xxx ctermfg=4 guifg=#81A1C1
"CocSymbolNamespace xxx ctermfg=4 guifg=#81A1C1
"CocSymbolString xxx ctermfg=2 guifg=#A3BE8C
"CocSymbolEnumMember xxx ctermfg=223 guifg=#D8DEE9
"CocSelectedLine xxx cleared
"CocErrorLine   xxx cleared
"CocWarningLine xxx cleared
"CocInfoLine    xxx cleared
"CocHintLine    xxx cleared

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

set previewheight=100

" vim-tmux-navigator
"let g:tmux_navigator_no_mappings = 1
"noremap ˙ :TmuxNavigateLeft<cr>
"noremap ∆ :TmuxNavigateDown<cr>
"noremap ˚ :TmuxNavigateUp<cr>
"noremap ¬ :TmuxNavigateRight<cr>
"noremap ∑ :TmuxNavigatePrevious<cr>
"
"noremap ˙ :TmuxNavigateLeft<cr>
"noremap ∆ :TmuxNavigateDown<cr>
"noremap <C-k> :TmuxNavigateUp<cr>
"noremap ¬ :TmuxNavigateRight<cr>
"noremap ∑ :TmuxNavigatePrevious<cr>
