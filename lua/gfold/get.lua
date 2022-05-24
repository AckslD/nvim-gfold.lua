local settings = require('gfold.settings')

local parse_output = function(data)
  local ret = vim.fn.json_decode(table.concat(data, '\n'))
  for i, v in pairs(ret) do
    ret[i].status = v.status:lower()
    ret[i].path = v.parent .. '/' .. v.name
    ret[i].remote = v.url
    ret[i].user = v.email
  end
  return ret
end

local get_repos = function(callback)
  vim.fn.jobstart('gfold --display-mode json', {
    cwd = settings.cwd,
    on_stdout = function(_, data, _)
      local repos = parse_output(data)
      callback(repos)
    end,
    on_stderr = function(_, data, _)
      local text = table.concat(data, '\n')
      if text ~= '' then
        vim.notify_once('Error: ' .. text, vim.log.levels.WARN)
      end
    end,
    stdout_buffered = true,
  })
end

return {
  get_repos = get_repos,
}
