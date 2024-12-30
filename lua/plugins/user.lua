-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {
  {
    "ggandor/leap.nvim",
    config = function()
      local leap = require "leap"
      leap.opts.safe_labels = {}
      -- leap 모드 시작/종료 시 플래그 설정
      vim.api.nvim_create_autocmd("User", {
        pattern = "LeapEnter",
        callback = function() vim.g.leap_active = true end,
      })
      vim.api.nvim_create_autocmd("User", {
        pattern = "LeapLeave",
        callback = function() vim.g.leap_active = false end,
      })
    end,
  },

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        " █████  ███████ ████████ ██████   ██████",
        "██   ██ ██         ██    ██   ██ ██    ██",
        "███████ ███████    ██    ██████  ██    ██",
        "██   ██      ██    ██    ██   ██ ██    ██",
        "██   ██ ███████    ██    ██   ██  ██████",
        " ",
        "    ███    ██ ██    ██ ██ ███    ███",
        "    ████   ██ ██    ██ ██ ████  ████",
        "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
        "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
        "    ██   ████   ████   ██ ██      ██",
      }
      return opts
    end,
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      enable_diagnostics = true,
      enable_git_status = true,
      window = {
        position = "float",
        popup = {
          size = {
            height = "95%",
            width = "20%",
          },
          position = "4%",
          border = "rounded",
        },
        mappings = {
          ["s"] = false,
          ["S"] = false,
          ["v"] = "open_split",
          ["h"] = "open_vsplit",
        },
      },
      event_handlers = {
        {
          event = "before_render",
          handler = function(state)
            -- Leap 모드가 활성화되어 있을 때는 모든 키매핑을 비활성화
            if vim.g.leap_active then state.window.mappings = {} end
          end,
        },
      },
    },
  },

  {
    "stevearc/aerial.nvim",
    opts = {
      placement = "right",
    },
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require "cmp"
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<C-i>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-Space>"] = nil,
      })
    end,
  },

  {
    "Exafunction/codeium.vim",
    config = function()
      vim.keymap.set("i", "<C-k>", function() return vim.fn["codeium#Accept"]() end, { expr = true, silent = true })
    end,
  },

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      -- https://github.com/mfussenegger/nvim-dap/discussions/659#discussioncomment-3904282
      local dap = require "dap"

      local debugger_location = vim.fn.stdpath "data" .. "/mason/packages/node-debug2-adapter"
      dap.adapters.node = {
        type = "executable",
        command = "node",
        args = { debugger_location .. "/out/src/nodeDebug.js" },
      }

      dap.configurations.typescript = {
        {
          name = "Launch Node",
          type = "node",
          request = "launch",
          -- runtimeArgs = { "-r", "ts-node/register" },
          -- runtimeExecutable = "node",
          runtimeExecutable = "tsx",
          args = { "--inspect", "${file}" },
          skipFiles = { "node_modules/**" },
          console = "integratedTerminal",
        },
      }
    end,
  },

  {
    "vuki656/package-info.nvim",
    enabled = false,
  },

  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup {
        stages = "static",
      }
    end,
  },
}
