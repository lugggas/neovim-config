local lspconfig = require'lspconfig'
local util = require("lspconfig.util")
-- local null_ls = require("null-ls")
local mappings = require("mappings")

local function custom_on_attach(client, bufnr)
    print('Attaching to ' .. client.name)
    mappings.define_lsp_commands()
    mappings.set_local_lsp_mappings(bufnr)
end

local function make_init_options()
    local init_options = require("nvim-lsp-ts-utils").init_options
    init_options.preferences.importModuleSpecifierPreference = "project-relative"

    return init_options
end

local default_config = {
    on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
        local ts_utils = require("nvim-lsp-ts-utils")
        ts_utils.setup({})
        ts_utils.setup_client(client)

        mappings.set_local_ts_mappings(bufnr)
        custom_on_attach(client, bufnr)
    end,
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    root_dir = util.root_pattern("tsconfig.json", "jsconfig.json"),
    init_options = make_init_options(),
}

-- setup language servers here
lspconfig.tsserver.setup(default_config)
lspconfig.eslint.setup({
    on_attach = function(client, bufnr)
        custom_on_attach(client, bufnr)
    end,
})

require('rust-tools').setup({
    server = {
        on_attach = custom_on_attach,
    }
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        virtual_text = false,
        signs = true,
        update_in_insert = true,
    }
)
