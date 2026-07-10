vim.pack.add { 'https://github.com/chipsenkbeil/org-roam.nvim' }

require('org-roam').setup {
  directory = '~/orgfiles/notes',
  extensions = {
    dailies = {
      directory = 'dailies',
    },
  },
}
