local settings = require('gfold.settings')

local color_codes = {
  '\x1b%[0m',
  '\x1b%[1m',
  '\x1b%[32m',
  '\x1b%[33m',
  '\x1b%[38;2;128;128;128m',
}

local strip_colors = function(data)
  local text = table.concat(data, '\n')
  for _, color_code in ipairs(color_codes) do
    text = text:gsub(color_code, '')
  end
  return vim.split(text, '\n')
end

local strip = function(text)
  text = text:gsub('^%s*', '')
  text = text:gsub('%s*$', '')
  return text
end

local split_once = function(text, sep)
  local fragments = vim.split(text, sep)
  local first = table.remove(fragments, 1)
  return first, table.concat(fragments, sep)
end

-- TODO when gfold can do native json output this can change to just be
--  return vim.fn.json_decode(table.concat(data, '\n'))
-- (https://github.com/nickgerace/gfold/issues/176)
local parse_output = function(data)
  data = strip_colors(data)
  local repos = {}
  local idx = 1
  while idx < #data do  -- NOTE last entry of data is empty
    local name, path = split_once(data[idx], '~')
    name = strip(name)
    path = strip(path)
    local status, branch = split_once(strip(data[idx + 1]), ' ')
    branch = branch:sub(2, -2)
    local remote = strip(data[idx + 2])
    local user = strip(data[idx + 3])
    table.insert(repos, {
        name=name,
        path=path,
        status=status,
        branch=branch,
        remote=remote,
        user=user,
    })
    idx = idx + 4
  end
  return repos
end

local get_repos = function(callback)
  vim.fn.jobstart('gfold', {
    cwd = settings.cwd,
    on_stdout = function(_, data, _)
      local repos = parse_output(data)
      callback(repos)
    end,
    stdout_buffered = true,
  })
end

return {
  get_repos = get_repos,
}
