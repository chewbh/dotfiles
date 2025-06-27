set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

lua << EOF
local cmp = require'cmp'

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  })
})

-- Setup LSP
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- For Python
require('lspconfig').pyright.setup{
  capabilities = capabilities,
}

-- For TypeScript (typescript-language-server)
require('lspconfig').ts_ls.setup({
  capabilities = capabilities,
})

-- For Golang
require('lspconfig').gopls.setup({
  capabilities = capabilities,
})

-- For C++ (clangd)
require('lspconfig').clangd.setup({
  capabilities = capabilities,
})

-- For Fortran (fortls)
require('lspconfig').fortls.setup({
  capabilities = capabilities,
})


EOF
