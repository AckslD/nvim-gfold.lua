local M = require('lualine.component'):extend()

local highlight = require('lualine.highlight')
local get_summary = require('gfold.status').get_summary
local settings = require('gfold.settings')

function M:init(options)
  M.super.init(self, options)
  self.colors = {}
  for status, color in pairs(settings.status.colors) do
    self.colors[status] = highlight.create_component_highlight_group(
      color,
      'summary_clean',
      self.options
    )
  end
end

function M:update_status()
  local summary = get_summary()
  local pieces = {}
  for _, status in ipairs(settings.status.order) do
    local num = summary[status]
    if num > 0 then
      table.insert(
        pieces,
        string.format(
          '%s%s%s',
          highlight.component_format_highlight(self.colors[status]),
          settings.status_symbols[status],
          num
        )
      )
    end
  end
  return table.concat(pieces, ' ')
end

return M
