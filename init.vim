call plug#begin('~/.config/nvim/plugged')

" resize window
Plug 'simeji/winresizer'

" LSP configuration
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'

"ale 
Plug 'dense-analysis/ale'

" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" tree viewer
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/glyph-palette.vim'

" status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" php
Plug 'stephpy/vim-php-cs-fixer'

" javascript
Plug 'pangloss/vim-javascript'

" typescript
Plug 'leafgarland/typescript-vim'

" vue
Plug 'posva/vim-vue'
Plug 'Shougo/context_filetype.vim'

call plug#end()


" Neovim Settings
cnoremap init :<C-u>edit $MYVIMRC<CR>
set number
set expandtab
set tabstop=4
set shiftwidth=4

" tree viewer
nnoremap <silent> <leader>f. :Fern .<cr>
nnoremap <silent> <leader>fd :Fern . -drawer<cr>
nnoremap <silent> <leader>fr :Fern . -reveal=%:p<cr>
let g:fern#renderer = "nerdfont"

augroup my-glyph-palette
    autocmd! *
    autocmd FileType fern call glyph_palette#apply()
    autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END

" status bar
let g:airline#extensions#tabline#enabled = 1

" telescope
nnoremap <silent> <leader>ff <cmd>Telescope find_files<cr>
nnoremap <silent> <leader>fb <cmd>Telescope buffers<cr>
nnoremap <silent> <leader>kc <cmd>Telescope git_commits<cr>
nnoremap <silent> <leader>kv <cmd>Telescope git_bcommits<cr>
nnoremap <silent> <leader>kb <cmd>Telescope git_branches<cr>
nnoremap <silent> <leader>ks <cmd>Telescope git_status<cr>

lua << EOF
    local actions = require('telescope.actions')
    require('telescope').setup({
        defaults = {
            mappings = {
                i = {
                    ["<c-j>"] = actions.move_selection_next,
                    ["<c-k>"] = actions.move_selection_previous
                }
            }
        }
    })
EOF

" php
nnoremap <silent> <leader>pcd :call PhpCsFixerFixDirectory()<cr>
nnoremap <silent> <leader>pcf :call PhpCsFixerFixFile()<cr>
