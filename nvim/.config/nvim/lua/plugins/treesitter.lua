-- return {
-- 	"nvim-treesitter/nvim-treesitter",
-- 	build = ":TSUpdate",
-- 	config = function () 
--       require("nvim-treesitter.configs").setup({
--           ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "html", "java", "go", "python" },
--           sync_install = false,
--           highlight = { enable = true },
--           indent = { enable = true },
--         })
--     end
-- }
return {
	"nvim-treesitter/nvim-treesitter",
    lazy = false,
	build = ":TSUpdate",
    opts = {
        ensure_installed = {
            "python",
            "c",
            "vim",
            "lua",
            "vimdoc",
            "yaml",
            "json",
            "toml",
            "markdown",
            "gitignore",
            "dockerfile"
        },
        auto_install = true,
        highlight = {
            enable = true
        }
    },
}
