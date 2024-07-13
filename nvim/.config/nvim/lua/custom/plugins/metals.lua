return {
    'scalameta/nvim-metals',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'mfussenegger/nvim-dap',
    },
    ft = { 'scala', 'sbt', 'java' },
    opts = function()
        local metals_config = require('metals').bare_config()
        metals_config.on_attach = function(client, bufnr)
            require('metals').setup_dap()
            -- TODO these seem to not work
            local map = vim.keymap.set

            -- LSP mappings
            -- map('n', 'gD', vim.lsp.buf.definition)
            -- map('n', 'K', vim.lsp.buf.hover)
            -- map('n', 'gi', vim.lsp.buf.implementation)
            map('n', 'gr', vim.lsp.buf.references)
            map('n', 'gds', vim.lsp.buf.document_symbol)
            map('n', 'gws', vim.lsp.buf.workspace_symbol)
            -- map('n', '<leader>cl', vim.lsp.codelens.run)
            map('n', '<leader>rn', vim.lsp.buf.rename)
            map('n', '<leader>f', vim.lsp.buf.format)

            map('n', '<leader>ws', function()
                require('metals').hover_worksheet()
            end)

            -- all workspace diagnostics
            map('n', '<leader>aa', vim.diagnostic.setqflist)

            -- all workspace errors
            map('n', '<leader>ae', function()
                vim.diagnostic.setqflist({ severity = 'E' })
            end)

            -- all workspace warnings
            map('n', '<leader>aw', function()
                vim.diagnostic.setqflist({ severity = 'W' })
            end)

            -- buffer diagnostics only
            map('n', '<leader>d', vim.diagnostic.setloclist)

            -- map('n', '[c', function()
            --     vim.diagnostic.goto_prev({ wrap = false })
            -- end)
            --
            -- map('n', ']c', function()
            --     vim.diagnostic.goto_next({ wrap = false })
            -- end)

            -- Example mappings for usage with nvim-dap. If you don't use that, you can
            -- skip these
            -- map('n', '<leader>dc', function()
            --     require('dap').continue()
            -- end)

            -- map('n', '<leader>dr', function()
            --     require('dap').repl.toggle()
            -- end)

            map('n', '<leader>dK', function()
                require('dap.ui.widgets').hover()
            end)

            -- map('n', '<leader>dt', function()
            --     require('dap').toggle_breakpoint()
            -- end)
            --
            -- map('n', '<leader>dso', function()
            --     require('dap').step_over()
            -- end)
            --
            -- map('n', '<leader>dsi', function()
            --     require('dap').step_into()
            -- end)
            --
            -- map('n', '<leader>dl', function()
            --     require('dap').run_last()
            -- end)
        end

        return metals_config
    end,
    config = function(self, metals_config)
        local nvim_metals_group = vim.api.nvim_create_augroup('nvim-metals', { clear = true })
        vim.api.nvim_create_autocmd('FileType', {
            pattern = self.ft,
            callback = function()
                require('metals').initialize_or_attach(metals_config)
            end,
            group = nvim_metals_group,
        })
    end
}
