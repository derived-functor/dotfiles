return {
  {
    'feakuru/mypy.nvim',
    config = function()
      require('mypy').setup {
        -- additional arguments to pass to invocations of `mypy`
        -- by default, it is called with `--show-error-end --follow-imports=silent`
        extra_args = {
            '--check-untyped-defs',
            -- '--ignore-missing-imports',
            '--verbose'
        },
      }
    end,
  },
}
