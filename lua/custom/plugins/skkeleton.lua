return {
  -- 1. 基盤・コア
  { 'vim-denops/denops.vim', lazy = false },
  {
    'Shougo/ddc.vim',
    lazy = false,
    dependencies = { 'vim-denops/denops.vim' },
    config = function()
      local patch_global = vim.fn['ddc#custom#patch_global']

      patch_global('ui', 'pum')
      patch_global('sources', { 'copilot', 'lsp', 'skkeleton', 'around' })

      patch_global('sourceOptions', {
        ['_'] = {
          matchers = { 'matcher_head' },
          sorters = { 'sorter_rank' },
        },
        lsp = {
          mark = 'LSP',
          forceCompletionPattern = [[\.\w*|:\w*|->\w*]],
        },
        skkeleton = {
          mark = 'skk',
          isVolatile = true,
          minAutoCompleteLength = 1,
        },
        copilot = {
          mark = 'Co',
          matchers = { 'matcher_head' },
          sorters = { 'sorter_rank' },
          minAutoCompleteLength = 0,
          isVolatile = true,
          forceCompletionPattern = [[\w+]],
          timeout = 2000,
        },
        around = {
          mark = 'A',
        },
      })

      patch_global('sourceParams', {
        copilot = {
          enterprise = false,
        },
      })

      vim.fn['ddc#enable']()
    end,
  },

  -- 2. UI
  { 'Shougo/pum.vim', lazy = false },
  { 'Shougo/ddc-ui-pum' },

  -- 3. Copilot (本体 + ddcソース)
  {
    'github/copilot.vim',
    lazy = false, -- 重要！
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
    end,
  },
  { 'Shougo/ddc-source-copilot', dependencies = { 'github/copilot.vim' } },

  -- 4. その他ソース・フィルター
  { 'Shougo/ddc-source-lsp' },
  { 'Shougo/ddc-source-around' },
  { 'Shougo/ddc-filter-sorter_rank' },
  { 'Shougo/ddc-filter-matcher_head' },

  -- 5. Skkeleton (元のまま)
  {
    'vim-skk/skkeleton',
    lazy = false,
    dependencies = { 't4k44/skkeleton-azik-kanatable' },
    config = function()
      vim.fn['skkeleton#azik#add_table'] 'us'
      vim.fn['skkeleton#config'] {
        kanaTable = 'azik',
        globalDictionaries = { '~/.skk/SKK-JISYO.L' },
        eggLikeNewline = true,
        keepState = true,
      }

      local opts = { noremap = true, silent = true }
      vim.keymap.set({ 'i', 'c', 't' }, '<C-j>', '<Plug>(skkeleton-toggle)', { noremap = false })
      vim.keymap.set({ 'i', 'c' }, '<C-n>', '<cmd>call pum#map#insert_relative(+1)<CR>', opts)
      vim.keymap.set({ 'i', 'c' }, '<C-p>', '<cmd>call pum#map#insert_relative(-1)<CR>', opts)
      vim.keymap.set({ 'i', 'c' }, '<C-y>', '<cmd>call pum#map#confirm()<CR>', opts)
      vim.keymap.set({ 'i', 'c' }, '<C-e>', '<cmd>call pum#map#cancel()<CR>', opts)
    end,
  },
  {
    'delphinus/skkeleton_indicator.nvim',
    config = function()
      require('skkeleton_indicator').setup {}
    end,
  },
}
