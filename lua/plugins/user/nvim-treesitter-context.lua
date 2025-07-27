return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "User AstroFile",
  cmd = { "TSContext" },
  init = function()
    -- 하이라이트 설정은 init에서 하면 opts보다 먼저 실행됨
    vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#0a0a0a" })
  end,
  opts = {
    max_lines = 1,
  },
  dependencies = {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<Leader>ux"] = {
            "<cmd>TSContext toggle<CR>",
            desc = "Toggle treesitter context",
          },
        },
      },
    },
  },
}