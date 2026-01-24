return {
  -- add denops
  -- github https://github.com/vim-denops
  { 'vim-denops/denops.vim', lazy = false, priority = 1000 },

  {
    dir = '~/denops-getting-started',
    name = 'denops-getting-started',
    lazy = false,
  },
  {
    dir = '~/toggle-bool.vim',
    dependdencies = { 'vim-denops/denops.vim' },
    lazy = false,
    config = function()
      vim.keymap.set('n', '<M-t>', function()
        vim.fn['denops#request']('toggle-bool', 'toggle', {})
      end, { desc = 'Toggle Bool' })
    end,
  },
}
