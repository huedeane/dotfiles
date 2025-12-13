--A fast and fully customizable Neovim startup dashboard with support for headers, buttons, footers, and dynamic content
return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  opts = function()
    local dashboard = require("alpha.themes.dashboard")
    local colors = require("catppuccin.palettes").get_palette()

    --Configure header
    dashboard.section.header.val = {
      "                                                     ", 
      "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ", 
      "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ", 
      "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ", 
      "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ", 
      "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ", 
      "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ", 
      "                                                     ", 
    }

    -- Configure dashboard buttons
    dashboard.section.buttons.val = {
      dashboard.button("f", " " .. " Find file",     "<cmd>lua require('telescope.builtin').find_files()<cr>"),
      dashboard.button("n", " " .. " New file",      [[<cmd>ene <BAR> startinsert<cr>]]),
      dashboard.button("r", " " .. " Recent files",  [[<cmd>lua require('telescope.builtin').oldfiles()<cr>]]),
      dashboard.button("q", " " .. " Quit",          "<cmd>qa<cr>"),
    }

    -- Override header color
    vim.api.nvim_set_hl(0, "AlphaHeader",  { fg = colors.lavender, bold = true })

    -- Apply highlights to buttons, header, and footer
    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
    end
    dashboard.section.header.opts.hl = "AlphaHeader"
    dashboard.section.footer.opts.hl = "AlphaFooter"
    
    -- Setup layout
    dashboard.opts.layout = {
      { type = "padding", val = 8 },
      dashboard.section.header,
      { type = "padding", val = 2 },
      dashboard.section.buttons,
      { type = "padding", val = 2 },
      dashboard.section.footer,
    }

    --Modify margin
    dashboard.opts.margin = 5

    return {
      dashboard = dashboard
    }
  end,
  config = function(_, opts)
    local alpha = require("alpha")


    -- Close lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        once = true,
        pattern = "AlphaReady",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    -- Setup dashboard
    alpha.setup(opts.dashboard.opts)
    
    -- Calculate plugin stats and redraw the footer with it
    vim.api.nvim_create_autocmd("User", {
      once = true,
      pattern = "AlphaReady",
      callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        opts.dashboard.section.footer.val = "⚡ Neovim loaded "
          .. stats.loaded
          .. "/"
          .. stats.count
          .. " plugins in "
          .. ms
          .. "ms"
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}
