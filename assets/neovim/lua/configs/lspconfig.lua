require("nvchad.configs.lspconfig").defaults()

local servers = { "clangd", "hls", "omnisharp", "nixd", "nixfmt" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
