return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp"
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities() -- Enable autocompletion capabilities for LSP

      require("lspconfig").csharp_ls.setup{
        filetypes = { "cs" },
        AutomaticWorkspaceInit = true,
        capabilities = capabilities,
      }
    end,
  }
}
