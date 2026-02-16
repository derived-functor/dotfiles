return {
  {
    "mfussenegger/nvim-dap", -- Основной плагин для отладки
    dependencies = {
      -- Пользовательский интерфейс для отладки
      "rcarriga/nvim-dap-ui",
      -- Отображение значений переменных прямо в коде
      "theHamsta/nvim-dap-virtual-text",
      -- Автоматическая установка и управление отладчиками через Mason
      "jay-babu/mason-nvim-dap.nvim",
      -- Адаптер для отладки Python (использует debugpy)
      "mfussenegger/nvim-dap-python",
    },
    config = function()
            local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
            require("dap-python").setup(path)
        end
  },
}
