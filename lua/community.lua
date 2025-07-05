-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  -- import/override with your plugins folder
  {
    import = "astrocommunity.pack.typescript-all-in-one",
    opts = {
      dap = false,
    },
  },
  -- { import = "astrocommunity.pack.swift" },
  {
    import = "astrocommunity.colorscheme.citruszest-nvim",
  },
  { import = "astrocommunity.colorscheme.bluloco-nvim" },
  { import = "astrocommunity.completion.avante-nvim" },
  { import = "astrocommunity.colorscheme.cyberdream-nvim" },
  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
  { import = "astrocommunity.utility.noice-nvim" },
  { import = "astrocommunity.indent.indent-rainbowline" },
  { import = "astrocommunity.scrolling.nvim-scrollbar" },
  { import = "astrocommunity.completion.codeium-nvim" },
  { import = "astrocommunity.color.transparent-nvim" },
  { import = "astrocommunity.git.diffview-nvim" },
  { import = "astrocommunity.colorscheme.fluoromachine-nvim" },
  { import = "astrocommunity.motion.flash-nvim" },
  { import = "astrocommunity.motion.harpoon" },
  { import = "astrocommunity.motion.before-nvim" },
  { import = "astrocommunity.motion.mini-surround" },
  { import = "astrocommunity.git.octo-nvim" },
  { import = "astrocommunity.git.git-blame-nvim" },
  { import = "astrocommunity.editing-support.vim-visual-multi" },
  -- { import = "astrocommunity.completion.magazine-nvim" },
  { import = "astrocommunity.debugging.nvim-chainsaw" },
  { import = "astrocommunity.editing-support.vim-move" },
  { import = "astrocommunity.bars-and-lines.bufferline-nvim" },
  { import = "astrocommunity.editing-support.mini-splitjoin" },
  { import = "astrocommunity.editing-support.wildfire-nvim" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  { import = "astrocommunity.bars-and-lines.dropbar-nvim" },
  { import = "astrocommunity.recipes.heirline-mode-text-statusline" },
  { import = "astrocommunity.editing-support.cutlass-nvim" },
  -- { import = "astrocommunity.editing-support.nvim-treesitter-context" },
}
