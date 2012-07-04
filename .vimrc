set background=dark

set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent
set foldmethod=indent
set foldnestmax=1
set scrolloff=5

" fix the autoindent issue on paste
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" set git status message
set laststatus=2
set statusline=%<\ \[\[%{GitBranch()}\]\]\ %n:%f\ %m%r%y%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%)

if has("autocmd")
  augroup module
    autocmd BufRead,BufNewFile *.module set filetype=php
    autocmd BufRead,BufNewFile *.install set filetype=php
    autocmd BufRead,BufNewFile *.test set filetype=php
    autocmd BufRead,BufNewFile *.inc set filetype=php
  augroup END
endif
syntax on

" automatically remove trailing whitespace before write
function! StripWhitespace()
normal mZ
%s/\s\+$//e
if line("'Z") != line(".")
  echo "Stripped whitespace\n"
endif
normal `Z
endfunction
autocmd BufWritePre * :call StripWhitespace()
autocmd FileWritePre * :call StripWhitespace()
autocmd FileAppendPre * :call StripWhitespace()
autocmd FilterWritePre * :call StripWhitespace()

" Highlight redundant whitespaces and tabs.
highlight RedundantSpaces ctermbg=red guibg=red
match RedundantSpaces /\s\+$\| \+\ze\t\|\t/

" syntastic
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': ['php', 'css', 'html', 'xhtml', 'javascript'] }

" remap leader to ,
let mapleader = ','

" NerdTree
map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
map <leader>e :NERDTreeFind<CR>
nmap <leader>nt :NERDTreeFind<CR>

let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1

" Edit vimrc in a new tab
nmap <leader>v :tabedit $MYVIMRC<CR>

" Source the vimrc file after saving it
if has("autocmd")
  augroup myvimrchooks
    au!
      autocmd bufwritepost .vimrc source ~/.vimrc
      autocmd bufwritepost .vimrc.local source ~/.vimrc.local
    augroup END
  endif

" Use :W to save a file as root instead of having to have a good memory
:command! W w !sudo tee % >/dev/null
