--- Global Settings ---

vim.g.editorconfig = true  -- Enable editorconfig integration

--- General Settings ---

-- Line
vim.opt.number = true	              -- Show absolute line number
vim.opt.fillchars = { eob = " " }   -- Change empty line ~ to ""
vim.opt.ruler = true                -- Show the current line and column in the status line

--Indentation
vim.opt.tabstop = 2                 -- Number of spaces in a tab
vim.opt.shiftwidth = 2              -- Number of spaces to use for each indentation level
vim.opt.expandtab = true            -- Use spaces instead of tabs
vim.opt.smartindent = true          -- Enable smart indentation
vim.opt.smarttab = true             -- Smart tabbing
vim.opt.autoindent = true           -- Auto indent new lines
vim.opt.softtabstop = 2             -- Number of spaces per tab while editing, for backspacing and inserting

-- Search settings
vim.opt.ignorecase = true           -- Ignore case in searches
vim.opt.smartcase = true            -- Override ignorecase when searching with mixed case
vim.opt.hlsearch = true             -- Highlight search results (matches)

-- Show matching parentheses
vim.opt.showmatch = true            -- Highlight matching parentheses, brackets, or braces
vim.opt.matchtime = 2               -- Time (in tenths of a second) for which matching parentheses stay highlighted

-- Enable clipboard support
vim.opt.clipboard = "unnamedplus"   -- Use the system clipboard for copy/paste operations

-- Mouse support
vim.opt.mouse = "a"                 -- Enable mouse support in all modes (insert, normal, etc.)

-- Keys
vim.g.maploader = " "
