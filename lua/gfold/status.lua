local settings = require('gfold.settings')
local get_repos = require('gfold.get').get_repos

local summary = {
  unclean = 0,
  clean = 0,
  bare = 0,
  unpushed = 0,
}

local get_summary = function()
  return settings.format_summary(summary)
end

local function update_summary()
  get_repos(function(repos)
    for key, _ in pairs(summary) do
      summary[key] = 0
    end
    for _, repo in ipairs(repos) do
      local current = summary[repo.status]
      summary[repo.status] = current + 1
    end
    -- delay the next call by some amount
    vim.fn.timer_start(settings.update_delay, update_summary)
  end)
end

return {
  get_summary = get_summary,
  update_summary = update_summary,
}
