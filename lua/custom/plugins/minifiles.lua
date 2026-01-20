return { -- 2. mini.files の追加
  'echasnovski/mini.files',
  version = '*',
  config = function()
    require('mini.files').setup()

    -- 使いやすいようにキーマップを設定 (例: <leader>f)
    vim.keymap.set('n', '<leader>e', function()
      if not require('mini.files').close() then
        require('mini.files').open(vim.api.nvim_buf_get_name(0), true)
      end
    end, { desc = 'Open mini.files (Directory of current file)' })
  end,
}
