-- Google Python Style Guide
vim.cmd("source ~/.config/nvim/google.vim")

-- TreeSitter
require("nvim-treesitter").install({"python", "markdown", "lua", "xml"})
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "python" },
    callback = function() vim.treesitter.start() end,
})

-- Formatters
require("conform").setup({
  formatters_by_ft = {
    -- python = { "isort", "black" },
    python = { "ruff_format", "ruff_fix", "ruff_organize_imports" },
    markdown = { "prettier", "injected" },
  },
    formatters = {
        injected = {
            -- Опции для форматирования вложенного кода
            options = {
                ignore_errors = true,
                -- Можно переопределить форматировщики для конкретных языков внутри MD
                lang_to_formatters = {
                    json = { "jq" },
                },
            },
        },
    },
    format_on_save = {}
})
vim.api.nvim_create_user_command(
    "PythonFormat",
    function()
        require("conform").format({ bufnr = vim.api.nvim_get_current_buf() })
    end, {}
)

-- Linter
require("lint").linters_by_ft = {
    python = {"ruff"}
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback=function()
        require("lint").try_lint()
    end,
})

require("mypy").setup()

-- Debug
local dap = require('dap')
vim.keymap.set("n", "<leader>Db", dap.toggle_breakpoint, { desc = "Поставить/убрать точку останова" })
vim.keymap.set("n", "<leader>Dc", dap.continue, { desc = "Запустить/продолжить отладку" })
vim.keymap.set('n', '<leader>Dr', function() dap.repl.open() end)
vim.keymap.set("n", "<leader>Ds", dap.step_over, { desc = "Шаг через (step over)" })
vim.keymap.set("n", "<leader>Di", dap.step_into, { desc = "Шаг внутрь (step into)" })
vim.keymap.set("n", "<leader>Do", dap.step_out, { desc = "Шаг наружу (step out)" })

vim.keymap.set("n", "K", function()
    require("dap.ui.widgets").hover()
end, { desc = "Показать значение переменной" }
)

dap.configurations.python = {
  {
    type = 'debugpy';
    justMyCode = false,
    request = 'launch';
    name = "Launch file";
    program = "${file}";
    pythonPath = function()
        return vim.fn.getcwd() .. "/.venv/bin/python"
    end;
  },
}

-- Pytest
-- require("pytest").setup{
--     add_args = "-s"
-- }
vim.keymap.set('n', '<leader>pr', function()
  local file = vim.fn.expand('%')
  vim.cmd('TermExec cmd="uv run ' .. file .. '"')
end, { desc = "Run Python file" })
