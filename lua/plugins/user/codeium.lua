return {
  "Exafunction/codeium.nvim",
  cmd = "Codeium",
  event = "InsertEnter",
  build = ":Codeium Auth",
  opts = {
    enable_cmp_source = false,
    virtual_text = {
      enabled = true,
      filetypes = {},
      default_filetype_enabled = true,
      manual = false,
      idle_delay = 75,
      virtual_text_priority = 65535,
      map_keys = true,
      accept_fallback = "\t",
      key_bindings = {
        accept = "<C-k>",
        accept_word = false,
        accept_line = false,
        clear = false,
      },
    },
  },
  config = function(_, opts) require("codeium").setup(opts) end,
}
