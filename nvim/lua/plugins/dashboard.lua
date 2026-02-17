return {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
        local plugins = require("lazy").stats().count
        require('dashboard').setup {
            -- config
            theme = "doom",
            config = {
                header = {
                    " _   _                 _           ",
                    "| \\ | |                _           ",
                    "|  \\| | ___  _____   ___ _ __ ___  ",
                    "| . ` |/ _ \\/ _ \\ \\ / / | '_ ` _ \\ ",
                    "| |\\  |  __/  _  \\ V /| | | | | | |",
                    "\\_| \\_/\\___|\\___/ \\_/ |_|_| |_| |_|",
                    "",
                    "ℝ[x] / (x² + 1) ≅ ℂ", ""
                },
                center = {
                    {
                        icon = '  ',
                        desc = 'Recently opened files    ',
                        action = 'Telescope oldfiles',
                        key = 's',
                    },
                    {
                        icon = '󰭎  ',
                        desc = 'Find  File    ',
                        action = 'Telescope find_files',
                        key = 'f',
                    },
                    {
                        icon = '  ',
                        desc = 'File Browser    ',
                        action = 'Neotree',
                        key = 'e',
                    },
                    {
                        icon = '  ',
                        desc = 'Find  word    ',
                        action = 'Telescope live_grep',
                        key = 'b',
                    },
                    {
                        icon = "  ",
                        desc = "Open Neogit",
                        action = "Neogit",
                        key = "N"
                    }
                },
                footer = { '', 'NeoVim loaded ' .. plugins .. ' packages' },
                vertical_center = true,
            }
        }
    end,
    dependencies = { {'nvim-tree/nvim-web-devicons'}}
}
