local jdtls = require('jdtls')

local mason_jdtls = vim.fn.stdpath('data') .. '/mason/packages/jdtls'
local launcher = vim.fn.glob(mason_jdtls .. '/plugins/org.eclipse.equinox.launcher_*.jar')

-- Per-project workspace cache
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath('data') .. '/jdtls-workspaces/' .. project_name
local lombok_path = vim.fn.glob(mason_jdtls .. '/lombok.jar')

local config = {
    cmd = {
        vim.env.JAVA_HOME .. '/bin/java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx2g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-javaagent:' .. lombok_path,
        '-jar', launcher,
        '-configuration', mason_jdtls .. '/config_mac',
        '-data', workspace_dir,
    },
    root_dir = jdtls.setup.find_root({ '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }),
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    settings = {
        java = {
            configuration = {
                runtimes = {
                    { name = 'JavaSE-21', path = vim.env.JAVA_HOME, default = true },
                }
            }
        }
    },
    on_attach = function(client)
        client.server_capabilities.semanticTokensProvider = nil
    end,
}

jdtls.start_or_attach(config)
