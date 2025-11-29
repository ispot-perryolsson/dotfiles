---@diagnostic disable: undefined-global
local opts = { noremap=true, silent=true }
local get_opts = function(desc)
    return { noremap=true, silent=true, desc=desc }
end
vim.g.mapleader = " "
-- quit all
vim.keymap.set("n", "<leader>q", ":qa<CR>", get_opts("quit all"))
-- quit window
vim.keymap.set("n", "q", ":q<CR>", get_opts("quit"))
-- save
vim.keymap.set("n", "<leader>s", ":w<CR>", get_opts("save file"))
vim.keymap.set("n", "<leader>ls", ":edit $HOME/.config/nvim/lua/config.lua<CR>", get_opts("Edit config.lua"))
vim.keymap.set("n", "<leader>nt", ":help nvim-tree-setup<CR>", get_opts("Nvim tree setup help"))
vim.keymap.set("n", "<leader>h", ":noh<CR>", get_opts("No highlight"))
vim.keymap.set("i", "jk", "<ESC>", opts)

local print_working_directory = function()
    print(vim.api.nvim_buf_get_name(0))
end
-- print working directory
vim.keymap.set("n", "<leader>pd", print_working_directory, get_opts("Prints the working directory of the current buffer"))

vim.keymap.set("n", "<C-L>", "nohl<CR><C-L>", opts)
vim.keymap.set("n", "<leader>wv", "<C-W>v", opts)
vim.keymap.set("n", "<leader>wc", "<C-W>s", opts)
vim.keymap.set("n", "<leader>wd", ":lcd %:p:h<CR>", opts)

-- split resizing
vim.keymap.set("n", "<A-=>", ":res +5<CR>", opts)
vim.keymap.set("n", "<A-->", ":res -5<CR>", opts)
vim.keymap.set("n", "=", ":vertical res +15<CR>", opts)
vim.keymap.set("n", "-", ":vertical res -15<CR>", opts)

-- split movements
vim.keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>")
vim.keymap.set("n", "<C-j>", ":TmuxNavigateDown<CR>")
vim.keymap.set("n", "<C-k>", ":TmuxNavigateUp<CR>")
vim.keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>")
vim.keymap.set("i", "<C-h>", "<C-\\><C-N>:TmuxNavigateLeft<CR>", opts)
vim.keymap.set("i", "<C-j>", "<C-\\><C-N>:TmuxNavigateDown<CR>", opts)
vim.keymap.set("i", "<C-k>", "<C-\\><C-N>:TmuxNavigateUp<CR>", opts)
vim.keymap.set("i", "<C-l>", "<C-\\><C-N>:TmuxNavigateRight<CR>", opts)
vim.keymap.set("t", "<C-h>", "<C-\\><C-N>:TmuxNavigateLeft<CR>", opts)
vim.keymap.set("t", "<C-j>", "<C-\\><C-N>:TmuxNavigateDown<CR>", opts)
vim.keymap.set("t", "<C-k>", "<C-\\><C-N>:TmuxNavigateUp<CR>", opts)
vim.keymap.set("t", "<C-l>", "<C-\\><C-N>:TmuxNavigateRight<CR>", opts)

-- remap copy to clipboard
vim.keymap.set("n", "<leader>yy", '"+yy', opts)
vim.keymap.set("v", "<leader>y", '"+y', opts)

-- paste no yank
vim.keymap.set("v", "<leader>p", "\"_dP")

-- terminal emulator
-- vim.cmd("nnoremap <leader>t <C-W>s<C-W>j:terminal<CR> :resize 10<CR>")
-- vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", opts)

vim.cmd("map Y y$")

local function get_buf_file_path ()
    local file_path = vim.api.nvim_buf_get_name(0)
    file_path = file_path:gsub("/[^/]*$", "")
    vim.cmd(":cd "..file_path)
end

-- Set working directory to current file
vim.keymap.set("n", "fd", get_buf_file_path, opts)

-- folding
vim.keymap.set("n", "<leader>z", "za", opts)
