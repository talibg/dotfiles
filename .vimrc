" =============================================================================
" Plugin Management (vim-plug)
" =============================================================================
if empty(glob('~/.vim/autoload/plug.vim'))
  if !isdirectory('~/.vim/autoload')
    call mkdir('~/.vim/autoload', 'p')
  endif
  silent execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
  Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
  Plug 'vim-airline/vim-airline'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'rakr/vim-one', {'branch': 'master'}
  Plug 'sheerun/vim-polyglot'
  Plug 'ryanoasis/vim-devicons'
  Plug 'prisma/vim-prisma'
call plug#end()

" =============================================================================
" General Settings
" =============================================================================
set nocompatible " Disable vi compatibility
set number " Show line numbers
set smartindent " Enable smart indentation
set tabstop=4 " Set tab width to 4 spaces
set shiftwidth=4 " Set shift width to 4 spaces
set expandtab " Use spaces instead of tabs
set incsearch " Enable incremental search
set hlsearch " Highlight search results
set ignorecase " Ignore case in searches
set smartcase " Be case-sensitive if search contains upper case
set wrap " Enable line wrapping
set showmatch " Show matching brackets
set encoding=utf-8 " Set default encoding to UTF-8
set nobackup " Disable backup files
set nowritebackup " Disable write backup files
set updatetime=300 " Set update time for autocompletion
set signcolumn=yes " Always show the sign column
set termguicolors " Enable true color support
set background=dark " Set background to dark

" =============================================================================
" Colorscheme
" =============================================================================
colorscheme one
let g:one_allow_italics = 1

" =============================================================================
" Airline Configuration
" =============================================================================
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_theme='one'

" =============================================================================
" Coc.nvim Configuration
" =============================================================================
let s:coc_extensions = ['coc-tsserver', 'coc-json', 'coc-pairs', 'coc-prisma']

if isdirectory('./.git')
  let s:coc_extensions += ['coc-git']
endif

if isdirectory('./node_modules')
  if isdirectory('./node_modules/prettier')
    let s:coc_extensions += ['coc-prettier']
  endif
  if isdirectory('./node_modules/eslint')
    let s:coc_extensions += ['coc-eslint']
  endif
endif

let g:coc_global_extensions = s:coc_extensions

" =============================================================================
" Autocommands
" =============================================================================
augroup coc_settings
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  autocmd BufWritePre * CocCommand eslint.executeAutofix
augroup end

" =============================================================================
" Commands
" =============================================================================
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile') " coc-prettier
command! -nargs=0 Format :call CocActionAsync('format')

" =============================================================================
" Key Mappings (No Changes)
" =============================================================================
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gtd <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm(): "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <c-@> coc#refresh()
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
nnoremap <silent><nowait> <space>a :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <space>e :<C-u>CocList extensions<cr>
nnoremap <silent><nowait> <space>c :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <space>o :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <space>s :<C-u>CocList -I symbols<cr>
nnoremap <silent><nowait> <space>j :<C-u>CocNext<CR>
nnoremap <silent><nowait> <space>k :<C-u>CocPrev<CR>
nnoremap <silent><nowait> <space>p :<C-u>CocListResume<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
