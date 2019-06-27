vnoremap <silent> <CR> y:call system('nc localhost 7088 -w 0', @")<CR>
nnoremap <silent> <CR> :call system('nc localhost 7088 -w 0', getline('.'))<CR>
:set filetype=python
syntax on
highlight EndOfBuffer ctermfg=black ctermbg=black
set shortmess=at
