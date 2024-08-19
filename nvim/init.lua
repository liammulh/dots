--[[

Configure Neovim.

This config follows these principles:
1. Nothing is configured unless understood.
2. Everything is documented.
3. Choose plugins judiciously.

Things to remember:
- This is an editor, not an IDE.
- It's okay to want things to look nice.

--]]

--=====================================================================
-- Establish variables used throughout config
--=====================================================================

-- Create a short alias for the verbose keymap function invocation.
-- The help for nvim_set_keymap describes the parameters it accepts.
local keymap = vim.api.nvim_set_keymap

-- Create a table with options we will use with most of our keymaps.
-- noremap means the mapping works in normal, visual, select, and
-- operator-pending mode.
local opts = { noremap = true }

--=====================================================================
-- Set the leader key
--=====================================================================

-- We are going to make the space bar our leader key. We want to ensure
-- the space bar doesn't do anything before we make it our leader key.
keymap("", "<Space>", "<Nop>", opts)

-- The leader key effectively gives you a namespace for custom keymaps.
-- Our leader key is the space bar.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--=====================================================================
-- Package manager
--=====================================================================

-- Set the package manager path inside the user data directory.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- If the package manager path doesn't exist, clone the package manager.
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- Get the latest stable release.
        lazypath,
    })
end

-- Prepend the package manager path to Neovim's list of directories to
-- be searched for runtime files.
vim.opt.rtp:prepend(lazypath)

--=====================================================================
-- Gruvbox color scheme package
--=====================================================================

local pkg_gruvbox = {
    "ellisonleao/gruvbox.nvim",
    config = function()
        local gruvbox = require("gruvbox")
        gruvbox.setup({
            italic = {
                strings = false,
                emphasis = false,
                comments = false,
                operators = false,
                folds = false,
            },
        })
    end,
}

--=====================================================================
-- Gitsigns package
--=====================================================================

local pkg_gitsigns = {
    "lewis6991/gitsigns.nvim",
    config = function()
        local gitsigns = require("gitsigns")
        gitsigns.setup({
            signs = {
                add = { text = "│" },
                change = { text = "│" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
                untracked = { text = "┆" },
            },
            signcolumn = true,
            numhl = false,
            linehl = false,
        })
    end,
}

--=====================================================================
-- Oil.nvim package
--=====================================================================

local pkg_oil_nvim = {
    "stevearc/oil.nvim",
    opts = {
        view_options = {
            show_hidden = true,
        },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
}

--=====================================================================
-- Lualine package
--=====================================================================

local pkg_lualine = {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = { theme = "gruvbox" },
}

--=====================================================================
-- Install packages
--=====================================================================

local lazy_pkgs = {
    pkg_gruvbox,
    pkg_gitsigns,
    pkg_oil_nvim,
    pkg_lualine,
}

require("lazy").setup(lazy_pkgs)

--=====================================================================
-- Keymaps
--=====================================================================

-- Toggle showing all whitespace characters.
keymap("n", "<Leader>tc", ":set list!<CR>", opts)

-- Toggle search highlighting. The next time you search, highlighting
-- should still work.
keymap("n", "<Leader>th", ":nohlsearch<CR>", opts)

-- Toggle spell check.
keymap("n", "<Leader>ts", ":set spell!<CR>", opts)

--=====================================================================
-- Buffers
--=====================================================================

--[[

Delete a buffer:
* Use the bdelete (bd) command.
* Find the number of the buffer you want to delete by listing all
  buffers.
* Prepend the bdelete command with the number of the buffer you want to
  delete.

--]]

-- Open a new buffer.
keymap("n", "<Leader>b", ":enew<CR>", opts)

-- Show all buffers.
keymap("n", "<Leader>sb", ":buffers<CR>", opts)

-- Switch to the previous buffer using shift-h.
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Switch to the next buffer using shift-l.
keymap("n", "<S-l>", ":bnext<CR>", opts)

--=====================================================================
-- Tabs
--=====================================================================

-- Open a new tab.
keymap("n", "<Leader><Tab>", ":tabnew<CR>", opts)

-- Switch to the left tab.
keymap("n", "<S-Tab>", ":tabprevious<CR>", opts)

-- Switch to the right tab.
keymap("n", "<Tab>", ":tabnext<CR>", opts)

--=====================================================================
-- Windows
--=====================================================================

-- Navigate windows using the control key and the h, j, k, and l keys.
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize the window using the control key and the arrow keys.
-- This seems to be relative to the first window you resize.
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Always open horizontal splits below.
vim.opt.splitbelow = true

-- Always open vertical splits to the right.
vim.opt.splitright = true

--=====================================================================
-- Indentation
--=====================================================================

-- When in insert mode, use the appropriate number of spaces to insert a
-- <Tab>. Spaces are used in indents with the > and < commands and
-- when autoindent is on.
vim.opt.expandtab = true

-- Repeat the less-than or greater-than character to indent a line when
-- in visual mode.
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Set number of spaces to use for each step of (auto)indent. For
-- example, when indenting with >, insert N spaces. There are other
-- (auto)indent scenarios where N spaces will be inserted.
vim.opt.shiftwidth = 4

-- Copy indent from current line when starting a new line.
vim.opt.autoindent = true

--=====================================================================
-- Colors
--=====================================================================

-- If you don't have a color scheme installed from a package, use the
-- built-in "slate" colorscheme.
vim.cmd("colorscheme gruvbox")

-- Enable 24-bit RGB color in the TUI. Basically, the colors look nicer
-- if your terminal supports this.
vim.opt.termguicolors = true

-- Make the background dark by default.
vim.opt.background = "dark"

--=====================================================================
-- One-off options
--=====================================================================

--[[

A few tips and tricks before we start setting options.

To see what the foobar option is set to:

```
:set foobar?
```

If the foobar option is a boolean option (as many Vim/Neovim options
are) a value of foobar means the option is on. A value of nofoobar means
the option is off. If the option has a numeric or other value, that
value will be shown.

To not (as in logical not) the foobar option:

```
:set foobar!
```

To revert the foobar option to its default value:

```
:set foobar&
```

--]]

-- Don't use the mouse.
vim.opt.mouse = ""

-- Set maximum width of text that is being inserted.
vim.opt.textwidth = 72

-- Don't wrap lines when the window size is narrower than the width of
-- the text.
vim.opt.wrap = false

-- When showing all whitespace characters, show them as the following
-- characters.
vim.opt.listchars = {
    eol = "$",
    tab = ">-",
    trail = "~",
    extends = ">",
    precedes = "<",
    space = ".",
}

-- Disable swap files. Vim doesn't crash often enough to warrant them.
-- Vim stores the things you changed in a swap file. Using the original
-- file you started from plus the swap file you can mostly recover your
-- work.
vim.opt.swapfile = false

-- Yank and put/paste from the system clipboard.
vim.opt.clipboard = "unnamedplus"
