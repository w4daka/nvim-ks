return {
  -- 参考 https://zenn.dev/kkc/articles/tk-nvim-skkeleton-setting2
  { 'vim-denops/denops.vim', lazy = false },
  { 'Shougo/ddc.vim' },
  { 'Shougo/pum.vim' },
  { 'Shougo/ddc-ui-pum' },

  {
    'delphinus/skkeleton_indicator.nvim',
    config = function()
      require('skkeleton_indicator').setup {}
    end,
  },

  {
    'vim-skk/skkeleton',
    dependencies = {
      'vim-denops/denops.vim',
      'Shougo/ddc.vim',
      't4k44/skkeleton-azik-kanatable', -- 個人設定分をk16em氏のkanatableからfork
    },
    config = function()
      vim.fn['skkeleton#azik#add_table'] 'us'
      vim.fn['skkeleton#register_kanatable']('azik', {
        q = 'katakana',
      })

      vim.fn['skkeleton#config'] {
        kanaTable = 'azik',
        globalDictionaries = {
          '~/.skk/SKK-JISYO.L',
        },
        userDictionary = '~/.skk/skk-user.dict',
        completionRankFile = '~/.skk/rank.json',
        eggLikeNewline = true,
        keepState = true,
        showCandidatesCount = 2,
        registerConvertResult = true,
      }

      vim.cmd [[ call ddc#custom#patch_global('sources', ['skkeleton']) ]]
      vim.cmd [[ call ddc#custom#patch_global('sourceOptions', {
        \ '_': {
        \   'matchers': ['matcher_head'],
        \   'sorters': ['sorter_rank'],
        \ },
        \ 'skkeleton': {
        \   'mark': 'skkeleton',
        \   'matchers': [],
        \   'sorters': [],
        \   'converters': [],
        \   'isVolatile': v:true,
        \   'minAutoCompleteLength': 1,
        \ }
        \})
      ]]
      vim.cmd [[ call ddc#enable() ]]
      vim.cmd [[ call ddc#custom#patch_global('ui', 'pum') ]]

      vim.keymap.set({ 'i', 'c', 't' }, '<C-j>', '<Plug>(skkeleton-toggle)', { noremap = false })
      vim.keymap.set({ 'i', 'c' }, '<C-n>', '<cmd>call pum#map#insert_relative(+1)<CR>')
      vim.keymap.set({ 'i', 'c' }, '<C-p>', '<cmd>call pum#map#insert_relative(-1)<CR>')
      vim.keymap.set({ 'i', 'c' }, '<C-y>', '<cmd>call pum#map#confirm()<CR>')
      vim.keymap.set({ 'i', 'c' }, '<C-e>', '<cmd>call pum#map#cancel()<CR>')
      vim.keymap.set({ 'i', 'c' }, '<PageDown>', '<cmd>call pum#map#insert_relative_page(+1)<CR>')
      vim.keymap.set({ 'i', 'c' }, '<PageUp>', '<cmd>call pum#map#insert_relative_page(-1)<CR>')
    end,
  },
}
