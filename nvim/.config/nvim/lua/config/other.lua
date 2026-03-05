require("dashboard")

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
      "norg"
  },
  callback = function()
    vim.bo.tabstop   = 2
    vim.bo.shiftwidth = 2
    vim.bo.softtabstop = 2
  end,
})

require("neorg").setup({
    load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {
            config = {
                icon_preset = "diamond",
                conceal = true,
            }
        },
        ["core.dirman"] = {
            config = {
                workspaces = {
                    notes = "~/notes/main",     -- База знаний (Zettelkasten)
                    work = "~/notes/work",      -- Рабочие проекты
                    gtd = "~/notes/gtd",        -- Списки дел и планирование
                },
                default_workspace = "notes",
            }
        }
    },
})
vim.opt.conceallevel = 2
vim.opt.concealcursor = 'nc'

vim.keymap.set("n", "<leader>fo", "<Plug>(neorg.telescope.find_norg_files)")

require("notify").setup{
	top_down = false,
	render = "minimal",
	stages = "fade",
    background_colour = "#000000"
}

require('toggleterm').setup{
}

-- require("render-markdown").setup()

require('leap')
vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap)')
vim.keymap.set('n',             'S', '<Plug>(leap-from-window)')

require("neo-tree").setup({
    window = {
        width = 25,
        position = "right"
    },
    filesystem = {
        filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = false,
        }
    }
})

vim.api.nvim_create_user_command(
    "JsonFormat",
    "%!python -m json.tool --no-ensure-ascii",
    {}
)

--

require("markdown").setup()
