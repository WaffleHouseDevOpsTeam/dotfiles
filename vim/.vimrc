" basic formatting for tabs (or lack thereof) and spaces
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" line numbering
set relativenumber
set number

set autoindent
" syntax highlighting
syntax on

" allows for fuzzy file finding
set path+=**
set wildmenu

" file browsing for netRW 
let g:netrw_banner=0        " disable annoying banner
" let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
" let g:netrw_liststyle=3     " tree view
" let g:netrw_list_hide=netrw_gitignore#Hide()
" let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

