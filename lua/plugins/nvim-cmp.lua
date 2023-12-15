return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp"
        },
        event = "InsertEnter",
        opts = function()
            local cmp = require "cmp"
            local snip_status_ok, luasnip = pcall(require, "luasnip")
            local lspkind = require('lspkind')
            if not snip_status_ok then return end
            local border_opts = {
                border = "rounded",
                winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
            }

            local function has_words_before()
                local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
            end

            return {
                completion = {
                    completeopt = "menu,menuone,noinsert"
                },
                formatting = {
                    format = lspkind.cmp_format({
                        mode = 'text_symbol',
                        maxwidth = 50,
                        ellipsis_char = '...'
                    })
                },
                enabled = true,
                snippet = {
                    expand = function(args) luasnip.lsp_expand(args.body) end,
                },
                duplicates = {
                    nvim_lsp = 1,
                    luasnip = 1,
                    cmp_tabnine = 1,
                    buffer = 1,
                    path = 1,
                },
                confirm_opts = {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false,
                },
                window = {
                    completion = cmp.config.window.bordered(border_opts),
                    documentation = cmp.config.window.bordered(border_opts),
                },
                mapping = {
                    ["<PageUp>"] = cmp.mapping.select_prev_item {
                        behavior = cmp.SelectBehavior.Select,
                        count = 8,
                    },
                    ["<PageDown>"] = cmp.mapping.select_next_item {
                        behavior = cmp.SelectBehavior.Select,
                        count = 8,
                    },
                    ["<C-PageUp>"] = cmp.mapping.select_prev_item {
                        behavior = cmp.SelectBehavior.Select,
                        count = 16,
                    },
                    ["<C-PageDown>"] = cmp.mapping.select_next_item {
                        behavior = cmp.SelectBehavior.Select,
                        count = 16,
                    },
                    ["<S-PageUp>"] = cmp.mapping.select_prev_item {
                        behavior = cmp.SelectBehavior.Select,
                        count = 16,
                    },
                    ["<S-PageDown>"] = cmp.mapping.select_next_item {
                        behavior = cmp.SelectBehavior.Select,
                        count = 16,
                    },
                    ["<Up>"] = cmp.mapping.select_prev_item {
                        behavior = cmp.SelectBehavior.Select,
                    },
                    ["<Down>"] = cmp.mapping.select_next_item {
                        behavior = cmp.SelectBehavior.Select,
                    },
                    ["<C-p>"] = cmp.mapping.select_prev_item {
                        behavior = cmp.SelectBehavior.Insert,
                    },
                    ["<C-n>"] = cmp.mapping.select_next_item {
                        behavior = cmp.SelectBehavior.Insert,
                    },
                    ["<C-k>"] = cmp.mapping.select_prev_item {
                        behavior = cmp.SelectBehavior.Insert,
                    },
                    ["<C-j>"] = cmp.mapping.select_next_item {
                        behavior = cmp.SelectBehavior.Insert,
                    },
                    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
                    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
                    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                    ["<C-y>"] = cmp.config.disable,
                    ["<C-e>"] = cmp.mapping {
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close(),
                    },
                    ["<CR>"] = cmp.mapping.confirm { select = false },
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                },
                sources = cmp.config.sources {
                    { name = "nvim_lsp", priority = 1000 },
                    { name = "luasnip", priority = 750 },
                    { name = "buffer", priority = 500 },
                    { name = "path", priority = 250 },
                },
            }
        end,
    },
    {
        "L3MON4D3/LuaSnip",
        build = (not jit.os:find("Windows"))
            and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
            or nil,
        dependencies = {
            "rafamadriz/friendly-snippets",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
                require("luasnip").filetype_extend("twig", { "html" })
                require("luasnip").filetype_extend("typescript", { "tsdoc" })
                require("luasnip").filetype_extend("javascript", { "jsdoc" })
                require("luasnip").filetype_extend("php", { "phpdoc" })
            end,
        },
        opts = {
            history = true,
            delete_check_events = "TextChanged",
        },
        -- stylua: ignore
        keys = {
            {
                "<tab>",
                function()
                    return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
                end,
                expr = true, silent = true, mode = "i",
            },
            { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
            { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
        },
    },
}
