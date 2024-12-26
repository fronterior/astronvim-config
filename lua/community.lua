-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  -- import/override with your plugins folder
  { import = "astrocommunity.pack.typescript-all-in-one" },
  { import = "astrocommunity.pack.swift" },
  {
    import = "astrocommunity.colorscheme.citruszest-nvim",
  },
  { import = "astrocommunity.colorscheme.bluloco-nvim" },
  { import = "astrocommunity.completion.avante-nvim" },
  { import = "astrocommunity.colorscheme.cyberdream-nvim" },
  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
  { import = "astrocommunity.utility.noice-nvim" },
  { import = "astrocommunity.indent.indent-rainbowline" },
  { import = "astrocommunity.scrolling.neoscroll-nvim" },
  { import = "astrocommunity.scrolling.nvim-scrollbar" },
  { import = "astrocommunity.color.transparent-nvim" },
  { import = "astrocommunity.git.diffview-nvim" },
  { import = "astrocommunity.colorscheme.fluoromachine-nvim" },
  { import = "astrocommunity.motion.leap-nvim" },
}
