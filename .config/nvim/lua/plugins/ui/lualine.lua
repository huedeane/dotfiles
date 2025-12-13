-- Status line plugin for Neovim, that replaces and enhance the default status line at the bottom of Neovim
return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'catppuccin/nvim' },
    opts = function()
      local catppuccin = require("lualine.themes.catppuccin")
      
      catppuccin.normal.a.bg = "#BABBF1"
      catppuccin.normal.a.fg = "#303446"
      catppuccin.normal.b.fg = "#BABBF1"
      catppuccin.normal.c.bg = "#303446"
      -- catppuccin.terminal.a.fg = "#FF0000"
      -- catppuccin.terminal.b.fg = "#FF0000"
      -- catppuccin.inactive.a.fg = "#FF0000"
      -- catppuccin.inactive.b.fg = "#FF0000"

      return {
        theme = catppuccin
      }
    end,
    config = function(_, opts)
      require("lualine").setup({
        options = {
          theme = opts.theme,
          icons_enabled = true,
          component_separators = "",
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = {
            { "mode", separator = { left = "" }, bg="#ff0000", fg="ff0000" },
          },
          lualine_b = { "filename", "branch" },
          lualine_c = {
            "%=", -- center components go here
          },
          lualine_x = {},
          lualine_y = { "filetype", "progress" },
          lualine_z = {
            { "location", separator = { right = "" }, left_padding = 2 },
          },
        },
        inactive_sections = {
          lualine_a = { "filename" },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { "location" },
        },
        tabline = {},
        extensions = {},
      })
    end,
}
