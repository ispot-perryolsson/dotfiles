---@diagnostic disable: undefined-global
require("mason").setup()
require("mappings")
require("plugins.neodev")
require("plugins.neotest")
require("plugins.dap")
require("plugins.dapui")
require("plugins.lsp")
require("plugins.cmp")
require("plugins.lualine")
require("plugins.harpoon")
require("plugins.gitsigns")
require("plugins.telescope")
require("vim_settings")
require("transparency")
require("oil").setup({
    keymaps = {
        ["g?"] = { "actions.show_help", mode = "n" },
        ["<CR>"] = "actions.select",
        ["<C-s>"] = false,
        ["<C-h>"] = false,
        ["<C-t>"] = { "actions.select", opts = { tab = true } },
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = { "actions.close", mode = "n" },
        ["<C-l>"] = false,
        ["-"] = { "actions.parent", mode = "n" },
        ["_"] = { "actions.open_cwd", mode = "n" },
        ["`"] = { "actions.cd", mode = "n" },
        ["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
        ["gs"] = { "actions.change_sort", mode = "n" },
        ["gx"] = "actions.open_external",
        ["g."] = { "actions.toggle_hidden", mode = "n" },
        ["g\\"] = { "actions.toggle_trash", mode = "n" },
    },
})
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>e", function()
  vim.api.nvim_open_win(0, true, {
    split = 'left',
    win = -1 -- -1 makes it a global split at the far left
  })
  require("oil").open()
end)
require('nvim-treesitter').setup {
  -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
  install_dir = vim.fn.stdpath('data') .. '/site'
}
require('nvim-treesitter').install { 'rust', 'javascript', 'zig', 'python' }
