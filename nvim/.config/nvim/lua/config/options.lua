-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- Indent line automatically
vim.o.smartindent = true
-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Background buffers should also have statusline with filename (useful for vimdiff)
vim.o.laststatus = 2

-- Disable wrap
vim.o.wrap = false
-- Keep cursor in viewport
vim.o.scrolloff = 8
-- Convert tabs to spaces
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.filetype.add({ extension = { templ = "templ" } })

-- For some reason this opening python files on macOS is super slow for me, even w/o any plugins.
-- This fixes the issue. Possibly something to do with pyenv shimming and neovim not finding a binary quickly
vim.g.loaded_python3_provider = 0
vim.g.loaded_python_provider = 0

vim.g.autoformat = false
