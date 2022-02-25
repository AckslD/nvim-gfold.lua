local settings = require('gfold.settings')

local get_repos = function(callback)
  vim.fn.jobstart(settings.cmd, {
    cwd = settings.cwd,
    on_stdout = function(_, data, _)
      local repos = vim.fn.json_decode(table.concat(data, '\n'))
      callback(repos)
    end,
    stdout_buffered = true,
  })
end

return {
  get_repos = get_repos,
}
