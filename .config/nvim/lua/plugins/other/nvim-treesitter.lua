return {
  {
    "nvim-treesitter/nvim-treesitter",  -- Specify the plugin
    run = ":TSUpdate",  -- Ensure parsers are installed automatically
    dependencies = {
      "nvim-treesitter/nvim-treesitter-refactor",  -- Optional: refactoring support
    },
    config = function()
      require("nvim-treesitter.configs").setup{
        ensure_installed = "all",  -- Install parsers for all supported languages
        highlight = {
          enable = true,  -- Enable syntax highlighting
          additional_vim_regex_highlighting = false,  -- Disable Vim regex highlighting (optional)
        },
        indent = { enable = true },  -- Enable Tree-sitter-based indentation
        refactor = {
          highlight_definitions = { enable = true },  -- Highlight function definitions (optional)
        },
      }
    end,
  }
}

