" PLUGINS - plugin manager is plug.vim
call plug#begin()
" Plug 'tmhedberg/SimpylFold'                                   " Code folding for Python.
" Plug 'vim-syntastic/syntastic'                                " Syntax checking/highlighting for multiple languages.

" Navigation
Plug 'junegunn/fzf', {'do': { -> fzf#install() } }            " Fuzzy finder
Plug 'junegunn/fzf.vim'                                       
Plug 'scrooloose/nerdtree'                                    " Tree explorer plugin.	

"Color Scheme
Plug 'morhetz/gruvbox'                                        " Color Scheme.

" Autocomplete stuff
Plug 'neoclide/coc.nvim', {'branch': 'release'}               " Intellisense/autocomplete engine, full language server support.
Plug 'neovimhaskell/haskell-vim'                              " Contextually aware highlighting for Haskell.
Plug 'alx741/vim-hindent'                                     " Enforces Haskell programming standards.

Plug 'tpope/vim-fugitive'                                     " Git integration.

Plug 'mbbill/undotree'                                        " History traversal.

call plug#end()

let mapleader = " "

" Fundamental settings
syntax on
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1
set fileformat=unix
set fileformats=unix,dos,mac
" filetype plugin indent on

" Useful settings
set smartindent                           " Deprecated by language specific indent plugins, could remove soon.
set expandtab                             " Tabs to spaces.
set tabstop=2                             " Width of a tab.
set shiftwidth=2                          " Width of an indent.
set smartindent
set foldenable
set foldmethod=indent                     " Fold by indent.
set foldlevel=99                          " Files always open without folds.
set ignorecase                            " Ignores the case when searching text.
set smartcase                             " But if search contains uppercase, will not be ignored.
set noswapfile                            " No temp file created when editing.
set nobackup                              " No need for regular backup.
set nowritebackup
set undodir=$XDG_DATA_HOME/nvim/undodir   " Directory to store backup.
set undofile                              " 1 file per file open in vim stored in undodir.

" Visual
set termguicolors       " Enables true color of terminal.
let g:gruvbox_italic=1  " Enables italics for gruvbox, works for Kitty but may not for others.
set background=dark
colorscheme gruvbox     " Sets colorscheme
set number              " Displays line number.
set relativenumber
set nowrap              " No line wrapping.

" Remapping window movement keys
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" Coc config
source $XDG_CONFIG_HOME/nvim/CocConfig.vim

" fzf config
nnoremap <C-p> :GFiles<CR>
