return {
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
    opts.window.mappings["\\"] = "set_root"
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
}