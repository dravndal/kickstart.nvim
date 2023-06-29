return {
    {
        'rebelot/kanagawa.nvim',
        lazy = false,
        priority = 1000,
        config = function() 
            require('kanagawa').setup({
                statementStyle = { bold = true },
                typeStyle = {},
                transparent = true,        -- do not set background color
                dimInactive = false,        -- dim inactive window `:h hl-NormalNC`
                globalStatus = false,       -- adjust window separators highlight for laststatus=3
                terminalColors = true,      -- define vim.g.terminal_color_{0,17}
                colors = {
                  theme = {
                all = {
                  ui = {
                    bg_gutter = "none",
                  }
                }
                  }
                },
                overrides = function(colors)
                  local theme = colors.theme
                  return {
                  NormalFloat = { bg = "none" },
                  FloatBorder = { bg = "none" },
                  FloatTitle = { bg = "none" },
                  TelescopeNormal = { bg = "#1c1c1c" },
                  TelescopeBorder = { bg = "#1c1c1c" },
                  TelescopePromptNormal = { bg = "#1c1c1c" },
                  TelescopePromptBorder = { bg = "#1c1c1c" },
                  TelescopeMatching = { bg = "#7E9CD8" },
                  TelescopeSelection = { bg = "#FF9E3B" },

                  ['@method'] = { fg = "#FF9E3B"},
                  ['@keyword.function'] = { fg = "#7E9CD8"},
                  ['@variable'] = { fg = "#9CABCA"},
                  ['@constructor'] = { fg = "#DCA561"},
                  ['Visual'] = { bg = "#6A9589"},
                  ['SagaShadow'] = { bg = nil},
                  }
                end,
                theme = "default"
            })
            vim.cmd([[colorscheme kanagawa-dragon]])
        end
    },
    {
        'NvChad/nvim-colorizer.lua',
        ft = { "scss", "css", "html" },
    }
}
