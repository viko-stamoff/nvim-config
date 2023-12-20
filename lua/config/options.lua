-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.hlsearch = false
vim.o.mouse = "a"
vim.o.clipboard = "unnamedplus"
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.completeopt = "menuone,noselect"
vim.o.termguicolors = true
vim.o.scrolloff = 5

vim.wo.relativenumber = true
vim.wo.number = true
vim.wo.signcolumn = "yes"
vim.wo.relativenumber = true

vim.opt.autochdir = true

vim.opt.tabstop = 2
vim.o.tabstop = 2
vim.opt.shiftwidth = 2
vim.o.shiftwidth = 2
vim.opt.expandtab = true
vim.o.expandtab = true

vim.bo.softtabstop = 2
