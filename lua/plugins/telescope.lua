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
    keys = {
        { "<leader>?", "<cmd>Telescope oldfiles<CR>", "n", desc = "[?] Find recently opened files" },
        { "<leader>fb", "<cmd>Telescope file_browser<CR>", "n", desc = "[fb] Open the filebrowser" },
        { "<leader>gr", "<cmd>Telescope lsp_references<CR>", "n", desc = "[gr] Lsp references" },
        { "<leader>gd", "<cmd>Telescope lsp_definitions<CR>", "n", desc = "[gd] Lsp definitions" },
        { "<leader>so", "<cmd>Telescope lsp_document_symbols<CR>", "n", desc = "[so] Lsp symbols" },
        { "<leader>ws", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", "n", desc = "[ws] Lsp workspace symbols" },
        { "<leader>l", "<cmd>Telescope buffers<CR>", "n", desc = "[l] Open list of buffers" },
        { "/", function ()
            require("telescope.builtin").current_buffer_fuzzy_find({
                previewer = false,
            })
        end, "n", desc = "[/] Current buffer fuzzy find" },
        { "<leader>sc", function ()
            require("telescope.builtin").live_grep({
                winblend = 10,
                search_dirs = {".","/home/danielravndal/work-projects/corepublish/"},
                additional_args = {"--no-ignore-vcs", "-F", "-Tmarkdown"},
            })
        end, "n", desc = "[sc] Fuzzysearch with library" },
        { "<leader><leader>", "<cmd>Telescope find_files<CR>", "n", desc = "[][] Find files" },
        { "<leader>cp", function ()
            require('telescope.builtin').find_files({
                winblend = 10,
                search_dirs = {".","/home/danielravndal/work-projects/corepublish/"},
                additional_args = {"--no-ignore-vcs", "-F", "-Tmarkdown"},
                hidden = true
            })
        end, "n", desc = "[cp] find library files" },
        { "<leader>hh", "<cmd>Telescope help_tags<CR>", "n", desc = "[][] Find files" },
        { "<leader>w", "<cmd>Telescope grep_string<CR>", "n", desc = "[][] Find files" },
        { "<leader>sf", "<cmd>Telescope live_grep<CR>", "n", desc = "[][] Find files" },
        { "<leader>sd", "<cmd>Telescope diagnostics<CR>", "n", desc = "[][] Find files" },
    },
    config = function()
        local telescope = require("telescope");
        telescope.setup {
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
        telescope.load_extension 'fzf'
        telescope.load_extension 'file_browser'
        -- telescope.load_extension 'send_to_harpoon'
    end
}
