-- TODO should be exposed as config
local status_symbols = {
  unclean = '✘',
  clean = '✔',
  bare = '',
  unpushed = '',
}
local format_item = function(repo)
  return string.format(
    '%s %s (%s)',
    status_symbols[repo.status],
    repo.name,
    repo.path
  )
end
local on_select = function(repo, idx)
  if repo then
    vim.cmd('cd ' .. repo.path)
  end
end
-- TODO how to handle colors properly?
local colors = {
  unclean = '%#lualine_b_diagnostics_error_normal#',
  clean = '%#lualine_b_diagnostics_info_normal#',
  bare = '%#lualine_b_diagnostics_warning_normal#',
  unpushed = '%#lualine_b_diagnostics_hint_normal#',
}
local format_summary = function(summary)
  local pieces = {}
  for _, status in ipairs({'clean', 'unclean', 'bare', 'unpushed'}) do
    local num = summary[status]
    if num > 0 then
      table.insert(pieces, string.format('%s%s%s', colors[status], status_symbols[status], num))
    end
  end
  return table.concat(pieces, ' ')
end
local config = {
  cwd = '/home/axel/dev',
  format_item = format_item,
  on_select = on_select,
  update_interval = 5000,
  format_summary = format_summary,
}
--

local get_repos = function(callback)
  vim.fn.jobstart('gfold | ~/dev/vim-plugins/nvim-gfold.lua/gfold2json', {
    cwd = config.cwd,
    on_stdout = function(_, data, _)
      local repos = vim.fn.json_decode(table.concat(data, '\n'))
      callback(repos)
    end,
    stdout_buffered = true,
  })
end

local pick_repo = function()
  get_repos(function(repos)
    vim.ui.select(repos, {
      prompt = 'gfold',
      format_item = config.format_item,
      kind = 'gfold',
    }, config.on_select)
  end)
end

local summary = {
  unclean = 0,
  clean = 0,
  bare = 0,
  unpushed = 0,
}

local get_summary = function()
  return config.format_summary(summary)
end

local update_summary = function()
  get_repos(function(repos)
    for key, _ in pairs(summary) do
      summary[key] = 0
    end
    for _, repo in ipairs(repos) do
      local current = summary[repo.status]
      summary[repo.status] = current + 1
    end
  end)
end

local start_summary_update_timer = function()
  update_summary() -- call once directly
  vim.fn.timer_start(config.update_interval, update_summary, {['repeat'] = -1})
end

local setup = function()
  if config.update_interval then
    start_summary_update_timer()
  end
end

return {
  setup = setup,
  pick_repo = pick_repo,
  get_summary = get_summary,
}
