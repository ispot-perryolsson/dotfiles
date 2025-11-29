---@diagnostic disable: undefined-global
vim.g.netrw_liststyle = 3 -- Tree-style view
vim.g.netrw_keepdir = 0
vim.opt.compatible = false
vim.opt.hidden = true
vim.opt.wildmenu = true
vim.opt.showcmd = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.backspace = { 'indent', 'eol', 'start' }
vim.opt.autoindent = true
vim.opt.startofline = false
vim.opt.ruler = true
vim.opt.confirm = true
vim.opt.visualbell = true
vim.opt.cmdheight = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.fillchars:append { eob = " " }
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 1
vim.opt.foldnestmax = 2
vim.cmd("set notimeout ttimeout ttimeoutlen=200")
vim.cmd("set t_vb=")
vim.cmd([[
if has('mouse')
  set mouse=a
endif
]])
vim.cmd([[
if has('filetype')
  filetype indent plugin on
endif
]])
