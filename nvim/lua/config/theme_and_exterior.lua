local function get_system_theme()
    local current = vim.fn.expand("~/.config/colors/current")
    local ok, target = pcall(vim.loop.fs_readlink, current)
    if not ok or not target then
        return "gruvbox"
    end
    local name = target:match("([^/]+)%.sh$") or target:match("([^/]+)$")
    return name or "gruvbox"
end

local float_bg = "#434c5e"
local float_fg = "#d8dee9"

vim.api.nvim_set_hl(0, "NormalFloat", { bg = float_bg, fg = float_fg})
vim.api.nvim_set_hl(0, "FloatBorder", { bg = float_bg, fg = float_fg})

vim.diagnostic.config({
    float = {
        border = "single"
    }
})
vim.opt.winborder = "single"

local system_to_nvim = {
    gruvbox = "gruvbox",
    ["catppuccin-mocha"] = "catppuccin-mocha",
    nord = "nord",
}

local system_theme = get_system_theme()
local nvim_colorscheme = system_to_nvim[system_theme] or "gruvbox"

vim.o.background = "dark"
pcall(vim.cmd, "colorscheme " .. nvim_colorscheme)

require("telescope").setup({
    defaults = {
        border = true,
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    }
})

require("cmp").setup({
      window = {
      completion = {
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel",
          border = "single",
      },
      documentation = {
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
          border = "single",
      }
  }
})

-- Other

require("lualine").setup()
require("indentmini").setup()
require('todo-comments').setup{}
