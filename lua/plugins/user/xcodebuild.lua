return {
  "wojciech-kulik/xcodebuild.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-tree.lua", -- optional
    "stevearc/oil.nvim", -- optional
    "nvim-treesitter/nvim-treesitter", -- optional
  },
  config = function() require("xcodebuild").setup {} end,
}