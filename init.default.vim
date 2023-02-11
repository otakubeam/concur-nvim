" Install Plug - a minimalist vim plugin manager
if !filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
  echo "Downloading junegunn/vim-plug to manage plugins..."
  silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
  silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
  silent !curl "https://raw.githubusercontent.com/otakubeam/concur-nvim/master/coc-settings.json" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/coc-settings.json
  autocmd VimEnter * PlugInstall
  autocmd VimEnter * CocInstall
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'rhysd/vim-clang-format'

  Plug 'easymotion/vim-easymotion'
  Plug 'jiangmiao/auto-pairs'

  Plug 'voldikss/vim-floaterm'
  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'airblade/vim-gitgutter'
  
  Plug 'octol/vim-cpp-enhanced-highlight'
  Plug 'ayu-theme/ayu-vim'
  Plug 'bling/vim-airline'
call plug#end()

let g:floaterm_keymap_new    = '<F7>'
let g:floaterm_keymap_prev   = '<F8>'
let g:floaterm_keymap_next   = '<F9>'
let g:floaterm_keymap_toggle = '<F12>'

" Delimitmate fix
imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<Plug>delimitMateCR"

" Some basics:
nnoremap c "_c
set nocompatible
set go=a
set mouse=a
set clipboard+=unnamedplus
filetype plugin on
syntax on
set encoding=utf-8
set number relativenumber
set tabstop=2 softtabstop=2 shiftwidth=2
set smarttab autoindent expandtab
set hlsearch

" Enable true colors support
set termguicolors
let ayucolor="dark"
colorscheme ayu

map <leader><leader>. <Plug>(easymotion-repeat)
map <leader><leader>f <Plug>(easymotion-overwin-f2)
map <leader><leader>l <Plug>(easymotion-overwin-line)
map <leader><leader>w <Plug>(easymotion-overwin-w)

" Explicitly show spaces and tabs
" set listchars+=space:·,trail:·
" set list

" Save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

" Go to prev buffer is aliased to E
nnoremap E :e#

" Enable autocompletion:
set wildmenu
set wildmode=longest,list

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Nerd tree
map <leader>n :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeWinSize=20

" Shortcutting split navigation, saving a keypress:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
set splitbelow splitright

"-----------------------------------------------------------------------------

let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'Mod',
                \ 'Staged'    :'Stg',
                \ 'Untracked' :'Ntr',
                \ 'Renamed'   :'Rnm',
                \ 'Unmerged'  :'Nmr',
                \ 'Deleted'   :'Del',
                \ 'Dirty'     :'Drt',
                \ 'Ignored'   :'Ign',
                \ 'Clean'     :'Cln',
                \ 'Unknown'   :'?',
                \ }

"-----------------------------------------------------------------------------
" clang_format configuration
" https://github.com/rhysd/vim-clang-format for more options

" set version of clang-format, default is "clang-format"
let g:clang_format#command = "clang-format-11"

" automatic style detection
let g:clang_format#detect_style_file = 1

" format on write
let g:clang_format#auto_format = 1

" ClangFormat is also manually activated by pressing '\' + 'f' + Enter
nnoremap <Leader>f :<C-u>ClangFormat<CR>

"-----------------------------------------------------------------------------
" Coc configuration. Mostly taken from
" https://github.com/neoclide/coc.nvim#example-vim-configuration

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=250

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')


" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
