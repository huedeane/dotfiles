return {
 {
   "nvim-tree/nvim-tree.lua",
   dependencies = {
     "nvim-tree/nvim-web-devicons", -- Optional: Icons for file types
   },
   config = function()
     require("nvim-tree").setup({
       view = {
         width = 30, -- Set width of the tree panel
         side = "left", -- Tree position
       },
       renderer = {
         icons = {
           glyphs = {
             folder = {
               arrow_closed = "",
               arrow_open = "",
             },
           },
         },
       },
       filters = {
         dotfiles = false, -- Show dotfiles
       },
       git = {
         enable = true, -- Show git status
       },
     })
    -- Keybinding to toggle nvim-tree
    vim.keymap.set("n", "<Leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })
    end
  }
}
