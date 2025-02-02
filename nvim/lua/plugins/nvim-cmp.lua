return {
  -- Completion Engine and Sources
  {
    "hrsh7th/nvim-cmp", -- Main completion engine
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- Completion source for LSP
      "hrsh7th/cmp-buffer", -- Completion source for words in the open buffer
      "hrsh7th/cmp-path", -- Completion source for file system paths
      "hrsh7th/cmp-cmdline", -- Completion source for command-line mode
      
      -- Uncomment if using other snippet engines
      -- For vsnip users
        -- "hrsh7th/cmp-vsnip", -- Completion source for VSnip snippets
        -- "hrsh7th/vim-vsnip", -- Snippet engine for Vim script-based snippets
      -- For luasnip users.
        -- "L3MON4D3/LuaSnip", -- Lua-based snippet engine
        -- "saadparwaiz1/cmp_luasnip", -- Completion source for LuaSnip
      -- For mini.snippets users.
        -- "echasnovski/mini.snippets", -- Lightweight snippet engine
        -- "abeldekat/cmp-mini-snippets", -- Completion source for mini.snippets
      -- For ultisnips users.
        -- "SirVer/ultisnips", -- UltiSnips snippet engine
        -- "quangnguyen30192/cmp-nvim-ultisnips", -- Completion source for UltiSnips
      -- For snippy users
        -- "dcampos/nvim-snippy", -- Snippy snippet engine
        -- "dcampos/cmp-snippy", -- Completion source for Snippy
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        snippet = {
          expand = function(args)
                -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        	-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        	-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        	-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        	-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4), -- Scroll completion documentation up
          ["<C-f>"] = cmp.mapping.scroll_docs(4), -- Scroll completion documentation down
          ["<C-Space>"] = cmp.mapping.complete(), -- Manually trigger completion menu
          ["<C-e>"] = cmp.mapping.abort(), -- Close the completion menu
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection (auto-select if none is chosen)
        }),
        sources = cmp.config.sources({
           { name = "nvim_lsp" }, -- Use LSP as a completion source
           -- { name = 'vsnip' }, -- For vsnip users.
      	   -- { name = 'luasnip' }, -- For luasnip users.
           -- { name = 'ultisnips' }, -- For ultisnips users.
           -- { name = 'snippy' }, -- For snippy users.
        }, {
          { name = "buffer" }, -- Use words from the buffer as completion suggestions
        }),
      })

      -- Enable command-line completion for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" }, -- Use buffer words for searching
        },
      })

      -- Enable command-line completion for `:` (commands) (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" }, -- Enable path completion in the command line
        }, {
          { name = "cmdline" }, -- Enable command completion
        }),
        matching = { disallow_symbol_nonprefix_matching = false }, -- Allow flexible matching
      })
    end,
  },
}

