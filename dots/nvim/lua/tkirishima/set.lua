local vim = vim;

vim.g.mapleader = " "

-- Line
vim.opt.nu = true
vim.opt.relativenumber = true

-- Tab size
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.cmd([[
    :set shiftwidth=4
    :set autoindent
    :set smartindent
]])

vim.cmd([[
    augroup MyIndentSettings
        autocmd!
        autocmd FileType scss,javascript.jsx,tsx,jsx setlocal tabstop=4 shiftwidth=4
    augroup END
]])


vim.cmd([[
    augroup MyIndentSettings2
        autocmd!
        autocmd BufRead * setlocal shiftwidth=4
    augroup END
]])


-- Indent
vim.opt.smartindent = true

-- Scroll 
vim.opt.scrolloff = 6


-- Move line
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Substitute
vim.keymap.set("n", "<leader>gs", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make a file executable
vim.keymap.set("n", "<leader>x", ":!chmod +x % && echo ehe<CR>")


-- Switch between files
--vim.keymap.set('n', '<C-i>', ':tabnext<CR>', { noremap = true })
--vim.keymap.set('n', '<C-S-i>', ':tabprevious<CR>', { noremap = true })

-- Tab
vim.keymap.set('v', '<Tab>', '>gv', { noremap = true })
vim.keymap.set('v', '<S-Tab>', '<gv', { noremap = true })

-- Undo
vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>")

-- Remap Ctrl+U and Ctrl+D
vim.keymap.set('n', '<C-U>', '<C-U>zz', { noremap = true, silent = true })
vim.keymap.set('n', '<C-D>', '<C-D>zz', { noremap = true, silent = true })


-- Git
---- Preview changes
vim.keymap.set('n', '<leader>hp', ':Gitsigns preview_hunk<CR>', { noremap = true, silent = true })
---- Reset changes
vim.keymap.set('n', '<leader>hr', ':Gitsigns reset_hunk<CR>', { noremap = true, silent = true })
