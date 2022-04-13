local lspconfig = require'lspconfig'
local util = require("lspconfig.util")
local null_ls = require("null-ls")
local mappings = require("mappings")

local function custom_on_attach(client, bufnr)
    print('Attaching to ' .. client.name)
    mappings.define_lsp_commands()
    mappings.set_local_lsp_mappings(bufnr)

    if client.resolved_capabilities.document_formatting then
        vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    end
end

local function make_init_options()
    local init_options = require("nvim-lsp-ts-utils").init_options
    init_options.preferences.importModuleSpecifierPreference = "project-relative"

    return init_options
end

local default_config = {
    on_attach = function(client, bufnr)
        print('Attaching to ' .. client.name)
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
require('rust-tools').setup({
    server = {
        on_attach = custom_on_attach,
    }
})

local prefer_local = {
    prefer_local = "node_modules/.bin",
}

null_ls.setup({
    sources = {
        -- null_ls.builtins.diagnostics.eslint,
        -- null_ls.builtins.code_actions.eslint,
        -- null_ls.builtins.formatting.eslint,
        null_ls.builtins.diagnostics.eslint_d.with(prefer_local),
        null_ls.builtins.code_actions.eslint_d.with(prefer_local),
        null_ls.builtins.formatting.eslint_d.with(prefer_local),
    },
    on_attach = custom_on_attach,
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        virtual_text = false,
        signs = true,
        update_in_insert = true,
    }
)
