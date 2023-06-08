--[[
  File: mason.lua
  Description: Mason plugin configuration (with lspconfig)
  See: https://github.com/williamboman/mason.nvim
]]

local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")

mason.setup()
mason_lspconfig.setup({
  ensure_installed = {
    "lua_ls",             -- LSP for Lua language
    "tsserver",           -- LSP for Typescript and Javascript
    "rust_analyzer",      -- LSP for Rust
    "cssls",              -- LSP for CSS
    "stylelint_lsp",      -- Linter for CSS, Sass, Less
    "dockerls",           -- LSP for Docker
    "pyright",            -- LSP for Python
    "volar"               -- LSP for Vue
  }
});

-- Setup every needed language server in lspconfig
mason_lspconfig.setup_handlers {
  function (server_name)
    lspconfig[server_name].setup {}
  end,

  ["rust_analyzer"] = function ()
    require("rust-tools").setup {}
  end,

  ["volar"] = function ()
    lspconfig.volar.setup {
      filetypes = { "vue", "json" }
    }
  end,
}

