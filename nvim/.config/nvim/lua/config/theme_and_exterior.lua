local function get_system_theme()
    local current = vim.fn.expand("~/.config/colors/current")
    local ok, target = pcall(vim.loop.fs_readlink, current)
    if not ok or not target then
        return "gruvbox"
    end
    local name = target:match("([^/]+)%.sh$") or target:match("([^/]+)$")
    return name or "gruvbox"
end

-- local float_bg = "#434c5e"
local float_fg = "#d8dee9"
local function set_telescope_transparency()
    local float_bg = "none"
    local float_fg = "none"



    local groups = {
        "NormalFloat", "FloatBorder",
        "TelescopeNormal", "TelescopeBorder",
        "TelescopePromptNormal", "TelescopeResultsNormal", "TelescopePreviewNormal",
        "TelescopePromptBorder", "TelescopeResultsBorder", "TelescopePreviewBorder",
        "TelescopePromptTitle", "TelescopeResultsTitle", "TelescopePreviewTitle",
      }

  for _, group in ipairs(groups) do
    vim.api.nvim_set_hl(0, group, { bg = bg, fg = fg })
  end
end

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

require("catppuccin").setup({
    transparent_background = true,
    custom_highlights = function(colors)
        return {
            LineNr = { fg = colors.flamingo },
            CursorLineNr = { fg = colors.pink, style = { "bold" } },
            LineNrAbove = { fg = colors.surface2 },
            LineNrBelow = { fg = colors.surface2 },
        }
    end,
})

vim.o.background = "dark"
-- pcall(vim.cmd, "colorscheme " .. nvim_colorscheme)
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = set_telescope_transparency
})

vim.cmd("colorscheme " .. nvim_colorscheme)

set_telescope_transparency()

require("telescope").setup({
    defaults = {
        border = true,
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        layout_strategy = "vertical",
        winblend = 0,
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
-- require("indentmini").setup()
require("mini.indentscope").setup({
    symbol = "|",
    options = {
        try_as_border = true
    },
    draw = {
        delay = 65,
        animation = function(s, n)
            return 12
        end
    }
})
require('todo-comments').setup{}
