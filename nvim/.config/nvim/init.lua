vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set relativenumber")
vim.cmd("set number")


vim.cmd("set path+=**")
vim.cmd("set wildmenu")

vim.cmd("let g:netrw_banner=0")        -- disable annoying banner
vim.cmd("let g:netrw_browse_split=4")  -- open in prior window
vim.cmd("let g:netrw_altv=1")          -- open splits to the right
vim.cmd("let g:netrw_liststyle=3")     --tree view
vim.cmd("let g:netrw_list_hide=netrw_gitignore#Hide()")
-- vim.cmd("let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'")


vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
vim.opt.clipboard = 'unnamed', 'unnamedplus'

require("config.lazy")
