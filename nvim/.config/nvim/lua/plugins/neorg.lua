return {
    "nvim-neorg/neorg",
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = "*", -- Pin Neorg to the latest stable release
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "3rd/image.nvim" },
        { "nvim-neorg/neorg-telescope" },
    },
    config = function()
        require("neorg").setup({
            load = {
                ["core.defaults"] = {},
                ["core.concealer"] = {},
                ["core.dirman"] = {
                    config = {
                        workspaces = {
                            notes = "~/notes/home",
                            work = "~/notes/work",
                            gtd = "~/notes/gtd",
                        },
                        default_workspace = "notes"
                    }
                },
                ["core.integrations.image"] = {},
                ["core.latex.renderer"] = {
                    config = {
                        conceal = true,
                        dpi = 350,
                        render_on_enter = false,
                        debounce_ms = 200,
                        min_length = 3,
                    }
                },
                ["core.integrations.telescope"] = {},
                [ "core.journal" ] = {
                    config = {
                        strategy = "flat",
                    },
                },
            }
        })
    end,
}
