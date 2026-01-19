return {
  -- 1. Copilot 本体の設定
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      -- blink.cmp で表示するため、本体の UI 類は無効化する
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
  },

  -- 2. Blink と Copilot を繋ぐソース
  {
    'saghen/blink.cmp',
    dependencies = {
      'giuxtaposition/blink-cmp-copilot',
    },
    opts = {
      sources = {
        -- 'copilot' をソースリストに追加
        default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
        providers = {
          copilot = {
            name = 'copilot',
            module = 'blink-cmp-copilot',
            score_offset = 100, -- 補完順位を上げたい場合は調整
            async = true,
          },
        },
      },
      -- アイコン表示を綺麗にしたい場合（任意）
      appearance = {
        kind_icons = {
          Copilot = '',
        },
      },
    },
  },
}
