-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEFORE ENABLING THIS FILE
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize dashboard options
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = table.concat({
            " █████  ███████ ████████ ██████   ██████ ",
            "██   ██ ██         ██    ██   ██ ██    ██",
            "███████ ███████    ██    ██████  ██    ██",
            "██   ██      ██    ██    ██   ██ ██    ██",
            "██   ██ ███████    ██    ██   ██  ██████ ",
            "",
            "███    ██ ██    ██ ██ ███    ███",
            "████   ██ ██    ██ ██ ████  ████",
            "██ ██  ██ ██    ██ ██ ██ ████ ██",
            "██  ██ ██  ██  ██  ██ ██  ██  ██",
            "██   ████   ████   ██ ██      ██",
          }, "\n"),
        },
      },
    },
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
    opts = function(_, opts)
      local astro = require "astrocore"

      -- sources에 document_symbols 추가
      opts.sources = astro.list_insert_unique(opts.sources or {}, {
        "document_symbols",
      })

      -- source_selector.sources에 document_symbols 추가
      if not opts.source_selector then opts.source_selector = {} end
      if not opts.source_selector.sources then opts.source_selector.sources = {} end

      opts.source_selector.sources = astro.list_insert_unique(opts.source_selector.sources, {
        { source = "document_symbols", display_name = "📋 Symbols" },
      })

      -- 기존 window 설정 유지
      if not opts.window then opts.window = {} end
      if not opts.window.mappings then opts.window.mappings = {} end

      opts.window.mappings["s"] = false
      opts.window.mappings["V"] = "open_split"
      opts.window.mappings["v"] = "open_vsplit"
      opts.window.mappings["<F1>"] = "prev_source"
      opts.window.mappings["<F2>"] = "next_source"
      opts.window.mappings["\\"] = function() end
      opts.window.mappings["|"] = function() end

      -- 기존 event_handlers 유지
      if not opts.event_handlers then opts.event_handlers = {} end
      table.insert(opts.event_handlers, {
        event = "before_render",
        handler = function(state)
          -- Leap 모드가 활성화되어 있을 때는 모든 키매핑을 비활성화
          -- if vim.g.leap_active then state.window.mappings = {} end
        end,
      })

      return opts
    end,
  },

  {
    "stevearc/aerial.nvim",
    opts = {
      placement = "right",
    },
  },

  -- {
  --   "hrsh7th/nvim-cmp",
  --   opts = function(_, opts)
  --     local cmp = require "cmp"
  --     opts.mapping = vim.tbl_extend("force", opts.mapping, {
  --       ["<C-i>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
  --       ["<C-Space>"] = nil,
  --     })
  --   end,
  -- },
  --
  -- {
  --   "Exafunction/codeium.vim",
  --   config = function()
  --     vim.g.codeium_disable_bindings = true
  --
  --     vim.keymap.set("i", "<C-k>", function() return vim.fn["codeium#Accept"]() end, { expr = true, silent = true })
  --   end,
  -- },

  -- {
  --   {
  --     "mfussenegger/nvim-dap",
  --     enabled = true,
  --     event = "FileType", -- community 보다 로딩 늦추기
  --     dependencies = {
  --       "rcarriga/nvim-dap-ui",
  --     },
  --     config = function()
  --       local dap = require "dap"
  --
  --       dap.adapters["pwa-node"] = {
  --         type = "server",
  --         host = "localhost",
  --         port = "${port}",
  --         executable = {
  --           command = "node",
  --           -- command = "js-debug-adapter",
  --           args = {
  --             vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
  --             "${port}",
  --           },
  --         },
  --       }
  --
  --       dap.adapters["pwa-chrome"] = {
  --         type = "server",
  --         host = "localhost",
  --         port = "${port}",
  --         executable = {
  --           command = "node",
  --           args = {
  --             vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
  --             "${port}",
  --           },
  --         },
  --       }
  --
  --       for _, language in ipairs { "typescript", "javascript" } do
  --         dap.configurations[language] = {
  --           {
  --             type = "pwa-node",
  --             request = "launch",
  --             name = "Launch file",
  --             program = "${file}",
  --             cwd = "${workspaceFolder}",
  --           },
  --           {
  --             type = "pwa-node",
  --             request = "attach",
  --             name = "Attach",
  --             processId = require("dap.utils").pick_process,
  --             cwd = "${workspaceFolder}",
  --           },
  --           {
  --             type = "pwa-node",
  --             request = "launch",
  --             name = "Debug Jest Tests",
  --             runtimeExecutable = "node",
  --             runtimeArgs = {
  --               "./node_modules/jest/bin/jest.js",
  --               "--runInBand",
  --             },
  --             rootPath = "${workspaceFolder}",
  --             cwd = "${workspaceFolder}",
  --             console = "integratedTerminal",
  --             internalConsoleOptions = "neverOpen",
  --           },
  --         }
  --       end
  --     end,
  --   },
  -- },

  {
    "mxsdev/nvim-dap-vscode-js",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
        callback = function()
          -- AstroCommunity가 덮어쓴 후 일정 시간 뒤에 다시 덮기
          vim.defer_fn(function()
            local dap = require "dap"

            -- https://github.com/sharker92/Ahrker-NeoVim-Config/blob/main/lua/plugins/core/dap.lua#L76-L101
            dap.adapters["pwa-node"] = {
              type = "server",
              host = "localhost",
              port = "${port}",
              executable = {
                command = "node",
                args = {
                  vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
                  "${port}",
                },
              },
            }

            dap.adapters["pwa-chrome"] = {
              type = "server",
              host = "localhost",
              port = "${port}",
              executable = {
                command = "node",
                args = {
                  vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
                  "${port}",
                },
              },
            }

            for _, language in ipairs { "typescript", "javascript", "typescriptreact", "javascriptreact" } do
              dap.configurations[language] = {
                {
                  type = "pwa-node",
                  request = "attach",
                  name = "Attach",
                  port = 9229,
                  cwd = "${workspaceFolder}",
                  skipFiles = { "<node_internals>/**" },
                },
                {
                  type = "pwa-node",
                  request = "launch",
                  name = "Launch file",
                  program = "${file}",
                  cwd = "${workspaceFolder}",
                },
                {
                  type = "pwa-chrome",
                  request = "launch",
                  name = "Next.js: Ridibooks",
                  -- webRoot = "${workspaceFolder}/src",
                  url = "https://next.local.ridibooks.com",
                  webRoot = "${workspaceFolder}",
                  protocol = "inspector",
                  sourceMaps = true,
                  skipFiles = { "<node_internals>/**", "node_modules/**" },
                  sourceMapPathOverrides = {
                    ["webpack://_N_E/*"] = "${workspaceFolder}/*",
                  },
                },
                {
                  type = "pwa-node",
                  request = "launch",
                  name = "Debug Jest Tests",
                  runtimeExecutable = "node",
                  runtimeArgs = {
                    "./node_modules/jest/bin/jest.js",
                    "--runInBand",
                  },
                  rootPath = "${workspaceFolder}",
                  cwd = "${workspaceFolder}",
                  console = "integratedTerminal",
                  internalConsoleOptions = "neverOpen",
                },
              }
            end
          end, 100) -- 100ms 뒤 강제 재등록
        end,
      })
    end,
  },

  {
    "vuki656/package-info.nvim",
    enabled = false,
  },

  {
    "wojciech-kulik/xcodebuild.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-tree.lua", -- optional
      "stevearc/oil.nvim", -- optional
      "nvim-treesitter/nvim-treesitter", -- optional
    },
    config = function() require("xcodebuild").setup {} end,
  },

  {
    "Wansmer/langmapper.nvim",
    lazy = false,
    priority = 1, -- autoremap() 사용 시 높은 우선순위 필요
    config = function()
      require("langmapper").setup {
        -- 필요한 설정을 여기에 추가하세요
      }
    end,
  },

  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      strategies = {
        -- Change the default chat adapter
        chat = {
          adapter = "anthropic",
        },
        inline = {
          adapter = "anthropic",
        },
      },
      opts = {
        -- Set debug logging
        log_level = "DEBUG",
      },
    },
    config = true,
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#000000",
    },
  },

  {
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
  },

  {
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
      }

      vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Dropbar: pick symbol" })
      vim.keymap.set("n", '<Leader>"', function()
        local bar = require("dropbar.utils.bar").get_current()
        if bar and bar.components and #bar.components > 0 then bar:pick(#bar.components) end
      end, { desc = "Dropbar: open current context" })

      vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Dropbar: go to context start" })
      vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Dropbar: select next context" })
    end,
  },

  {
    "rest-nvim/rest.nvim",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          table.insert(opts.ensure_installed, "http")
        end,
      },
    },
    config = function() require("rest-nvim").setup {} end,
  },

  {
    "Exafunction/codeium.nvim",
    cmd = "Codeium",
    event = "InsertEnter",
    build = ":Codeium Auth",
    opts = {
      enable_cmp_source = true,
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
          next = "<M-]>",
          prev = "<M-[>",
        },
      },
    },
    config = function(_, opts) require("codeium").setup(opts) end,
  },
}
