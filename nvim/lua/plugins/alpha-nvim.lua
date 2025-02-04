return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  enabled = true,
  init = false,
  opts = function()
    local dashboard = require("alpha.themes.dashboard")
    local logo = [[
                                                         
      ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ 
      ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ 
      ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ 
      ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ 
      ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ 
      ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ 
                                                         
    ]]

    dashboard.section.header.val = vim.split(logo, "\n")

    -- Configure dashboard buttons
    dashboard.section.buttons.val = {
      dashboard.button("f", " " .. " Find file",     "<cmd>lua require('telescope.builtin').find_files()<cr>"),
      dashboard.button("n", " " .. " New file",      [[<cmd>ene <BAR> startinsert<cr>]]),
      dashboard.button("r", " " .. " Recent files",  [[<cmd>lua require('telescope.builtin').oldfiles()<cr>]]),
      dashboard.button("q", " " .. " Quit",          "<cmd>qa<cr>"),
    }

    -- Apply highlights to buttons and header
    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
    end
    dashboard.section.header.opts.hl = "AlphaHeader"
    dashboard.section.buttons.opts.hl = "AlphaButtons"
    dashboard.section.footer.opts.hl = "AlphaFooter"
    
    -- Set layout
    dashboard.opts.layout[1].val = 8
    return dashboard
  end,
  config = function(_, dashboard)
    -- close Lazy and re-open when the dashboard is ready
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

    require("alpha").setup(dashboard.opts)

    vim.api.nvim_create_autocmd("User", {
      once = true,
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        dashboard.section.footer.val = "⚡ Neovim loaded "
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
