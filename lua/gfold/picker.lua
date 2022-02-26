local settings = require('gfold.settings')
local get_repos = require('gfold.get').get_repos

local pick_repo = function()
  get_repos(function(repos)
    vim.ui.select(repos, {
      prompt = 'gfold',
      format_item = settings.picker.format_item,
      kind = 'gfold',
    }, settings.picker.on_select)
  end)
end

return {
  pick_repo = pick_repo,
}
