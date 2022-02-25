local actions = require('gfold.actions')
local fmt = require('gfold.formatting')

return {
  -- command to use to produce output
  -- needs to conform to the expected json output from gfold
  -- !! TODO needs to be updated
  cmd = 'gfold | ~/dev/vim-plugins/nvim-gfold.lua/gfold2json',

  -- base directory to look for repos
  -- defaults to home
  -- !! TODO needs to be updated
  cwd = '/home/axel/dev',

  -- how to format an entry in the picker
  -- default will be something like:
  --   ✔ nvim-gfold.lua (/home/path/to/nvim-gfold.lua)
  format_item = fmt.format_item,

  -- what to do when selecting a repo
  -- by default changes cwd
  on_select = actions.change_cwd,

  -- if we should continuously update the summary (for statusline)
  update_summary = true,

  -- how long to wait in between querying repo statuses (for statusline)
  -- NOTE this is the time from the last process ran until starting it again
  -- so the interval will be whatever time it takes to run gfold plus this setting
  update_delay = 500,

  -- how to format summary when calling `get_summary` (for statusline)
  format_summary = fmt.format_summary,
}
