vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { border = "single" }
)

vim.opt.signcolumn = 'yes'

local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then return end

    vim.lsp.inlay_hint.enable(true, {bufnr = event.buf})

    client.handlers['textDocument/signatureHelp'] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = 'single' }
    )  

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)

    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  end,
})

vim.lsp.config("lua-ls", {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            }
        }
    }
})
vim.lsp.enable("lua-ls")

vim.lsp.config("qmlls", {})
vim.lsp.enable("qmlls")


vim.lsp.config("pyright", {
    capabilities = capabilities,
    settings = {
        python = {
            analysis = {
                inlayHints = {
                    variableTypes = true,
                    functionReturnTypes = true,
                    parameterNames = true,
                }
            }
        }
    }
})
vim.lsp.enable("pyright")

vim.lsp.config('ruff', {
  init_options = {
    settings = {
            configurationPreference = "filesystemFirst",
            inlayHints = {
                enable = true
            },
            lint = {
                enable = true
            },
            capabilities = {
                hoverProvider = false
            }
    }
  }
})

vim.lsp.enable('ruff')

vim.lsp.enable("tinymist")

-- Haskell

vim.lsp.config('haskell-language-server', {
  cmd = { 'haskell-language-server-wrapper', '--lsp' },
  filetypes = { 'haskell', 'lhaskell', 'cabal' },
  root_markers = {
    'hie.yaml',
    'stack.yaml',
    'cabal.project',
    '*.cabal',
    'package.yaml',
  },
  settings = {
    haskell = {
      formattingProvider = "ormolu",
      checkProject = true,
    }
  },
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'haskell', 'lhaskell' },
  callback = function()
    vim.lsp.enable('haskell-language-server')
  end,
})
vim.lsp.enable("haskell-language-server")

vim.lsp.config("clangd", {
    capabilities = capabilities,
})

local cmp = require('cmp')
local cmp_select = {behaviour = cmp.SelectBehavior.Select}
local cmp_mappings = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-Enter>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
})

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  snippet = {
    expand = function(args)
      -- You need Neovim v0.10 to use vim.snippet
      vim.snippet.expand(args.body)
    end,
  },
  mapping = cmp_mappings,
})
