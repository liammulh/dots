" Configure Vim.
" 
" This config follows these principles:
" 1. Nothing is configured unless understood.
" 2. Everything is documented.
" 3. Choose plugins judiciously.

"======================================================================
" Establish variables used throughout config
"======================================================================

" Create a short alias for the verbose keymap function invocation.
" The help for nvim_set_keymap describes the parameters it accepts.
let keymap = 'noremap'

" Create a table with options we will use with most of our keymaps.
" noremap means the mapping works in normal, visual, select, and
" operator-pending mode.
let opts = 'noremap'

"======================================================================
" Set the leader key
"======================================================================

" We are going to make the space bar our leader key. We want to ensure
" the space bar doesn't do anything before we make it our leader key.
nnoremap <Space> <Nop>

" The leader key effectively gives you a namespace for custom keymaps.
" Our leader key is the space bar.
let mapleader = " "
let maplocalleader = " "

"======================================================================
" Keymaps
"======================================================================

" Toggle showing all whitespace characters.
nnoremap <Leader>tc :set list!<CR>

" Toggle search highlighting. The next time you search, highlighting
" should still work.
nnoremap <Leader>th :nohlsearch<CR>

" Toggle spell check.
nnoremap <Leader>ts :set spell!<CR>

"======================================================================
" Buffers
"======================================================================

" Delete a buffer:
" - Use the bdelete (bd) command.
" - Find the number of the buffer you want to delete by listing all
"   buffers.
" - Prepend the bdelete command with the number of the buffer you want to
"   delete.

" Open a new buffer.
nnoremap <Leader>b :enew<CR>

" Show all buffers.
nnoremap <Leader>sb :buffers<CR>

" Switch to the previous buffer using shift-h.
nnoremap <S-h> :bprevious<CR>

" Switch to the next buffer using shift-l.
nnoremap <S-l> :bnext<CR>

"======================================================================
" Tabs
"======================================================================

" Open a new tab.
nnoremap <Leader><Tab> :tabnew<CR>

" Switch to the left tab.
nnoremap <S-Tab> :tabprevious<CR>

" Switch to the right tab.
nnoremap <Tab> :tabnext<CR>

"======================================================================
" Windows
"======================================================================

" Navigate windows using the control key and the h, j, k, and l keys.
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Resize the window using the control key and the arrow keys.
" This seems to be relative to the first window you resize.
nnoremap <C-Up> :resize +2<CR>
nnoremap <C-Down> :resize -2<CR>
nnoremap <C-Left> :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>

" Always open horizontal splits below.
set splitbelow

" Always open vertical splits to the right.
set splitright

"======================================================================
" Indentation
"======================================================================

" When in insert mode, use the appropriate number of spaces to insert a
" <Tab>. Spaces are used in indents with the > and < commands and
" when autoindent is on.
set expandtab

" Repeat the less-than or greater-than character to indent a line when
" in visual mode.
xnoremap < <gv
xnoremap > >gv

" Set number of spaces to use for each step of (auto)indent. For
" example, when indenting with >, insert N spaces. There are other
" (auto)indent scenarios where N spaces will be inserted.
set shiftwidth=4

" Copy indent from current line when starting a new line.
set autoindent

"======================================================================
" Colors
"======================================================================

" If you don't have a color scheme installed from a package, use the
" built-in 'slate' colorscheme.
colorscheme slate

" Enable 24-bit RGB color in the TUI. Basically, the colors look nicer
" if your terminal supports this.
set termguicolors

" Make the background dark by default.
set background=dark

"======================================================================
" One-off options
"======================================================================

" A few tips and tricks before we start setting options.
" 
" To see what the foobar option is set to:
" 
" ```
" foobar?
" ```
" 
" If the foobar option is a boolean option (as many Vim/Neovim options
" are) a value of foobar means the option is on. A value of nofoobar means
" the option is off. If the option has a numeric or other value, that
" value will be shown.
" 
" To not (as in logical not) the foobar option:
" 
" ```
" foobar!
" ```
"
" To revert the foobar option to its default value:
"
" ```
" foobar&
" ```

" Don't use the mouse.
set mouse=

" Set maximum width of text that is being inserted.
set textwidth=72

" Don't wrap lines when the window size is narrower than the width of
" the text.
set nowrap

" When showing all whitespace characters, show them as the following
" characters.
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,space:.

" Disable swap files. Vim doesn't crash often enough to warrant them.
" Vim stores the things you changed in a swap file. Using the original
" file you started from plus the swap file you can mostly recover your
" work.
set noswapfile

" Yank and put/paste from the system clipboard.
set clipboard=unnamedplus

" Don't make the annoying 'bonk' noise.
set noerrorbells

" Instead, show me something is bonk.
set visualbell
