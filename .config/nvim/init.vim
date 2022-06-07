"======================================================================================================================"
" Plugins
"======================================================================================================================"

call plug#begin()

Plug 'neovim/nvim-lspconfig'
Plug 'tpope/vim-fugitive'

call plug#end()

"======================================================================================================================"
" Language Server Settings
"======================================================================================================================"

lua << EOF
require'lspconfig'.hls.setup{
  root_dir = require'lspconfig'.util.root_pattern('*.cabal', 'stack.yaml', 'cabal.project', 'package.yaml', 'hie.yaml', '.git'),
}
require'lspconfig'.clangd.setup{
  cmd = { "/Library/Developer/CommandLineTools/usr/bin/clangd", "--background-index" }
}
require'lspconfig'.pylsp.setup{}
require'lspconfig'.ocamlls.setup{
  root_dir = require'lspconfig'.util.root_pattern("*.opam", "esy.json", "package.json", ".git"),
}
EOF

nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gR <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> gh <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gt <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gw <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gn <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent> gp <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> gK <cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>

"======================================================================================================================"
" General Editor Settings
"======================================================================================================================"

set number
set relativenumber
set shiftwidth=2
set tabstop=2
set expandtab
set nowrap
set textwidth=120
highlight Comment cterm=italic
let g:netrw_header=0
let g:netrw_banner=0
let c_no_curly_error=1

highlight SignColumn cterm=none ctermfg=none ctermbg=none

au Filetype qf wincmd J

set fdm=syntax
set foldlevelstart=99

highlight DiffAdd cterm=none ctermfg=none ctermbg=22
highlight DiffDelete cterm=none ctermfg=none ctermbg=52
highlight DiffChange cterm=none ctermfg=none ctermbg=17
highlight DiffText cterm=none ctermfg=none ctermbg=17

highlight Folded cterm=italic ctermfg=Grey ctermbg=none
highlight FoldColumn cterm=none ctermfg=Grey ctermbg=none

highlight TabLineSel cterm=bold,reverse ctermfg=none ctermbg=none
highlight TabLine cterm=none,reverse ctermfg=none ctermbg=none
highlight TabLineFill cterm=none,reverse ctermfg=none ctermbg=none

function! MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T'

    " the label is made by MyTabLabel()
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

  return s
endfunction

function! MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let m = 0
  for b in tabpagebuflist(a:n)
    if getbufvar(b, "&modified")
      let m += 1
    endif
  endfor
  let s = fnamemodify(bufname(buflist[winnr - 1]), ':t')
  if s == ''
    let s = '[No Name]'
  endif
  if m > 0
    let s .= ' [' . m . '+]'
  endif
  return s
endfunction

set tabline=%!MyTabLine()
set showtabline=2

set wildmode=longest,list
set wildmenu

au BufRead,BufNewFile *.tex set filetype=tex

let g:tex_no_error=1
