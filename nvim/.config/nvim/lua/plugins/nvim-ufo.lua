vim.pack.add {
  'https://github.com/kevinhwang91/nvim-ufo',
  'https://github.com/kevinhwang91/promise-async',
}

require('ufo').setup({
  provider_selector = function(bufnr, filetype, buftype)
    return { 'treesitter', 'indent' }
  end
})

vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = "Open all folds [ufo]" })
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = "Close all folds [ufo]" })
