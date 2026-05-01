---@diagnostic disable: undefined-global
--[[ 
**************************************************************
**********************TELESCOPE CONFIG************************
**************************************************************
--]]
local get_opts = function(desc)
    return { noremap=true, silent=true, desc=desc }
end
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fl', function()
  require('telescope.builtin').live_grep({
    additional_args = function(args)
      return { "--hidden" }
    end
  })
end, { desc = "Live Grep (including hidden)" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set("n", "<leader>fd", "<cmd>Telescope find_files hidden=true<cr>", get_opts("Find files (include hidden)"))
