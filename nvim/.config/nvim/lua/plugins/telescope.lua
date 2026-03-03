-- ~/.config/nvim/lua/plugins.lua

return {
    {
        'nvim-telescope/telescope.nvim',
        -- tag = '0.1.8', -- вы можете использовать tag или branch
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('telescope').setup {
                defaults = {
                    hidden = false,
                    file_ignore_patterns = {
                        "__init__%.py$",
                        ".git",
                        ".mypy-cache",
                        "..*cache",
                        ".venv"
                    }
                },
                pickers = {
                    find_files = {
                        hidden = true,
                        no_ignore = true,
                        -- no_ignore_parent = true
                    },
                    live_grep = {
                        additional_args = function()
                            return {"--hidden"}
                        end
                    },
                }
            }

            -- привязка клавиш для вызова telescope
            local function map(mode, lhs, rhs, opts)
                opts = opts or {}
                vim.keymap.set(mode, lhs, rhs, opts)
            end

            local default_params = { noremap = true, silent = true }
            map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', default_params)
            map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', default_params)
            map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', default_params)
            map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', default_params)
            map("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", default_params)
            map("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", default_params)
            map("n", "<leader>gco", "<cmd>Telescope git_bcommits<cr>", default_params)
        end,
    },
}
