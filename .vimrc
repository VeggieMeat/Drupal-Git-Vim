set background=dark

set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent
set foldmethod=indent
set foldnestmax=1
set scrolloff=5

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
