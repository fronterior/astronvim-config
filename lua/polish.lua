-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

vim.keymap.set("n", "<F1>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })

vim.keymap.set("n", "<F2>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })

vim.api.nvim_create_user_command("F", function()
  local rel_path = vim.fn.expand "%"
  vim.fn.setreg("+", rel_path)
  print("Copied: " .. rel_path)
end, {})
