local settings = require('gfold.settings')
local utils = require('gfold.utils')

local update_settings = function(user_opts)
  utils.recursive_tbl_update(settings, user_opts)
end

local setup = function(user_opts)
  update_settings(user_opts)
  if settings.update_summary then
    require('gfold.status').update_summary()
  end
end

local pick_repo = function()
  return require('gfold.picker').pick_repo()
end

local get_summary = function()
  return require('gfold.status').get_summary()
end

return {
  setup = setup,
  pick_repo = pick_repo,
  get_summary = get_summary,
}
