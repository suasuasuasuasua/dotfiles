vim.pack.add { 'https://github.com/nvim-orgmode/orgmode' }

require('orgmode').setup {
  org_agenda_files = { '~/orgfiles/*.org' },
  org_default_notes_file = '~/orgfiles/inbox.org',
  org_archive_location = '~/orgfiles/archive/%s_archive::',
  org_startup_folded = 'content',
  org_hide_emphasis_markers = true,
  org_hide_leading_stars = true,
  org_log_into_drawer = 'LOGBOOK',
  org_agenda_custom_commands = {
    d = {
      description = 'Daily dashboard',
      types = {
        {
          type = 'agenda',
          org_agenda_span = 'day',
          org_agenda_sorting_strategy = { 'todo-state-up', 'time-up', 'priority-down' },
        },
        {
          type = 'tags_todo',
          match = 'TODO="INPROGRESS"',
          org_agenda_overriding_header = 'In-Progress',
          org_agenda_sorting_strategy = { 'priority-down' },
        },
        {
          type = 'tags_todo',
          match = 'TODO="WAITING"',
          org_agenda_overriding_header = 'Blocked/Waiting',
          org_agenda_sorting_strategy = { 'priority-down' },
        },
        {
          type = 'tags_todo',
          match = 'DEADLINE<="<+14d>"',
          org_agenda_overriding_header = 'Deadlines (next 2 weeks)',
          org_agenda_sorting_strategy = { 'todo-state-up', 'priority-down' },
        },
        {
          type = 'tags_todo',
          match = '+inbox+TODO="TODO"',
          org_agenda_overriding_header = 'Inbox to Process',
          org_agenda_sorting_strategy = { 'todo-state-up', 'priority-down' },
        },
        {
          type = 'tags',
          match = 'TODO="DONE"+CLOSED>="<-7d>"',
          org_agenda_overriding_header = 'Completed (last 7 days)',
          org_agenda_sorting_strategy = { 'priority-down' },
        },
      },
    },
  },
  org_todo_keywords = { 'TODO(t)', 'INPROGRESS(p)', 'WAITING(w)', '|', 'DONE(d)', 'CANCELLED(c)' },
  org_todo_keyword_faces = {
    TODO = ':weight bold',
    INPROGRESS = ':weight bold',
    WAITING = ':weight bold',
    DONE = ':weight bold',
    CANCELLED = ':weight bold :slant italic',
  },
  org_capture_templates = {
    t = {
      description = 'Task',
      template = '* TODO %?\n  SCHEDULED: %t',
      target = '~/orgfiles/inbox.org',
      headline = 'Tasks',
    },
    T = {
      description = 'Task (pick date)',
      template = '* TODO %?\n  SCHEDULED: %^t',
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
}

local function link_org_highlights()
  local links = {
    -- TODO keyword faces
    ['@org.keyword.face.TODO'] = 'DiagnosticError',
    ['@org.keyword.face.INPROGRESS'] = 'DiagnosticWarn',
    ['@org.keyword.face.WAITING'] = 'DiagnosticInfo',
    ['@org.keyword.face.DONE'] = 'DiagnosticOk',
    ['@org.keyword.face.CANCELLED'] = 'Comment',
    -- Agenda state colors (override the plugin's parsed colors that go dim in some themes)
    ['@org.agenda.deadline'] = 'DiagnosticError',
    ['@org.agenda.deadline.upcoming'] = 'DiagnosticWarn',
    ['@org.agenda.scheduled'] = 'DiagnosticOk',
    ['@org.agenda.scheduled_past'] = 'DiagnosticWarn',
    ['@org.agenda.time_grid'] = 'DiagnosticInfo',
  }
  for group, target in pairs(links) do
    vim.api.nvim_set_hl(0, group, { link = target })
  end
end

vim.api.nvim_create_autocmd('ColorScheme', { callback = link_org_highlights })
link_org_highlights()
