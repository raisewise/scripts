#!/bin/sh

cat << EOF > ~/.vimrc
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab autoindent
set nu
EOF