local actions = require('gfold.actions')

return {
  -- base directory to look for repos
  -- defaults to home
  cwd = vim.fn.getenv('HOME'),

  -- What symbols to use, for both picker and status
  status_symbols = {
    clean = '✔',
    unclean = '✘',
    unpushed = '',
    bare = '',
  },

  -- settings specific to the picker
  picker = {
    -- how to format an entry in the picker
    -- default will be something like:
    --   ✔ nvim-gfold.lua (/home/path/to/nvim-gfold.lua)
    format_item = function(repo)
      return string.format(
      '%s %s (%s)',
      require('gfold.settings').status_symbols[repo.status],
      repo.name,
      repo.path
      )
    end,

    -- what to do when selecting a repo
    -- by default changes cwd
    on_select = actions.change_cwd,
  },

  -- settings specific to the status(line)
  status = {
    -- if we should continuously update the summary
    enable = true,

    -- how long to wait in between querying repo statuses
    -- NOTE this is the time from the last process ran until starting it again
    -- so the interval will be whatever time it takes to run gfold plus this setting
    -- Default is 5 seconds but if for some reason you want this to be updated more frequently
    -- you can always make this value smaller.
    update_delay = 5000,

    -- What color of highlights to use
    -- Values are either:
    --   * string: a highlight group
    --   * table: eg `{fg = '#b8bb26'}`
    colors = {
      clean = {fg = '#b8bb26'},
      unclean = {fg = '#fb4934'},
      unpushed = {fg = '#fe8019'},
      bare = {fg = '#fabd2f'},
    },

    -- In which order to show the components of the summary
    order = {
      'clean',
      'unclean',
      'unpushed',
      'bare',
    },
  },
}
