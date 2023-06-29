return {
    'nvim-telescope/telescope.nvim',
    cmd = "Telescope",
    version = false,
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-telescope/telescope-file-browser.nvim' },
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            cond = function()
                return vim.fn.executable 'make' == 1
            end,
        },
    },
    config = function()
        require('telescope').setup {
            extensions = {
                file_browser = {
                    path = "%:p:h",
                    initial_mode = "normal",
                }
            },
            defaults = {
                mappings = {
                    i = {
                        ['<C-u>'] = false,
                        ['<C-d>'] = false,
                    }
                },
                path_display = {"truncate"},
            },
            pickers = {
                find_files = {
                    hidden = true,
                    theme = "ivy",
                    follow = true,
                    previewer = false
                },
                grep_string = {
                    additional_args = {"--no-ignore-vcs", "-F", "-Tmarkdown"},
                }
            },
        }
        local telescope = require("telescope");
        telescope.load_extension 'fzf'
        telescope.load_extension 'file_browser'
        -- telescope.load_extension 'send_to_harpoon'
    end
}
