" Fisa-nvim-config
" http://nvim.fisadev.com
" version: 11.1

" Vim-plug initialization {{{
" Avoid modifying this section, unless you are very sure of what you are doing

let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.config/nvim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    silent !mkdir -p ~/.config/nvim/autoload
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

" Obscure hacks done, you can now modify the rest of the .vimrc as you wish :)
" }}}
" Active plugins {{{
" You can disable or add new ones here:

" this needs to be here, so vim-plug knows we are declaring the plugins we
" want to use
call plug#begin('~/.config/nvim/plugged')

" Now the actual plugins:

" VimWiki
Plug 'vimwiki/vimwiki'

" Golang plugin
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Markdown previewer
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

" Markdown Syntax
Plug 'godlygeek/tabular'
Plug 'elzr/vim-json'
Plug 'plasticboy/vim-markdown'

" Code commenter
Plug 'scrooloose/nerdcommenter'

" Better file browser
Plug 'scrooloose/nerdtree'

" Class/module browser
Plug 'majutsushi/tagbar'
" TODO known problems:
" * current block not refreshing

" Search results counter
Plug 'vim-scripts/IndexedSearch'

" Badwolf Colorscheme
Plug 'sjl/badwolf'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Code and files fuzzy finder
" Plug 'ctrlpvim/ctrlp.vim'
" Extension to ctrlp, for fuzzy command finder
" Plug 'fisadev/vim-ctrlp-cmdpalette'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Async autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Completion from other opened files
Plug 'Shougo/context_filetype.vim'
" Python autocompletion
Plug 'zchee/deoplete-jedi', { 'do': ':UpdateRemotePlugins' }
" Just to add the python go-to-definition and similar features, autocompletion
" from this plugin is disabled
Plug 'davidhalter/jedi-vim'

" Automatically close parenthesis, etc
Plug 'Townk/vim-autoclose'

" Surround
Plug 'tpope/vim-surround'

" Indent text object
Plug 'michaeljsmith/vim-indent-object'

" Indentation based movements
Plug 'jeetsukumaran/vim-indentwise'

" Better language packs
Plug 'sheerun/vim-polyglot'

" Paint css colors with the real color
Plug 'lilydjwg/colorizer'

" Window chooser
Plug 't9md/vim-choosewin'

" Automatically sort python imports
Plug 'fisadev/vim-isort'

" Highlight matching html tags
Plug 'valloric/MatchTagAlways'

" Generate html in a simple way
Plug 'mattn/emmet-vim'

" Git integration
Plug 'tpope/vim-fugitive'

" Git/mercurial/others diff icons on the side of the file lines
Plug 'mhinz/vim-signify'

" Yank history navigation
Plug 'vim-scripts/YankRing.vim'

" Black Linter integration
Plug 'psf/black', { 'branch': 'stable' }

" Nice icons
Plug 'ryanoasis/vim-devicons'

" Easier Terminal splits
Plug 'vimlab/split-term.vim'

" Dracula theme
Plug 'dracula/vim', {'as': 'dracula'}

" Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()

" Install plugins the first time vim runs

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif
" }}}
" Vim settings and mappings {{{
" You can edit them as you wish

" tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
if has("autocmd")
    au BufReadPost * if &modifiable | retab | endif
endif

" autoread and autowrite
augroup save
    au!
    au FocusLost * wall
augroup END
set nohidden
set nobackup
set noswapfile
set nowritebackup
set autoread
set autowrite
set autowriteall

" persistant undo
set undodir=~/.vim/undo
set undofile

set path+=**

" 

" Reloads vimrc after saving but keeps cursor position
if !exists('*ReloadVimrc')
    fun! ReloadVimrc()
        let save_cursor = getcurpos()
        source $MYVIMRC
        call setpos('.', save_cursor)
    endfun
endif
autocmd! BufWritePost $MYVIMRC call ReloadVimrc()

" Set 80 character column identifier
set colorcolumn=80,100,120

" show line numbers
set number relativenumber

" Toggle between number and relativenumber
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set number relativenumber
    endif
endfunc

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

nnoremap <F2> :call ToggleNumber()<CR>
nnoremap <F5> :buffers<CR>:buffer<Space>

" Highlight current line
set cursorline

" Load filetype-specific indent files
filetype indent on

" Visual autocompletion for command window
set wildmenu

" Redraw only when needed
set lazyredraw

" Highlight matching brackets
set showmatch

" Transparent background
let g:dracula_colorterm = 0

" use 256 colors when possible
if (&term =~? 'mlterm\|xterm\|xterm-256\|screen-256') || has('nvim')
    let &t_Co = 256
    colorscheme dracula
else
    colorscheme delek
endif

" needed so deoplete can auto select the first suggestion
" set completeopt+=noinsert
" comment this line to enable autocompletion preview window
" (displays documentation related to the selected completion option)
" set completeopt-=preview

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest

" when scrolling, keep cursor 5 lines away from screen border
set scrolloff=5

" clear search results
nnoremap <silent> // :noh<CR>

" clear empty spaces at the end of lines on save of python files
autocmd BufWritePre *.py :%s/\s\+$//e

" Ability to add python breakpoints
" (I use ipdb, but you can change it to whatever tool you use for debugging)
au FileType python map <silent> <leader>b Oimport pudb; pudb.set_trace()<esc>

set incsearch " Search as characters are entered
set hlsearch " Highlight matches

" Turn off search highlight
nnoremap <leader>m :nohlsearch<CR>

" Enable folding
set foldenable
set foldlevelstart=10 " Open most folds when file opened
set foldnestmax=10 " Only nest folds 10 deep
" Use Space to open and close folds
nnoremap <space> za
set foldmethod=indent

" Movement remaps
" Visually move between lines
nnoremap j gj
nnoremap k gk
" Move to beginning/end of line with better keybindings
nnoremap B ^
nnoremap E $
" Highlight last inserted text
nnoremap gV `[v`]

" Leader Shortcuts
let mapleader=","
" Use jk as escape
inoremap jk <esc>

" Check final line for modeline
set modelines=1

" Set Python interpreters
let g:python3_host_prog = '/home/dustyp/.pyenv/versions/3.8.2/bin/python'
let g:python2_host_prog = '/home/dustyp/.pyenv/versions/2.7.16/bin/python'

" Remap Ctrl+hjkl to move between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Enable Mouse support
set mouse=a
" }}}
" Plugins settings and mappings {{{
" Tagbar {{{

" toggle tagbar display
map <F4> :TagbarToggle<CR>
" autofocus on tagbar open
let g:tagbar_autofocus = 1
" }}}
" NERDTree {{{

" toggle nerdtree display
map <F3> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
nmap <leader>t :NERDTreeFind<CR>
" don;t show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']
" }}}
" Black {{{

" Execute Black on file save
autocmd BufWritePre *.py execute ':Black'

" Execute Black with keypress
nnoremap <F9> :Black<CR>
" }}}
" Fzf {{{

" file finder mapping
nmap <leader>e :Files<CR>
" tags (symbols) in current file finder mapping
nmap <leader>g :BTag<CR>
" tags (symbols) in all files finder mapping
nmap <leader>G :Tags<CR>
" general code finder in current file mapping
nmap <leader>f :BLines<CR>
" general code finder in all files mapping
nmap <leader>F :Lines<CR>
" commands finder mapping
nmap <leader>c :Commands<CR>
" search in path
nmap <leader>ag :Ag<CR>
" to be able to call CtrlP with default search text
function! CtrlPWithSearchText(search_text, ctrlp_command_end)
    execute ':CtrlP' . a:ctrlp_command_end
    call feedkeys(a:search_text)
endfunction
" same as previous mappings, but calling with current word as default text
nmap <leader>wg :call CtrlPWithSearchText(expand('<cword>'), 'BufTag')<CR>
nmap <leader>wG :call CtrlPWithSearchText(expand('<cword>'), 'BufTagAll')<CR>
nmap <leader>wf :call CtrlPWithSearchText(expand('<cword>'), 'Line')<CR>
nmap <leader>we :call CtrlPWithSearchText(expand('<cword>'), '')<CR>
nmap <leader>pe :call CtrlPWithSearchText(expand('<cfile>'), '')<CR>
nmap <leader>wm :call CtrlPWithSearchText(expand('<cword>'), 'MRUFiles')<CR>
nmap <leader>wc :call CtrlPWithSearchText(expand('<cword>'), 'CmdPalette')<CR>
" }}}
" Deoplete {{{

" Use deoplete.

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
call deoplete#custom#option("enable_smart_case", 1)
" complete with words from any opened file
let g:context_filetype#same_filetypes = {}
let g:context_filetype#same_filetypes._ = '_'
" }}}
" Jedi-vim {{{

" Disable autocompletion (using deoplete instead)
let g:jedi#completions_enabled = 0

" All these mappings work only for python code:
" Go to definition
let g:jedi#goto_command = ',d'
" Find ocurrences
let g:jedi#usages_command = ',o'
" Find assignments
let g:jedi#goto_assignments_command = ',a'
" Go to definition in new tab
nmap ,D :tab split<CR>:call jedi#goto()<CR>
" }}}
" Window Chooser {{{

" mapping
nmap  -  <Plug>(choosewin)
" show big letters
let g:choosewin_overlay_enable = 1
" }}}
" Signify {{{

" this first setting decides in which order try to guess your current vcs
" UPDATE it to reflect your preferences, it will speed up opening files
let g:signify_vcs_list = [ 'git' ]
" mappings to jump to changed blocks
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)
" nicer colors
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227
" }}}
" Autoclose {{{

" Fix to let ESC work as espected with Autoclose plugin
" (without this, when showing an autocompletion window, ESC won't leave insert
"  mode)
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}
" }}}
" Yankring {{{

" Fix for yankring and neovim problem when system has non-text things copied
" in clipboard
let g:yankring_clipboard_monitor = 0
let g:yankring_history_dir = '~/.config/nvim/'
" }}}
" Airline {{{

let g:airline_powerline_fonts = 1
let g:airline_theme = 'bubblegum'
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#enabled = 1
" to use fancy symbols for airline, uncomment the following lines and use a
" patched font (more info on docs/fancy_symbols.rst)
if !exists('g:airline_symbols')
   let g:airline_symbols = {}
endif
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols.branch = '⭠'
let g:airline_symbols.readonly = '⭤'
let g:airline_symbols.linenr = '⭡'
" }}}
" Isort {{{
nnoremap <leader>s :Isort<CR>
" }}}
" Split Term {{{
" Split terms to the right and below current buffer
set splitright
set splitbelow
" Set default shell to ZSH
let g:split_term_default_shell = "zsh"

" Shortcuts to open terminals
nnoremap <C-v> :VTerm<CR>
nnoremap <C-t> :10Term<CR>
nnoremap <C-y> :VTerm python<CR>
" }}}
" Vim-Markdown {{{
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
let g:tex_conceal = ""
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1  " for YAML format
let g:vim_markdown_toml_frontmatter = 1  " for TOML format
let g:vim_markdown_json_frontmatter = 1  " for JSON format
" }}}
" Markdown Preview {{{
nnoremap <M-m> :MarkdownPreview<CR>
let g:mkdp_auto_close = 0
" }}}
" vim-go {{{
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1
" }}}
" vimwiki {{{
let g:vimwiki_list = [
    \{'path': '~/Notes', 'syntax': 'markdown', 'ext': '.md'},
    \{'path': '~/Notes/Programming', 'syntax': 'markdown', 'ext': '.md'},
    \{'path': '~/Notes/Programming/Golang', 'syntax': 'markdown', 'ext': '.md'},
    \{'path': '~/Notes/Programming/Python', 'syntax': 'markdown', 'ext': '.md'},
    \{'path': '~/Notes/Programming/Rust', 'syntax': 'markdown', 'ext': '.md'},
    \{'path': '~/Notes/Britecore', 'syntax': 'markdown', 'ext': '.md'},
    \{'path': '~/Notes/Arch', 'syntax': 'markdown', 'ext': '.md'},
    \{'path': '~/Notes/AWS', 'syntax': 'markdown', 'ext': '.md'},
    \{'path': '~/Notes/Bible Study', 'syntax': 'markdown', 'ext': '.md'},
    \{'path': '~/Notes/Preparedness', 'syntax': 'markdown', 'ext': '.md'}]
" }}}
" }}}

" vim:foldmethod=marker:foldlevel=0
