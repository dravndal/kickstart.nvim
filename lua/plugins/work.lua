return {
    {
        "dravndal/vim-arsync",
        event = "BufRead",
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "BufRead",
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                untrackted = { text = '' },
            },
            attach_to_untracked = false,
            current_line_blame = true,
            current_line_blame_opts = {
                virt_text_pos = "right_align",
                delay = 10
            },
            current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d>'
        }
    }
}
