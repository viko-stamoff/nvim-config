vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.wo.relativenumber = true
vim.o.hlsearch = false
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true
vim.o.scrolloff = 5
vim.wo.number = true
vim.wo.signcolumn = 'yes'
vim.wo.relativenumber = true
vim.opt.autochdir = true

-- <leader> and p or d deletes the selected text, if any
vim.keymap.set({'n', 'x'}, '<leader>d', '"_d')
vim.keymap.set({'n', 'x'}, '<leader>p', '"_dP')

-- Center when scrolling
vim.keymap.set({'n', 'x'}, '<C-u>', '<C-u>zz')
vim.keymap.set({'n', 'x'}, '<C-d>', '<C-d>zz')

-- Move lines
vim.keymap.set('v', 'J', ':m \'>+1<CR>gv=gv')
vim.keymap.set('v', 'K', ':m \'<-2<CR>gv=gv')

-- Cursor remains in same position, when appending to upper line
vim.keymap.set('n', 'J', 'mzJ`z')

-- Search terms stay in the middle
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Saves changes when editing multi-line
vim.keymap.set('i', '<C-c>', '<Esc>')

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set({ 'n', 'v' }, 'k', 'v:count == 0 ? "gk" : "k"', { expr = true, silent = true })
vim.keymap.set({ 'n', 'v' }, 'j', 'v:count == 0 ? "gj" : "j"', { expr = true, silent = true })
vim.keymap.set({ 'n', 'v' }, '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set({ 'n', 'v' }, ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set({ 'n' }, '<leader>cm', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set({ 'n' }, '<leader>ck', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
