-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', '<A-q>', ':bd<CR>')
vim.keymap.set('n', '<tab>', ':bNext<CR>', { silent = true })
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

vim.keymap.set({ 'n', 'x', 'o' }, 'L', '$');
vim.keymap.set({ 'n', 'x', 'o' }, 'H', '^');

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('v', '<C-J>', ':r \'>+1<CR>gv=gv')
vim.keymap.set('v', '<C-K>', ':r \'<-2<CR>gv=gv')
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

vim.keymap.set('n', '<c-w><c-r>', ':%s/<c-r><c-w>//g<left><left>')
vim.keymap.set('n', 'rn', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>')
vim.keymap.set('n', '<leader>_', ':noh<CR>', { silent = true })

vim.keymap.set('n', '<leader>y', '\"+y')
vim.keymap.set('v', '<leader>y', '\"+y')
vim.keymap.set('n', '<leader>Y', 'gg\"+yG')

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)

vim.keymap.set('i', '<c-e>', '<esc>A', {noremap = true})
vim.keymap.set('i', '<c-b>', '<esc>I', {noremap = true})

vim.keymap.set('n', '<F3>', ":Explore<CR>", {silent=true})

vim.keymap.set('v', '<F7>', ':CarbonNow<CR>')

vim.keymap.set('n', '<F8>', ":lua require('util.background').getBackground()<CR>")
vim.keymap.set('n', '<F9>', ":lua require('util.background').changeBackground()<CR>")

vim.keymap.set('n', '<leader>gb', ":Gitsigns toggle_current_line_blame<CR>")
vim.keymap.set('n', '<leader>gp', ":Gitsigns blame_line<CR>")

-- Multiple cursors
vim.cmd([[
    let g:mc = "y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>"

    nnoremap cn *``cgn
    nnoremap cN *``cgN

    vnoremap <expr> cn g:mc . "``cgn"
    vnoremap <expr> cN g:mc . "``cgN"

    function! SetupCR()
      nnoremap <Enter> :nnoremap <lt>Enter> n@z<CR>q:<C-u>let @z=strpart(@z,0,strlen(@z)-1)<CR>n@z
    endfunction

    nnoremap cq :call SetupCR()<CR>*``qz
    nnoremap cQ :call SetupCR()<CR>#``qz

    vnoremap <expr> cq ":\<C-u>call SetupCR()\<CR>" . "gv" . g:mc . "``qz"
    vnoremap <expr> cQ ":\<C-u>call SetupCR()\<CR>" . "gv" . substitute(g:mc, '/', '?', 'g') . "``qz"
]])
