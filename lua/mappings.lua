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

-- remap space to nop
key_mapper('', ' ', '<nop>')

-- movement mappings
key_mapper('', '<up>', '<nop>')
key_mapper('', '<down>', '<nop>')
key_mapper('', '<left>', '<nop>')
key_mapper('', '<right>', '<nop>')
key_mapper('i', '<up>', '<nop>')
key_mapper('i', '<down>', '<nop>')
key_mapper('i', '<left>', '<nop>')
key_mapper('i', '<right>', '<nop>')


-- filebrowser mappings
key_mapper('', '<Leader>b', ':Lex<CR>')

-- fzf mappings
key_mapper('', '<Leader>p', "<cmd>lua require('fzf-lua').files()<CR>")
key_mapper('', '<Leader>f', "<cmd>lua require('fzf-lua').grep_curbuf()<CR>")
key_mapper('', '<Leader>F', "<cmd>lua require('fzf-lua').grep_project()<CR>")

-- Cmake commands
vim.cmd("command! CMakeExportCompileCommands !cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1")


function define_lsp_commands()
    vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
    vim.cmd("command! LspDec lua vim.lsp.buf.declaration()")
    vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
    vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
    vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
    vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
    vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
    vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
    vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
    vim.cmd("command! LspDiagPrev lua vim.diagnostic.goto_prev()")
    vim.cmd("command! LspDiagNext lua vim.diagnostic.goto_next()")
    vim.cmd("command! LspDiagShow lua vim.diagnostic.show()")
    vim.cmd("command! LspDiagLine lua vim.diagnostic.open_float()")
    vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
end

function set_local_lsp_mappings(bufnr)
    buf_map(bufnr, "n", "gd", ":LspDef<CR>")
    buf_map(bufnr, "n", "gD", ":LspDec<CR>")
    buf_map(bufnr, "n", "gi", ":LspImplementation<CR>")
    buf_map(bufnr, "n", "gr", ":LspRename<CR>")
    buf_map(bufnr, "n", "gR", ":LspRefs<CR>")
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
    local select_opts = { behavior = cmp.SelectBehavior.Select }
    return {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item(select_opts)
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item(select_opts)
            else
                fallback()
            end
        end, { 'i', 's' }),   
    }
end

return {
    define_lsp_commands = define_lsp_commands,
    set_local_lsp_mappings = set_local_lsp_mappings,
    set_local_ts_mappings = set_local_ts_mappings,
    set_cmp_mappings = set_cmp_mappings,
}

