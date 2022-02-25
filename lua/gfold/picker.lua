local settings = require('gfold.settings')
local get_repos = require('gfold.get').get_repos

local pick_repo = function()
  get_repos(function(repos)
    vim.ui.select(repos, {
      prompt = 'gfold',
      format_item = settings.format_item,
      kind = 'gfold',
    }, settings.on_select)
  end)
end

return {
  pick_repo = pick_repo,
}
