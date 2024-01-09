return {
    {
        "chrisgrieser/nvim-early-retirement",
        config = true,
        event = "VeryLazy",
    },
    {
        "theprimeagen/harpoon",
        branch = "harpoon2",
        event = "VeryLazy",
        config = function ()
            local harpoon = require('harpoon')

            harpoon:setup()
            vim.keymap.set("n", "<leader>ha", function() harpoon:list():append() end)
            vim.keymap.set("n", "<leader>ho", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

            vim.keymap.set("n", "<A-1>", function() harpoon:list():select(1) end)
            vim.keymap.set("n", "<A-2>", function() harpoon:list():select(2) end)
            vim.keymap.set("n", "<A-3>", function() harpoon:list():select(3) end)
            vim.keymap.set("n", "<A-4>", function() harpoon:list():select(4) end)
            vim.keymap.set("n", "<A-5>", function() harpoon:list():select(5) end)
            vim.keymap.set("n", "<A-6>", function() harpoon:list():select(6) end)
            vim.keymap.set("n", "<A-7>", function() harpoon:list():select(7) end)
        end
    },
    {
        "ellisonleao/carbon-now.nvim",
        lazy = true,
        cmd = "CarbonNow",
        opts = { [[ your custom config here ]] }
    },
    {
        "NMAC427/guess-indent.nvim",
        event = "VeryLazy",
        config = function(_, opts)
            require("guess-indent").setup(opts)
            vim.cmd.lua {
                args = { "require('guess-indent').set_from_buffer('auto_cmd')" },
                mods = { silent = true },
            }
        end,
    },
    {
        "cappyzawa/trim.nvim",
        event = "BufWrite",
        opts = {
            -- ft_blocklist = {"typescript"},
            trim_on_write = true,
            trim_trailing = true,
            trim_last_line = false,
            trim_first_line = false,
            -- patterns = {[[%s/\(\n\n\)\n\+/\1/]]}, -- Only one consecutive bl
        },
    },
    {
        "hinell/lsp-timeout.nvim",
        dependencies={ "neovim/nvim-lspconfig" },
        event = "User BaseFile",
        init = function()
            vim.g["lsp-timeout-config"] = {
                stopTimeout = 1000*60*5, -- Stop unused lsp servers after 10 min.
                startTimeout = 2000, -- Force server restart if nvim can't in 2s.
                silent = true -- Notifications disabled
            }
        end
    },

}
