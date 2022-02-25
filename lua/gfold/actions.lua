local change_cwd = function(repo, idx)
  if repo then
    vim.cmd('cd ' .. repo.path)
  end
end

return {
  change_cwd = change_cwd,
}
