local change_cwd = function(repo, idx)
  if repo then
    vim.schedule(function()
      vim.cmd('lcd ' .. repo.path)
    end)
  end
end

return {
  change_cwd = change_cwd,
}
