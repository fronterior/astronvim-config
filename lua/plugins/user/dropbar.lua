return {
  "Bekaboo/dropbar.nvim",
  event = "UIEnter",
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  config = function()
    local dropbar = require "dropbar"
    local dropbar_api = require "dropbar.api"
    local sources = require "dropbar.sources"

    dropbar.setup {
      bar = {
        sources = {
          sources.path,
        },
      },
      menu = {
        entry = {
          padding = {
            left = 1,
            right = 1,
          },
        },
        win_configs = {
          border = "rounded",
        },
      },
    }

    vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Dropbar: pick symbol" })
    vim.keymap.set("n", '<Leader>"', function()
      local bar = require("dropbar.utils.bar").get_current()
      if bar and bar.components and #bar.components > 0 then bar:pick(#bar.components) end
    end, { desc = "Dropbar: open current context" })

    vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Dropbar: go to context start" })
    vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Dropbar: select next context" })
  end,
}
