return {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {
        ensure_installed = {},
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
        -- LSP settings.
        --  This function gets run when an LSP connects to a particular buffer.
        local on_attach = function(_, bufnr)
            -- require "lsp_signature".on_attach({
            --     bind = true,
            --     handler_opts = {
            --         border = "rounded"
            --     }
            -- }, bufnr)
            local nmap = function(keys, func, desc)
                if desc then
                    desc = 'LSP: ' .. desc
                end

                vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
            end


            nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
            nmap('<leader>ca', "<cmd>Lspsaga code_action<CR>", '[C]ode [A]ction')

            nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]efinition')
            nmap('gh', "<cmd>Lspsaga lsp_finder <CR>", '[G]oto [D]efinition')
            nmap('gd', ':Telescope lsp_definitions<CR>', '[G]oto [D]efinition')
            nmap('<leader>gd', '<cmd>Lspsaga peek_definition<CR>', '[G]oto [D]efinition')
            nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
            nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
            nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
            nmap('<leader>so', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
            nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
            nmap('<leader>t', "<cmd>Lspsaga term_toggle<CR>", '[W]orkspace [S]ymbols')
            nmap('<leader>o', "<cmd>Lspsaga outline<CR>", '[W]orkspace [S]ymbols')

            -- See `:help K` for why this keymap
            nmap('K', "<cmd>Lspsaga hover_doc ++quiet<CR>", 'Hover Documentation')
            nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

            -- Lesser used LSP functionality
            nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
            nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
            nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
            nmap('<leader>wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, '[W]orkspace [L]ist Folders')
        end

        local servers = {
            rust_analyzer = {},
            cssls = {},
            html = {},

            lua_ls = {
                Lua = {
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                },
            },
        }

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

        require("mason").setup(opts)
        local mason_lspconfig = require 'mason-lspconfig'

        mason_lspconfig.setup_handlers {
            function(server_name)
                require('lspconfig')[server_name].setup {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = servers[server_name],
                    single_file_support = true,
                }
                require('lspconfig').tsserver.setup {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = {},
                    single_file_support = true,
                }
                require('lspconfig').intelephense.setup {
                    on_attach = on_attach,
                    capabilities = capabilities,
                    settings = {
                        intelephense = {
                            environment = {
                                includePaths = {"/home/danielr/Work/projects/corepublish/", "vendor/"},
                            },
                            files = {
                                maxSize = 10000000,
                            }
                        }
                    },
                    init_options = {
                        licenceKey = "006F3Y69WS65HCI",
                    }
                }
            end,
        }
    end,
}
