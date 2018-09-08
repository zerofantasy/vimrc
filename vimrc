"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vundle Section
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'L9'
Plugin 'Valloric/YouCompleteMe'
Plugin 'ervandew/supertab'
Plugin 'git@github.com:scrooloose/nerdtree.git'
Plugin 'git@github.com:majutsushi/tagbar.git'
Bundle 'tpope/vim-surround'
Plugin 'mileszs/ack.vim'
Plugin 'tpope/vim-repeat'
Plugin 'Raimondi/delimitMate'
Plugin 'altercation/vim-colors-solarized'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'iamcco/markdown-preview.vim'
Plugin 'nsf/gocode', {'rtp': 'vim/'}
Plugin 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"Plugin 'git@github.com:basilgor/vim-autotags.git'
Plugin 'FelikZ/ctrlp-py-matcher'
Plugin 'chr4/nginx.vim'

call vundle#end()
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Setting Section
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","
map <silent> <leader><cr> :noh<cr>

"let g:solarized_termcolors=256

syntax enable
set background=dark
colorscheme solarized

command W w
command WQ wq
command Wa wa
command Wq wq
command Q q
command QA qa
command Qa qa
command Wqa wqa
command WA wa
cnoremap w!! w !sudo tee % >/dev/null

set nu
set ai
set si
set wrap
set history=500
set autoread
set so=8
set mat=2
let $LANG='en'
set langmenu=en
set wildmenu
set wildignore=*.o,*~,*.pyc
set ruler
set hid
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set ignorecase
set smartcase
set hlsearch
set incsearch
set lazyredraw
set magic
set showmatch
set noerrorbells
set novisualbell
set t_vb=
set foldcolumn=1
set encoding=utf8
set ffs=unix,dos,mac
set nobackup
set nowb
set noswapfile
set expandtab
set shiftwidth=4
set tabstop=4
set lbr
set tw=500
set tm=500
set laststatus=2
set t_Co=256
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
set nolist
set completeopt-=preview
set foldmethod=manual
set updatetime=100
set rtp+=/usr/local/opt/fzf
set rtp+=~/.vim/bundle/gocode/vim
set foldmethod=manual

au BufRead,BufNewFile Makefile* set noexpandtab

vnoremap <C-c> "*y"
set tags=tags;/

vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

map j gj
map k gk

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

nnoremap <Up>    <C-W>k
nnoremap <Down>  <C-W>j
nnoremap <Left>  <C-W>h
nnoremap <Right> <C-W>l

nmap  w=  :resize +3<CR>
nmap  w-  :resize -3<CR>
nmap  w.  :vertical resize -3<CR>
nmap  w,  :vertical resize +3<CR>

inoremap ˙ <C-o>h
inoremap ∆ <C-o>j
inoremap ˚ <C-o>k
inoremap ¬ <C-o>l

" tagbar
map tt :TagbarToggle<CR>
let g:tagbar_left = 1
let g:tagbar_width = 30

autocmd BufNewFile,BufRead *.conf set syntax=nginx

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
	exe "menu Foo.Bar :" . a:str
	emenu Foo.Bar
	unmenu Foo
endfunction

function! VisualSelection(direction, extra_filter) range
	let l:saved_reg = @"
	execute "normal! vgvy"

	let l:pattern = escape(@", '\\/.*$^~[]')
	let l:pattern = substitute(l:pattern, "\n$", "", "")

	if a:direction == 'b'
		execute "normal ?" . l:pattern . "^M"
	elseif a:direction == 'gv'
		call CmdLine("Ag \"" . l:pattern . "\" " )
	elseif a:direction == 'replace'
		call CmdLine("%s" . '/'. l:pattern . '/')
	elseif a:direction == 'f'
		execute "normal /" . l:pattern . "^M"
	endif

	let @/ = l:pattern
	let @" = l:saved_reg
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" remember last edit position
if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

func! DeleteTrailingWS()
	exe "normal mz"
	%s/\s\+$//ge
	exe "normal `z"
endfunc

autocmd BufWrite * :call DeleteTrailingWS()

function! CurDir()
	let curdir = substitute(getcwd(), $HOME, "~", "g")
	return curdir
endfunction
set statusline=%f%m%r%h\ \ \ \ %{tagbar#currenttag('[%s]\ ','')}\ \|%=\|\ %l,%c\ %p%%

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Section
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDtree
let NERDTreeIgnore = ['\.pyc$']
autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeWinPos = "left"
map <leader>nn :NERDTreeToggle<CR>

" YouCompleteMe
let g:ycm_auto_trigger = 99
let g:ycm_register_as_syntastic_checker = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 0
let g:ycm_python_binary_path = 'python'
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_always_populate_location_list = 0
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_key_list_select_completion = []
let g:ycm_key_list_previous_completion = []
let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
let g:ycm_filetype_whitelist = {'python':1, 'c':1, 'cpp':1, 'go':1}
nnoremap ff :YcmCompleter GoTo<CR>

" Supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" fugitive
set diffopt=vertical,filler
autocmd BufRead,BufNewFile *.zt set filetype=ztest
autocmd BufRead,BufNewFile *.t set filetype=ztest

" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_switch_buffer = 'et'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_extensions = ['tag']
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
let g:airline#extensions#tabline#enabled = 1
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

" Ack
" let g:ackprg = 'ag --nogroup --nocolor --column'
let g:ackprg = 'ag --vimgrep'
map <c-y> :Ack <C-R><C-W><CR>

nnoremap <leader>p :set invpaste paste?<CR>
set pastetoggle=<leader>p
set showmode

augroup filetype_lua
    autocmd!
    autocmd FileType lua setlocal iskeyword+=:
augroup END

if !has("mac")
    if has("cscope")
      set csprg=/usr/bin/cscope
      set csto=1
      "set cst
      set nocsverb
      " add any database in current directory
      if filereadable("cscope.out")
          cs add cscope.out
      endif
      set csverb
    endif
endif

imap <C-\> <Plug>delimitMateS-Tab

"s: Find this C symbol
"g: Find this definition
"c: Find functions calling this function
"a: Find places where this symbol is assigned a value
"d: Find functions called by this function
map <leader>ss :cs find s <C-R>=expand("<cword>")<CR><CR>
map <leader>gg :cs find g <C-R>=expand("<cword>")<CR><CR>
map <leader>cc :cs find c <C-R>=expand("<cword>")<CR><CR>
map <leader>aa :cs find a <C-R>=expand("<cword>")<CR><CR>
map <leader>dd :scs find d <C-R>=expand("<cword>")<CR><CR>
