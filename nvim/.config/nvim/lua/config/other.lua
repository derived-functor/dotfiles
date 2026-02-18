require("dashboard")

require("notify").setup{
	top_down = false,
	render = "minimal",
	stages = "fade",
    background_colour = "#000000"
}

require('toggleterm').setup{
}

require('leap')
vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap)')
vim.keymap.set('n',             'S', '<Plug>(leap-from-window)')

require("neo-tree").setup({
	window = {
		width = 25,
		position = "right"
	}
})

vim.api.nvim_create_user_command(
    "JsonFormat",
    "%!python -m json.tool --no-ensure-ascii",
    {}
)

--

require("markdown").setup()
