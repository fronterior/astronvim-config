return {
  "Wansmer/langmapper.nvim",
  lazy = false,
  priority = 1, -- autoremap() 사용 시 높은 우선순위 필요
  config = function()
    require("langmapper").setup {
      -- 필요한 설정을 여기에 추가하세요
    }
  end,
}