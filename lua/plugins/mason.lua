return
    {
        {
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
                    require "lsp_signature".on_attach({
                        bind = true,
                        handler_opts = {
                            border = "rounded"
                        }
                    }, bufnr)
                    local nmap = function(keys, func, desc)
                        if desc then
                            desc = 'LSP: ' .. desc
                        end

                        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
                    end


                    nmap('<leader>rn', "<cmd>Lspsaga rename<CR>", '[R]e[n]ame')
                    nmap('<leader>ca', "<cmd>Lspsaga code_action<CR>", '[C]ode [A]ction')

                    nmap('gD', vim.lsp.buf.definition, '[G]oto [D]efinition')
                    nmap('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
                    nmap('gd', "<cmd>Lspsaga goto_definition<CR>", '[G]oto [D]efinition')
                    nmap('gh', "<cmd>Lspsaga finder <CR>", '[G]oto [D]efinition')
                    nmap('<leader>gd', '<cmd>Lspsaga peek_definition<CR>', '[G]oto [D]efinition')
                    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
                    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
                    nmap('<leader>t', "<cmd>Lspsaga term_toggle<CR>", '[W]orkspace [S]ymbols')
                    nmap('<leader>o', "<cmd>Lspsaga outline<CR>", '[W]orkspace [S]ymbols')
                    nmap('K', "<cmd>Lspsaga hover_doc <CR>", 'Hover Documentation')
                    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
                    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
                    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
                    nmap('<leader>wl', function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, '[W]orkspace [L]ist Folders')
                end

                local servers = {
                    cssls = {},
                    html = {},
                    omnisharp = {},

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

                local rust_tools_config = {
                    -- rust-tools settings, etc.
                    dap = function()
                        local install_root_dir = vim.fn.stdpath "data" .. "/mason"
                        local extension_path = install_root_dir .. "/packages/codelldb/extension/"
                        local codelldb_path = extension_path .. "adapter/codelldb"
                        local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

                        return {
                            adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
                        }
                    end,
                }
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
                                        includePaths = {"/home/danielr/work/projects/corepublish/", "vendor/"},
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
                        require('lspconfig').omnisharp.setup {
                            on_attach = on_attach,
                            capabilities = capabilities,
                            enable_editorconfig_support = true,
                            enable_ms_build_load_projects_on_demand = false,
                            enable_roslyn_analyzers = false,
                            organize_imports_on_format = true,
                            enable_import_completion = true,
                            sdk_include_prereleases = true,
                            analyze_open_documents_only = false,
                            -- cmd = { "dotnet", "/home/danielr/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll" }
                            cmd = { "/home/danielr/.local/share/nvim/mason/bin/omnisharp", "--languageserver", "--hostPID", tostring(pid) }
                        }
                    end,
                    ["rust_analyzer"] = function() end,
                }
            end,
        },
        -- {
        --     "nvimtools/none-ls.nvim",
        --     dependencies = {
        --         {
        --             "jay-babu/mason-null-ls.nvim",
        --             cmd = { "NullLsInstall", "NullLsUninstall" },
        --             opts = { handlers = {} },
        --         },
        --     },
        --     event = "LspAttach",
        --     opts = function()
        --         local nls = require "null-ls"
        --         return {
        --             -- sources = {
        --             --     nls.builtins.diagnostics.phpcs.with({
        --             --         filetypes = {"php"},
        --             --         extra_args = {
        --             --             -- "--standard=vendor/coretrek/php-codingstandards/ruleset.xml"
        --             --             "--standard=ruleset.xml"
        --             --         },
        --             --         diagnostic_config = {
        --             --             virtual_text = true,
        --             --         }
        --             --     })
        --             -- },
        --         }
        --     end,
        --     config = function(_, opts)
        --         local nls = require "null-ls"
        --         nls.setup(opts)
        --
        --         -- Ensure null-ls start its sources when a lsp client starts.
        --         vim.api.nvim_create_autocmd({ "LspAttach" }, {
        --             desc = "Ensure null-ls start its sources a lsp client starts",
        --             callback = function()
        --                 pcall(function() require("null-ls").enable({}) end)
        --             end,
        --         })
        --
        --     end
        -- },
    }
