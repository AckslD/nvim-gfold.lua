local function recursive_tbl_update(base, new)
  if new == nil then
    new = {}
  end
  for key, value in pairs(new) do
    if type(base[key]) == 'table' then
      recursive_tbl_update(value, base[key])
    else
      base[key] = value
    end
  end
end

return {
  recursive_tbl_update = recursive_tbl_update,
}
