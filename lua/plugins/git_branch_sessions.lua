-- function for calculating the current session name
local get_session_name = function()
  local name = vim.fn.getcwd()
  local branch = vim.fn.system "git branch --show-current"
  if vim.v.shell_error == 0 then
    return name .. vim.trim(branch --[[@as string]])
  else
    return name
  end
end

return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    sessions = {
      -- disable the auto-saving of directory sessions
      autosave = { cwd = false },
    },
    mappings = {
      n = {
        -- update save dirsession mapping to get the correct session name
        ["<Leader>SS"] = {
          function() require("resession").save(get_session_name(), { dir = "dirsession" }) end,
          desc = "Save this dirsession",
        },
        -- update load dirsession mapping to get the correct session name
        ["<Leader>S."] = {
          function() require("resession").load(get_session_name(), { dir = "dirsession" }) end,
          desc = "Load current dirsession",
        },
      },
    },
    autocmds = {
      git_branch_sessions = {
        -- auto save directory sessions on leaving
        {
          event = "VimLeavePre",
          desc = "Save git branch directory sessions on close",
          callback = vim.schedule_wrap(function()
            if require("astrocore.buffer").is_valid_session() then
              require("resession").save(get_session_name(), { dir = "dirsession", notify = false })
            end
          end),
        },
        -- auto restore previous previous directory session, remove if necessary
        {
          event = "VimEnter",
          desc = "Restore previous directory session if neovim opened with no arguments",
          nested = true, -- trigger other autocommands as buffers open
          callback = function()
            -- Only load the session if nvim was started with no args
            if vim.fn.argc(-1) == 0 then
              -- try to load a directory session using the current working directory
              require("resession").load(get_session_name(), { dir = "dirsession", silence_errors = true })
            end
            -- Initialize last session name for branch switching detection
            vim.g.last_session_name = get_session_name()
          end,
        },
        -- auto restore session when focus is gained (e.g., after using lazygit)
        {
          event = "FocusGained",
          desc = "Restore session if branch changed while nvim was unfocused",
          callback = function()
            local current_session = get_session_name()
            local last_session = vim.g.last_session_name or current_session

            if current_session ~= last_session then
              -- Save current session before switching
              if require("astrocore.buffer").is_valid_session() then
                require("resession").save(last_session, { dir = "dirsession", notify = false })
              end

              -- Close all current buffers except special ones
              for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_is_loaded(bufnr) and require("astrocore.buffer").is_valid(bufnr) then
                  vim.api.nvim_buf_delete(bufnr, { force = false })
                end
              end

              -- Load new session
              require("resession").load(current_session, { dir = "dirsession", silence_errors = true })
            end

            vim.g.last_session_name = current_session
          end,
        },
        -- auto restore session when terminal closes (e.g., after closing lazygit floating terminal)
        {
          event = "TermClose",
          desc = "Restore session if branch changed after terminal closes",
          callback = function()
            -- Small delay to ensure git operations are complete
            vim.defer_fn(function()
              local current_session = get_session_name()
              local last_session = vim.g.last_session_name or current_session
              
              if current_session ~= last_session then
                -- Save current session before switching
                if require("astrocore.buffer").is_valid_session() then
                  require("resession").save(last_session, { dir = "dirsession", notify = false })
                end
                
                -- Close all current buffers except special ones
                for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
                  if vim.api.nvim_buf_is_loaded(bufnr) and require("astrocore.buffer").is_valid(bufnr) then
                    vim.api.nvim_buf_delete(bufnr, { force = false })
                  end
                end
                
                -- Load new session
                require("resession").load(current_session, { dir = "dirsession", silence_errors = true })
              end
              
              vim.g.last_session_name = current_session
            end, 100) -- 100ms delay
          end,
        },
      },
    },
  },
}
