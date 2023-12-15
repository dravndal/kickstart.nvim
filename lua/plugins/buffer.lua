return {
    {
        "chrisgrieser/nvim-early-retirement",
        config = true,
        event = "VeryLazy",
    },
    {
        "theprimeagen/harpoon",
        event = "VeryLazy"
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
        "folke/zen-mode.nvim",
        cmd = "ZenMode",
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
