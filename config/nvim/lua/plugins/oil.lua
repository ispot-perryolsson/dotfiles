local display = require("util.display")
local function opts(desc)
  return { desc = "nvim-oil: " .. desc, noremap = true, silent = true, nowait = true }
end
local oil = require("oil")
oil.setup({
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
oil.setup({
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
  oil.open()
end)
function tprint(tbl, indent, result)
    if not indent then indent = 0 end
    result = result or ""
    for k, v in pairs(tbl) do
        local formatting = string.rep("  ", indent) .. k .. ": "
        if type(v) == "table" then
            result = result .. formatting
            tprint(v, indent + 1, result)
        else
            result = result .. formatting .. tostring(v)
        end
    end
    return result
end
local function run_script()
    vim.ui.input({ prompt = "Enter script args: " }, function(input)
        local entry = oil.get_entry_on_line(1, 1)
        display(tprint(entry))

        --[[ local abs_path = api.tree.get_node_under_cursor()["absolute_path"]
        local handle = io.popen(abs_path.." "..input)
        if handle == nil then
            return
        end
        local output = handle:read("*a")
        handle:close()
        local format = output:gsub("[\n\r]", " ")
        print(format) ]]
    end)
end
vim.keymap.set("n", "<leader><S-r>", run_script, opts("Run shell script"))
