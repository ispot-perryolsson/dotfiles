---@diagnostic disable: undefined-global
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.lsp.enable('rust_analyzer')
vim.lsp.config('rust_analyzer', {
    settings = {
        ['rust-analyzer'] = {}
    }
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.enable('ts_ls')
vim.lsp.config('ts_ls', {
    capabilities = capabilities
})
--[[ vim.lsp.enable('ruby_lsp')
vim.lsp.config('ruby_lsp', {
    capabilities = capabilities,
    init_options = {
        formatter = 'standard',
        linters = { 'standard' },
    }
}) ]]
vim.lsp.enable('lua_ls')
vim.lsp.config('lua_ls', {
    capabilities = capabilities
})
vim.lsp.enable('pyright')
vim.lsp.config('pyright', {
    capabilities = capabilities
})
vim.lsp.enable('clangd')
vim.lsp.config('clangd', {
    capabilities = capabilities
})
vim.lsp.enable('terraformls')
vim.lsp.config('terraformls', {
    capabilities = capabilities
})
vim.keymap.set('n', '<leader><S-e>', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>di', function() vim.diagnostic.jump{count = 1, float = true} end)
vim.keymap.set('n', '<leader>do', function() vim.diagnostic.jump{count = -1, float = true} end)
vim.keymap.set('n', '<leader>dl', "<cmd>Telescope diagnostics<cr>")
vim.keymap.set('n', '<leader><S-q>', vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<leader><C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', "<cmd>Telescope lsp_references<cr>", opts)
    end
})
