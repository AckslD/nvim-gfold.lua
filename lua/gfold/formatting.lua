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

return {
  format_item = format_item,
  format_summary = format_summary,
}
