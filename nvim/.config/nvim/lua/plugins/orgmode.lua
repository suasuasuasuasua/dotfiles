vim.pack.add { 'https://github.com/nvim-orgmode/orgmode' }

require('orgmode').setup {
  org_agenda_files = { '~/orgfiles/*.org' },
  org_default_notes_file = '~/orgfiles/inbox.org',
  org_archive_location = '~/orgfiles/archive/%s_archive::',
  org_startup_folded = 'showeverything',
  org_hide_emphasis_markers = true,
  org_hide_leading_stars = true,
  org_todo_keywords = { 'TODO(t)', 'INPROGRESS(p)', 'WAITING(w)', '|', 'DONE(d)', 'CANCELLED(c)' },
  org_todo_keyword_faces = {
    TODO = ':foreground #ff8f8f :weight bold',
    INPROGRESS = ':foreground #ffcc66 :weight bold',
    WAITING = ':foreground #cba6f7 :weight bold',
    DONE = ':foreground #a6e3a1 :weight bold',
    CANCELLED = ':foreground #6c7086 :weight bold :slant italic',
  },
  org_capture_templates = {
    t = {
      description = 'Task',
      template = '* TODO %?\n  SCHEDULED: %t',
      target = '~/orgfiles/inbox.org',
      headline = 'Tasks',
    },
    n = {
      description = 'Note',
      template = '* %?\n  %<[%Y-%m-%d %a %H:%M:%S]>',
      target = '~/orgfiles/inbox.org',
      headline = 'Notes',
    },
    j = {
      description = 'Journal',
      template = '* %?\n  %<[%Y-%m-%d %a %H:%M:%S]>',
      target = '~/orgfiles/journal.org',
      datetree = { tree_type = 'week' },
    },
    p = {
      description = 'Project task',
      template = '* TODO %?',
      target = '~/orgfiles/projects.org',
    },
  },
  mappings = {
    org = {
      org_cycle = 'za',
      org_global_cycle = 'zA',
    },
  },
}

vim.lsp.enable 'org'
