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

-- Other

require("lualine").setup()
require("indentmini").setup()
require('todo-comments').setup{}
