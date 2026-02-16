-- Numbered lines
vim.cmd.set("number")
vim.cmd.set("relativenumber")

-- Tabulation
vim.cmd.set("tabstop=4")
vim.cmd.set("shiftwidth=4")

-- Clipboard
vim.cmd.set("clipboard^=unnamed")
vim.cmd.set("clipboard^=unnamedplus")

vim.cmd.set("expandtab")

vim.g.mapleader = " "
-- Save file
vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', { noremap = true, silent = true })

-- Close file
vim.api.nvim_set_keymap('n', '<leader>q', ':q<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "<leader>wq", ":wq<CR>", {noremap = true, silent = true})

-- Neotree
vim.api.nvim_set_keymap('n', '<leader>e', ':Neotree<CR>', { noremap = true, silent = true })

vim.keymap.set("n", "<leader>d", function()
    vim.diagnostic.open_float(nil, {focus = false})
end, {desc = "Show diagnostic"})

vim.keymap.set("n", "<leader>bd", ":bd<CR>", {noremap = true, silent = true})
