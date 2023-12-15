return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
            { "folke/neodev.nvim", opts = {} },
            "mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            {
                "hrsh7th/cmp-nvim-lsp"
            },
        },
    },
    {
        "nvimdev/lspsaga.nvim",
        event = "LspAttach",
        config = function()
            require("lspsaga").setup({})
        end,
        dependencies = {
            {"nvim-tree/nvim-web-devicons"},
            --Please make sure you install markdown and markdown_inline parser
            {"nvim-treesitter/nvim-treesitter"}
        }
    },
    {
        "onsails/lspkind.nvim",
        event = "LspAttach",
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "LspAttach",
        opts = function()
            -- Apply globals from 1-options.lua
            local is_enabled = true
            local round_borders = { border = 'rounded' }
            return {
                -- Window mode
                floating_window = is_enabled, -- Dislay it as floating window.
                hi_parameter = "IncSearch",   -- Color to highlight floating window.
                handler_opts = round_borders, -- Window style

                -- Hint mode
                hint_enable = false,          -- Display it as hint.
                hint_prefix = "👈 "

                -- Aditionally, you can use <space>ui to toggle inlay hints.
            } end,
        config = function(_, opts) require'lsp_signature'.setup(opts) end
    },
    {
        "simrat39/rust-tools.nvim",
        ft = "rust",
        config = function()
            local rt = require("rust-tools")
            rt.setup({
                server = {
                    on_attach = function (_, bufnr)
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
                }
            })
        end,
        dependencies = {
            {"nvim-tree/nvim-web-devicons"},
            --Please make sure you install markdown and markdown_inline parser
            {"nvim-treesitter/nvim-treesitter"}
        }
    },
}
