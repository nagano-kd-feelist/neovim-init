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

"LSP
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<cr>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<cr>
nnoremap <silent> <leader>u <cmd>lua vim.lsp.buf.rename()<cr>
nnoremap <silent> <leader>e <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>
nnoremap <silent> [e <cmd>lua vim.lsp.diagnostic.goto_prev()<cr>
nnoremap <silent> ]e <cmd>lua vim.lsp.diagnostic.goto_next()<cr>

lua vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false, underline = false })
lua require'lspconfig'.vimls.setup{}
lua require'lspconfig'.jsonls.setup{ settings = { json = { schemas = { { fileMatch = {'tsconfig.json'}, url = 'http://json.schemastore.org/tsconfig' }, { fileMatch = {'.eslintrc.json'}, url = 'http://json.schemastore.org/eslintrc' } } } } }
lua require'lspconfig'.tsserver.setup{}
lua require'lspconfig'.intelephense.setup{}
lua require'lspconfig'.vuels.setup{}
lua require'lspconfig'.ccls.setup{}
lua require'lspconfig'.rls.setup{}
lua require'lspconfig'.gopls.setup{}

" auto complete
inoremap <silent><expr> <c-space> compe#complete()
inoremap <silent><expr> <c-k> compe#confirm('<cr>')
inoremap <silent><expr> <c-e> compe#close('<c-e>')

let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.allow_prefix_unmatch = v:false
let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.spell = v:true
let g:compe.source.tags = v:true
let g:compe.source.snippets_nvim = v:true

" ale
let g:ale_disable_lsp = 1
let g:ale_fix_on_save = 1
let g:ale_fixers = {
    \'html': [],
    \'json': ['prettier'],
    \'javascript': ['eslint'],
    \'typescript': ['eslint'],
    \'vue': ['eslint']
\}

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
nnoremap <silent> <leader>fl <cmd>Telescope live_grep<cr>
nnoremap <silent> <leader>fg <cmd>Telescope grep_string<cr>
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
