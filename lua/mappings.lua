local buf_map = function(bufnr, mode, lhs, rhs, opts)
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
        silent = true,
    })
end

local key_mapper = function(mode, key, result)
    vim.api.nvim_set_keymap(
        mode,
        key,
        result,
        {noremap = true, silent = true}
    )
end

-- movement mappings
key_mapper('', '<up>', '<nop>')
key_mapper('', '<down>', '<nop>')
key_mapper('', '<left>', '<nop>')
key_mapper('', '<right>', '<nop>')
key_mapper('i', 'jk', '<ESC>')
key_mapper('i', 'JK', '<ESC>')
key_mapper('i', 'jK', '<ESC>')
key_mapper('v', 'jk', '<ESC>')
key_mapper('v', 'JK', '<ESC>')
key_mapper('v', 'jK', '<ESC>')

-- filebrowser mappings
key_mapper('', '<Leader>b', ':Vex<CR>')

-- ctrlp mappings
key_mapper('', '<Leader>p', ':CtrlP<CR>')

-- lsp mappings
-- key_mapper('n', 'gd', ':lua vim.lsp.buf.definition()<CR>')
-- key_mapper('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>')
-- key_mapper('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>')
-- key_mapper('n', 'gw', ':lua vim.lsp.buf.document_symbol()<CR>')
-- key_mapper('n', 'gW', ':lua vim.lsp.buf.workspace_symbol()<CR>')
-- key_mapper('n', 'gr', ':lua vim.lsp.buf.references()<CR>')
-- key_mapper('n', 'gt', ':lua vim.lsp.buf.type_definition()<CR>')
-- key_mapper('n', 'K', ':lua vim.lsp.buf.hover()<CR>')
-- key_mapper('n', '<c-k>', ':lua vim.lsp.buf.signature_help()<CR>')
-- key_mapper('n', '<leader>af', ':lua vim.lsp.buf.code_action()<CR>')
-- key_mapper('n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>')

function define_lsp_commands()
    vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
    vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
    vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
    vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
    vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
    vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
    vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
    vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
    vim.cmd("command! LspDiagPrev lua vim.diagnostic.goto_prev()")
    vim.cmd("command! LspDiagNext lua vim.diagnostic.goto_next()")
    vim.cmd("command! LspDiagLine lua vim.diagnostic.open_float()")
    vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
end

function set_local_lsp_mappings(bufnr)
    buf_map(bufnr, "n", "gd", ":LspDef<CR>")
    buf_map(bufnr, "n", "gr", ":LspRename<CR>")
    buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>")
    buf_map(bufnr, "n", "K", ":LspHover<CR>")
    buf_map(bufnr, "n", "[a", ":LspDiagPrev<CR>")
    buf_map(bufnr, "n", "]a", ":LspDiagNext<CR>")
    buf_map(bufnr, "n", "ga", ":LspCodeAction<CR>")
    buf_map(bufnr, "n", "<Leader>a", ":LspDiagLine<CR>")
    buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>")
end

function set_local_ts_mappings(bufnr)
    buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
    buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
    buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")
end

function set_cmp_mappings(cmp)
    return {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }
end

return {
    define_lsp_commands = define_lsp_commands,
    set_local_lsp_mappings = set_local_lsp_mappings,
    set_local_ts_mappings = set_local_ts_mappings,
    set_cmp_mappings = set_cmp_mappings,
}
