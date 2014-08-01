" Ryan Kulla's vim/gvim vimrc file
" On Unix name this file:  ~/.vimrc
" On windows name it:  C:\Documents and Settings\ryan\_vimrc
" The author of this script is not responsible if you use it and lose data.
" Search for the phrase 'EDIT ME' in this file to know what to edit.
"
" Plugins:
"   Install all my plugins via my vimogen project:
"       https://github.com/rkulla/vimogen
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Put first to insure pathogen will work
execute pathogen#infect() 
set nocompatible " Prevent unexpected things your distro might make
if has("unix")
    set ttymouse=xterm2 " Make mouse work right in putty/gnu screen
endif
set mouse=a " Make your mouse work properly in terminals like putty and in all modes
set ffs=unix,dos,mac " Auto-detect the filetype based off newlines used. (don't set ff, explicitly :set ff=unix to convert dos/mac).
set history=50 " Keep 50 lines of command line history
set ruler " Show the cursor position all the time
set showcmd " Display incomplete commands
set incsearch " Do incremental searching
set backspace=indent,eol,start " Allow backspacing over everything in insert mode
set path+=./**  " Allow :find, :tabf, etc to search the current directory and its subdirs
set hidden " Allow you to change buffers without having to save modified ones first
set ignorecase " Allow case-insensitive /searching
set spelllang=en_us
set nobackup " I'm hardcore. I don't like it triggering my file system watchers
set nowritebackup " I'll take my chances.
set nostartofline " So cursor doesn't jump to beginning of line when you G, GG, ^F, etc
"set relativenumber " show relative linenumbers to take guess work out of jumping around
let g:UltiSnipsJumpForwardTrigger = "<Tab>" " use tab to get to next placeholders
set confirm " When you :q, :bd, etc a file that's been changed, popup a 'save file?' confirm box instead of showing errors
set fo=t " I don't want the format options that auto create comments 
set showcmd " Show partial commands in the last line of the screen, eg if you type 'f' it will show 'f' until you finish the command.
set enc=utf-8 " Settings this to utf-8 causes fencs to default to ucs-bom,utf-8,default,latin1
autocmd GuiEnter * set cul " Highlight entire line wherever cursor is. Slow over SSH so enable it in gvim by default only
set pastetoggle=<F3> " Use <F3> to toggle between 'paste' and 'nopaste'. Use if vim isn't connected to an X Server such as if using gvim32 or if you forgot to ssh -Y or -X.
if $TMUX == '' " http://stackoverflow.com/questions/11404800/fix-vim-tmux-yank-paste-on-unnamed-register
  set clipboard+=unnamed
endif
command! -nargs=1 -complete=dir Rename saveas <args> | call delete(expand("#")) " Rename the current file by typing :Rename <new_filename>
"
let mapleader = "," " remap <Leader> to comma so you can do: ,s instead of \s, etc.
" Undo a line at a time no matter what
"inoremap <CR> <C-g>u<CR>
" Make it so you can select some text and sort it in place
vnoremap <Leader>s :sort<CR> 
" Map ^l to to clear all highlighted text on the screen (like from /searches)
nnoremap <C-l> :nohl<CR><C-l>
" Make it so you can just type jj to go into normal mode so you don't hae to hit of Escape
imap jj <esc>
" map so you can quickly open files in the pwd, or its subdirs, automatically by typing substrings of filenames
map <Leader>e :e **/*
" Don't use Ex mode, use Q for formatting
map Q gq
" Make it so ctrl+up arrow scrolls upward through text from the current cursor position without moving the cursor upward too
nmap <C-up> 1<C-u>
" Highlight words under cursor but keep the cursor where it is
noremap * *``
" Make it so ctrl+down arrow scrolls downward through text from the current cursor position without moving the cursor downward too
nmap <C-down> 1<C-d>
" Make it so you can hit F10 to automatically scrollbind all the windows so the windows scroll in sync with eachother
map <F10> :windo set scrollbind!<CR>
" Make it so you can type Ctrl-\ on strings to jump to their gtags corresponding tag
map <C-\> :GtagsCursor<CR>
" Make it so you can toggle the showing of line numbers
map <Leader>n :set invnumber<CR>
" When editing multiple files use the Ctrl+n and Ctrl+p keys, while in command mode, to go forward or backward through the buffers.
" Since C-6 only toggles between two open file buffers.
nmap <C-n> :bn<CR> 
nmap <C-p> :bp<CR> 
" Make it so you can just type ';;' in insert mode to delete the last word
imap ;; <C-w>
" Make it so you can just type ';h' in insert mode to jump to start of line
imap ;h <Esc>I
" Force the file to be saved when ctrl+s is hit in command or insert mode put "stty -ixon" in your bashrc for this to work in unix
" terminals since ctrl+s usually sends a command to unix to suspend whatevers scrolling on the screen and requires a ctrl+q to resume
imap <C-s> <C-o>:update!<CR>
nmap <C-s> :update!<CR>
" Make it so you can underline any line of text you are on with dashes
nmap <Leader>u :call append(line("."), repeat("-", len(getline("."))))<CR>
" Evernote style date and time insertion. Inserts the date in the format: 10/01/2009 12:08 AM
nmap <Leader>et i<C-R>=strftime('%m/%d/%Y %I:%M %p')<Esc>
" Moves all text behind cursor one space forward (w/o moving text in front)
nmap <Leader><Space> d0p
" In insert mode, typing 2 commas will insert 30 spaces. 3 commas will insert 50.
imap ,, <Space><Esc>30i<Space><Esc>i
imap ,,, <Space><Esc>50i<Space><Esc>i
" Automatically select the last text that was pasted
nmap <Leader>sp `[v`]
" Make it so Ctrl+a does nothing since it normally increments numbers and
" you might accidently type it when you're not in gnu-screen:
map <c-a> <Nop>
" Make it so if you click somewhere else on a page, you can type `` to get back to the last cursor position.
" Useful for when the cursor position changes when you click a vim window to focus the window.
noremap <LeftMouse> m'<LeftMouse>
" Make it so you can delete the contents of the first occurence of () on a line and insert there
nnoremap <Leader>( 0%ci(


""" Abbreviations
iab teh the


""" Indentation
set ts=4 " Make tabs 4 spaces
set expandtab " Expand tabs into the corresponding number of spaces. Use Ctrl+V<TAB> for real tabs
set smarttab " Use sw instead of ts when you hit tab at start of a line and also make backspace delete sw worth of space
set sw=4 " when something is auto-indented it will appear as 4 <spaces>
set shiftround " Make it so > and < snap to value of sw
set autoindent " Make indents always from the start of the line above. :set cindent if you want to indent the annoying way
"
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!
  " For all text files set 'textwidth' to 139 characters.
  autocmd FileType text setlocal textwidth=139
  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
  augroup END
endif 


""" Statusbar
set statusline=%{StatuslineMultiFileFlag()}\ %-3.3n\ %f\ %h%m%r%w[%{strlen(&ft)?&ft:'none'},%{strlen(&fenc)?&fenc:&enc},%{&fileformat}]\%{VCSCommandGetStatusLine()}\ %=%b,0x%-8B\ %-14.(%l,%c%V%)\ %<%P
set laststatus=2
" Function to add to 'set statusline', via %{StatuslineMultiFileFlag()} above, 
" to see how many buffers are currently open without having to type ':ls'
autocmd bufadd,bufdelete * unlet! g:statusline_multi_file_flag
function! StatuslineMultiFileFlag()
    if !exists('g:statusline_multi_file_flag')
        let num_files = 0
        for i in range(1, bufnr("$"))
            if buflisted(i) && getbufvar(i, '&buftype') == ''
                let num_files += 1
            endif
        endfor

        " only show 'Open Files' message if there's more than one open file
        if num_files > 1
            let g:statusline_multi_file_flag = '[Open Files: ' . num_files . ']'
        else
            let g:statusline_multi_file_flag = ''
        endif

    endif
    return g:statusline_multi_file_flag
endfunction


""" VCSCommand
" Make it so %{VCSCommandGetStatusLine()} can be added to statusline
let g:VCSCommandEnableBufferSetup = 1


""" Color Schemes
" EDIT ME (Create ~/.vim/colors/ and add ir_black, molokai, zenburn and grb256)
" EDIT ME - To see syntax colors properly:
"               In ~/.screenrc put: term xterm-256color
if has("gui_running")
    " Have different file types use different color schemes
    " make it so config files, etc use a certain color scheme
    "au BufNewFile,BufRead,BufEnter * color grb256
    " make it so txt file uses a certain color scheme
    au BufNewFile,BufRead,BufEnter *.txt color zenburn
else
    " ir_black is the only color scheme I use that works right in the console
    "au BufNewFile,BufRead,BufEnter * color ir_black
    au BufNewFile,BufRead,BufEnter * color molokai
endif
"
" Have zenburn colorscheme work better in bright environments
":let g:zenburn_high_Contrast=1
" To have gnome-terminal look more like zenburn use: fg=DCDCDC, bg=#3F3F3F


""" Syntax highlighting
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    "EDIT ME (create ~/.vim/syntax/ and fill it with php.vim, etc)
    syntax on
    set hlsearch
endif

""" Ctrlp
" Remap invoker to Leader-x
let g:ctrlp_map = '<Leader>x'

""" Ruby
au BufNew,BufRead,BufEnter *.rb set textwidth=79 fo=t sw=2 ts=2
autocmd FileType ruby map <Leader>l :w<CR>:!ruby -c %<CR>

""" Python
au BufNew,BufRead,BufEnter *.py set textwidth=79 fo=t sw=4 ts=4
" 
" python-mode plugin settings
map <Leader>g :call RopeGotoDefinition()<CR>
let ropevim_enable_shortcuts = 1
let g:pymode_rope_goto_def_newwin = "vnew"
let g:pymode_rope_extended_complete = 1
let g:pymode_breakpoint = 0
let g:pymode_syntax = 1
let g:pymode_syntax_builtin_objs = 0
let g:pymode_syntax_builtin_funcs = 0
map <Leader>b 0import ipdb; ipdb.set_trace() # BREAKPOINT<C-c>
"
" Map Ctrl+F5 to PEP8 validation
let g:pep8_map='<C-F5>'
"
" Pydiction
filetype plugin on
"let g:pydiction_menu_height = 10
" EDIT ME
if has("win32")
    let g:pydiction_location = 'C:/vim/vimfiles/ftplugin/pydiction/complete-dict'
else
    if system('uname')=~'Darwin'
        let g:pydiction_location = '/Users/rkulla/.vim/bundle/pydiction/complete-dict'
    else
        let g:pydiction_location = '/home/rkulla/.vim/bundle/pydiction/complete-dict'
    endif
endif
"
" Find the definition of the word under the cursor in same file types (really
" only works for Python at the moment.) Requires you don't set grepprg to Ack
" or 3rd party. Customized for about.me's codebase.
map <Leader>py :execute "silent grep! -srnwIE --exclude-dir=.git " .
        \ "--exclude-dir=test --exclude-dir=tpm --include=*" . expand("%:e") .
        \ " -e 'def " . expand("<cword>") . "' -e 'class " . expand("<cword>") .
        \ "' ." <Bar> cwindow<CR>

" Highlight lines over 80 characters
function! LongLines()
    if exists('+colorcolumn')
        setlocal colorcolumn=80
    else
        " au BufWinEnter * let w:m2=matchadd('LongLine', '\%>80v.\+', -1)
        au BufEnter,BufWinEnter,StdinReadPost *.py,*.sh match LongLine /\%>80v.\+/
    endif
endfunction
" Only highlight long lines in Python, for now
au BufEnter,BufWinEnter *.py call LongLines()

""" CoffeeScript
" Make it so you can recompile CoffeeScript Koans easily
nmap <Leader>c :!cake build<CR>

""" Node.js
" Make it so Jade templates use only 2 spaces for indentations
autocmd BufRead,BufNewFile *.jade setlocal ft=jade sw=2 ts=2

""" PHP
" Zend Coding Standard
au BufNew,BufRead,BufEnter *.php set textwidth=80 fo=t sw=4 ts=4
" or put 'set fo+=t' in .vim/after/indent/php.vim for tw to break the line
"
" phpcomplete completion:
autocmd FileType php set omnifunc=phpcomplete 
"
" Make it so php files are also seen as html
au BufRead,BufNewFile *.php set filetype=php.html
"
" PHPUnit
" Make it so typing ":Test" will run phpunit on the current file, with good options
com! Test :!phpunit --verbose --colors %
nmap <Leader>tv :!phpunit --verbose --colors %<CR>
nmap <Leader>td :!phpunit --testdox %<CR>
"
" Make it so you can find all variables/objects that start with $ on the page
nmap <Leader>fv /$[a-zA-Z_][^ \t\]()?;]*<CR>
"
" Make it so you can automatically var_dump() a variable
nmap <Leader>vv 0i<Space><Esc>0f$yeuovar_dump(<C-r>");<Esc>
" Make it so you can just type 'vd' in insert mode to type var_dump()
imap vd var_dump();<Esc>hi
" Make it so you can auto wrap a var_dump around a function that's on its own line do (requires surround.vim)
nmap <Leader>vf yssfvar_dump<Esc>f;xa;<Esc>
" My snipmate snippets files have more stuff
" Make it so you can run the current script through the php linter to check for syntax errors
autocmd FileType php map <Leader>l :w<CR>:!php -l %<CR>
" Make it so in visual mode  you can do a multiline /* */. (Use the gcc plugin for everything else)
vnoremap <Leader>c <Esc>'<lt>O/*<ESC>'>o*/<ESC>
" Make it so in visual mode you can do a multiline html comment <!-- -->
vnoremap <Leader>! <Esc>'<lt>O<!--<ESC>'>o--><ESC>
"
" Make it so in visual mode you can do a multiline php-html comment <?php /* */ ?>
"useful when you don't want your html comment content viewable in browser
vnoremap <Leader>!! <Esc>'<lt>O<?php /*<ESC>'>o*/?><ESC>
"
" Make it so you can put inline php tags around the current line
nmap <Leader>? I<?php <Esc>A ?>


""" .swp file handling. Don't forget to create the directories
if has("win32")
    " EDIT ME
    set dir=C:\\vim\\vimfiles\\swp
else
    " EDIT ME
    set dir=~/.vim/swp
endif


""" Grep
" Use ack-grep for :grep in vim, eg ':grep -i --php foo' 
" set grepprg=ack-grep


""" :Sex 
" Make :Sex window take up most of the screen so you can see more files at once
let g:netrw_winsize=35
" Sort case-insensitively (so Program Files appears next to pf, etc)
let g:netrw_sort_options="i"


""" Taglist
""EDIT ME
if has("unix")
    if system('uname')=~'Darwin'
      " make sure to 'brew install ctags' first because the /usr/bin/ctags
      " that ships with OSX is not the right one
      let Tlist_Ctags_Cmd = '/usr/local/Cellar/ctags/5.8/bin/ctags'
    else 
      let Tlist_Ctags_Cmd = 'ctags'
    endif
else
    let Tlist_Ctags_Cmd = '~/pf/opt/ctags/ctags.exe'
endif
"
" make it so you can toggle taglist on/off with ctrl+shift+t
nnoremap <C-S-T> :TlistToggle<CR>


""" CScope
" automatically connect to cscope databases. -C = Search case-insensitively
"cscope add cscope.out . -C
" have CTRL-] and :tag search through cscope first, then tags
"set cscopetag


""" Fonts
if has("win32")
    au VimEnter * simalt ~x
    set lines=80 columns=145
    "set guifont=Terminal:h6:cOEM "change font
    "set guifont=Lucida_console:h10 "change font (the :h10 part is the size)
    "set guifont=Consolas:h12
    set gfn=Droid\ Sans\ Mono:h11
    winpos 0 0
endif
"
if has('unix') && has('gui')
    " Set the font in Linux/Gvim to Droid Sans Mono. I use desktop=14, laptop=11, netbook=9
    " columns should be no longer than 139 chars. To quickly change just your fontsize in vim,
    " type: "gfn=<tab>" which will fill in the current font so you can just change the size
    if system('uname')=~'Darwin'
      set gfn=Monaco:h16
    elseif has('x11')
      set gfn=Droid\ Sans\ Mono\ 11
    endif
endif


""" GUI
" turn certain gui options on/off.  += turns on -= turns off
set go-=m "no menubar (File, Edit, Tools, Syntax, Buffers, Window, Help)
set go-=T "no toolbar
set go-=t "no tearoff menus
set go-=r "no right hand scrollbar always present
set go-=l "no left hand scrollbar always present
set go-=R "no right hand scrollbar when windows are split vertically
set go-=L "no left hand scrollbar when windows are split vertically
set go-=b "no bottom (horizontal) scrollbar present


""" Menus
" allow a console based menu system by hitting F4:
source $VIMRUNTIME/menu.vim
set wildmenu " makes command-line completion operate in an enhanced mode
set cpo-=<
set wcm=<C-Z>
map <F4> :emenu <C-Z>


""" NERDTree
nmap <C-e> :NERDTree<CR>
let NERDTreeIgnore = ['\.pyc$']


""" HTML
" Close HTML Tags using <F4> in insert mode
nnoremap \hc :call InsertCloseTag()<CR>
imap <F4> <Space><BS><Esc>\hca
function! InsertCloseTag()
" inserts the appropriate closing HTML tag; used for the \hc operation defined
" above;
" requires ignorecase to be set, or to type HTML tags in exactly the same case
" that I do;
" clobbers register z and mark z
"
" by Smylers  http://www.stripey.com/vim/
" 2000 May 3
"  if &filetype == 'html' || 'mason'
 " list of tags which shouldn't be closed:
 let UnaryTags = ' AREA BASE BR DD DT HR IMG LINK META PARAM '
 " remember current position:
 normal mz
 " loop backwards looking for tags:
 let Found = 0
 while Found == 0
   " find the previous <, then go forwards one character and grab the first
   " character plus the entire word:
   execute "normal ?\<LT>\<CR>l"
   normal "zyl
   let Tag = expand('<cword>')
   " if this is a closing tag, skip back to its matching opening tag:
   if @z == '/'
     execute "normal ?\<LT>" . Tag . "\<CR>"
   " if this is a unary tag, then position the cursor for the next
   " iteration:
   elseif match(UnaryTags, ' ' . Tag . ' ') > 0
     normal h
   " otherwise this is the tag that needs closing:
   else
     let Found = 1
   endif
 endwhile " not yet found match
 " create the closing tag and insert it:
 let @z = '</' . Tag . '>'
 normal `z"zp
"  else " filetype is not HTML
"    echohl ErrorMsg
"    echo 'The InsertCloseTag() function is only intended to be used in HTML files.'
"    sleep
"    echohl None
"  endif " check on filetype
endfunction " InsertCloseTag()


""" Split windows
if has("win32")
    " Make it so you can minimize/maximize any horizontal/vertical split viewport by pressing Ctrl+Shift+Arrow
    " (300 just signifies a large enough number to ensure they close since it goes by a line at a time)
    nmap <C-S-Up> 300<C-w>-
    nmap <C-S-Down> 300<C-w>+
    nmap <C-S-Left> 300<C-w><
    nmap <C-S-Right> 300<C-w>>
endif
"
" Let's you close the current file by typing :Clear w/o closing the split window and starts a new file
com! Clear :enew <bar> bdel # 
" Let's you close the current file by typing F2 w/o closing the split window then jumps to the next file
nmap <F2> :bn <bar> bd #<CR>


""" Folds 
set foldenable
set foldmethod=marker
" This fold expression auto folds any lines starting with a '*' until the next line that starts with a '*' is found
function! FoldExpr(lnum)
    let line = getline(a:lnum)
    "if line =~ '^\s*\*'
    if line =~ '^\*'
        return '>1'
    "elseif line =~ '^+'
    "   return '>2'
    "elseif line =~ '^-'
    "   return '>3'
    endif
    return '='
endfunction
"
if has("autocmd")
    augroup TextFileFolds
    au!
    " use fold expressions on our FoldExpr function
    autocmd BufRead,BufNewFile *.txt setlocal foldmethod=expr foldexpr=FoldExpr(v:lnum)
    augroup END
endif
"
" Make it so you can toggle # comments as folds (useful for config files and ruby/python/bash especially)
function HideComments()
  set fdm=expr
  set fde=getline(v:lnum)=~'^\\s*#'?1:getline(prevnonblank(v:lnum))=~'^\\s*#'?1:getline(nextnonblank(v:lnum))=~'^\\s*#'?1:0
endfunction
map <Leader>h :call HideComments()<CR>
"
" Make it so searches don't open folds automatically
set foldopen-=search

" Make it so you can just type :Beg foo  to search for the string foo occuring
" within the first 20 characters of a row:
function! BegSearch(strtofind)
  call search(a:strtofind.'\%<20c')
endfunction
command! -nargs=1 Beg call BegSearch(<f-args>)

""" DBext 
" Kata profiles
let g:dbext_default_profile_kata_PG = 'type=PGSQL:user=dev_db_user:dbname=kata'
let g:dbext_default_profile_kata_MYSQL = 'type=MYSQL:user=dev_db_user:passwd=p4ssw0rd:dbname=kata'


""" Automatically leave insert mode after 'updatetime' milliseconds of inaction
au CursorHoldI * stopinsert
au InsertEnter * let updaterestore=&updatetime | set updatetime=15000
au InsertLeave * let &updatetime=updaterestore


""" Misc MS-windows stuff
if has("win32")
    " Make it so it will automatically paste and indent the code you paste
    nnoremap <Leader>i "+p=']
"
    " Make it so you can yank current line up to the newline into Windows' clipboard
    nmap <Leader>y 0"+y$
    nmap <Leader>x :silent ! start <cfile><CR>
"
    " Make it so you can identify color group names of item under cursor by pressing alt+i
    nmap <silent> <M-i> :echo 'hi<' . 
          \ synIDattr(synID(line('.'), col('.'), 1), 'name') . 
          \ '> trans<' . synIDattr(synID(line('.'), col('.'), 0), 'name') . 
          \ '> lo<' . synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name') . 
          \ '>'<CR> 
"
    "map <F11> :set lines=50 columns=142<CR>
    " Simalt ~ involkes Windows Alt-space menu. :simalt ~x = Alt+space x
    map <F12> :simalt ~x<CR> 
"
    " Make it so you can select text and then search for a string in it by
    " pressing Alt then / (or ?) then your search term, so you can search with /
    " and ? in visual selection areas:
    vnoremap <M-/> <Esc>/\%V
endif
