local function get_system_theme()
    local current = vim.fn.expand("~/.config/colors/current")
    local ok, target = pcall(vim.loop.fs_readlink, current)
    if not ok or not target then
        return "gruvbox"
    end
    local name = target:match("([^/]+)%.sh$") or target:match("([^/]+)$")
    return name or "gruvbox"
end

local system_to_nvim = {
    gruvbox = "gruvbox",
    ["catppuccin-mocha"] = "catppuccin-mocha",
    nord = "nord",
}

local system_theme = get_system_theme()
local nvim_colorscheme = system_to_nvim[system_theme] or "gruvbox"

vim.o.background = "dark"
pcall(vim.cmd, "colorscheme " .. nvim_colorscheme)

-- VS Code theme
local c = require('vscode.colors').get_colors()
require('vscode').setup({
    italic_comments = true,
    italic_inlayhints = true,
    underline_links = true,
    disable_nvimtree_bg = true,
    terminal_colors = true,
    color_overrides = {
        vscLineNumber = '#FFFFFF',
    },
    group_overrides = {
        -- this supports the same val table as vim.api.nvim_set_hl
        -- use colors from this colorscheme by requiring vscode.colors!
        Cursor = { fg=c.vscDarkBlue, bg=c.vscLightGreen, bold=true },
    }
})
-- require('vscode').load()

-- Other

require("lualine").setup()
require("indentmini").setup()
require('todo-comments').setup{}
