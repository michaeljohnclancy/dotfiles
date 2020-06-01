"Coc.nvim config

" SETTINGS
set hidden                                " Windowing doesn't work without this. Allows moving to new buffer without having to save.
set cmdheight=2                           " More height for displaying messages.

set updatetime=300                        " Noticeable delays when left at default (4 seconds).

set shortmess+=c                          " Dont pass messages to ins-completion-menu.
"

" KEY-BINDINGS

"""" NAVIGATION
" Goto definition
nmap <leader>gd <Plug>(coc-definition)
" Find references
nmap <leader>gr <Plug>(coc-references) 
" Find type definition
nmap <leader>gy <Plug>(coc-type-definition)
" Find implementation
nmap <leader>gi <Plug>(coc-implementation)
""""

"""" AUTOCOMPLETION
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
""""

"""" DOCUMENTATION
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
""""
"

" HELPER FUNCTIONS
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
"
