local keymap = require('kevin.keymap')
local inoremap = keymap.inoremap
local nnoremap = keymap.nnoremap
local telescopeBuiltinOk, telescopeBuiltin = pcall(require, 'telescope.builtin')
if not telescopeBuiltinOk then
    return
end

nnoremap('<leader>sf', telescopeBuiltin.find_files, { desc = '[S]earch [F]iles' })
nnoremap('<leader>sg', telescopeBuiltin.live_grep, { desc = '[S]earch by [G]rep' })
nnoremap('<leader>sb', telescopeBuiltin.buffers, { desc = '[S]earch by [B]uffers' })
nnoremap('<leader>ts', telescopeBuiltin.builtin, { desc = '[T]elescope [S]cope' })
nnoremap('<leader>tsr', telescopeBuiltin.resume, { desc = '[T]elescope [S]cope [R]esume' })

nnoremap('<C-S><C-S>', ':set invrelativenumber<CR>')
nnoremap('<C-s>', ':w<CR>')
inoremap('<C-s>', '<Esc>:w<CR>a')
inoremap('<C-c>', '<Esc>')

nnoremap('<C-n>', ':NvimTreeToggle<CR>')
nnoremap('<leader>r', ':NvimTreeFindFile<CR>')
nnoremap('<leader>g', ':Git<CR>')

nnoremap('<C-j>', '<C-w>j')
nnoremap('<C-h>', '<C-w>h')
nnoremap('<C-k>', '<C-w>k')
nnoremap('<C-l>', '<C-w>l')

nnoremap('<C-p>', '"0p') -- paste in
nnoremap('<C-P>', '"0P') -- paste in

nnoremap('<leader>gt', ':BufferLineCycleNext<CR>', { desc = 'go to next buffer' })
nnoremap('<leader>Gt', ':BufferLineCyclePrev<CR>', { desc = 'go to previous buffer' })

nnoremap('=', '<cmd>vertical resize +5<cr>') -- make the window biger vertically
nnoremap('-', '<cmd>vertical resize -5<cr>') -- make the window smaller vertically
nnoremap('+', '<cmd>horizontal resize +2<cr>') -- make the window bigger horizontally by pressing shift and =
nnoremap('_', '<cmd>horizontal resize -2<cr>') -- make the window smaller horizontally by pressing shift and -

local oil_ok, oil = pcall(require, 'oil')
if not oil_ok then
    return
end

nnoremap('<leader>o', oil.open, { desc = 'Open parent directory' })
