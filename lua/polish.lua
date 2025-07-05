-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

vim.keymap.set("n", "<F1>", function() require("astrocore.buffer").nav(-vim.v.count1) end, { desc = "Previous buffer" })

vim.keymap.set("n", "<F2>", function() require("astrocore.buffer").nav(vim.v.count1) end, { desc = "Next buffer" })
