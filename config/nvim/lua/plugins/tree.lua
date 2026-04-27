---@diagnostic disable: undefined-global
local api = require "nvim-tree.api"
local function opts(desc)
  return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
end

local previous_path = nil

local function change_root_to_config()
    previous_path = vim.fn.getcwd()
    api.tree.change_root("~/.config/nvim/lua")
end

local function change_back_from_config()
    if previous_path == nil then
        return
    end
    api.tree.change_root(previous_path)
end

local function change_working_directory()
    local node = api.tree.get_node_under_cursor()
    local abs_path = node["type"] == "directory" and node["absolute_path"] or node["parent"]["absolute_path"]
    print(abs_path)
    vim.cmd(":cd "..abs_path)
end

local function change_root_and_working_directory()
    local node = api.tree.get_node_under_cursor()
    local abs_path = node["absolute_path"]
    print(abs_path)
    if abs_path == nil then
        return
    end
    vim.cmd(":cd "..abs_path)
    api.tree.change_root(abs_path)
end

local function run_script()
    vim.ui.input({ prompt = "Enter script args: " }, function(input)
        local abs_path = api.tree.get_node_under_cursor()["absolute_path"]
        local handle = io.popen(abs_path.." "..input)
        if handle == nil then
            return
        end
        local output = handle:read("*a")
        handle:close()
        local format = output:gsub("[\n\r]", " ")
        print(format)
    end)
end

local function strip_file_handle(filePath)
  return string.match(filePath, "(.*)/[^/]+$") or ""
end

local function change_root_to_current_buffer()
    local file_path = vim.api.nvim_buf_get_name(0)
    file_path = strip_file_handle(file_path)
    if file_path == "" then
        print("No directory found")
    end
    api.tree.change_root(file_path)
end

vim.keymap.set("n", "<leader>cr", change_root_to_current_buffer, opts("change root to current buffer"))

local function my_on_attach(bufnr)
    -- default mappings
    api.config.mappings.default_on_attach(bufnr)
    vim.keymap.set("n", "<leader>cn", change_root_to_config, opts("change root"))
    vim.keymap.set("n", "<leader>cb", change_back_from_config, opts("change root"))
    vim.keymap.set("n", "<leader>cd", change_working_directory, opts("Change to working directory"))
    vim.keymap.set("n", "<leader><S-r>", run_script, opts("Run shell script"))
    vim.keymap.set("n", "<leader>]", change_root_and_working_directory, opts("Change root and working directory"))
end

local nvim_tree_width = 45

vim.cmd("nmap <leader>e  <cmd>NvimTreeToggle<CR> <cmd>vertical resize "..nvim_tree_width.."<CR>")
--[[ vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.cmd("NvimTreeToggle<CR>")
        vim.cmd("vertical resize "..nvim_tree_width.."<CR>")
    end
}) ]]

  -- pass to setup along with your other options
require("nvim-tree").setup {
    on_attach = my_on_attach,
    view = {
        preserve_window_proportions = true
    }
}
