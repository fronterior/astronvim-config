return {
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
}