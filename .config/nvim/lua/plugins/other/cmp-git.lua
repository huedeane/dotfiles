return {
  {
    "petertriho/cmp-git", -- Completion source for Git commit messages
    enabled = false,
    config = function()
      require("cmp_git").setup()
      require("cmp").setup.filetype("gitcommit", {
        sources = require("cmp").config.sources({
          { name = "git" }, -- Enable Git-related suggestions
        }, {
          { name = "buffer" }, -- Use buffer content as completion source
        }),
      })
    end,
  }
}
