setlocal smarttab
setlocal expandtab
setlocal shiftwidth=2
setlocal tabstop=2
setlocal softtabstop=2

map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>


