# nvim-gfold.lua

❗WARNING WORK IN PROGRESS ❗:

TODO:
- [ ] Fix paths, currently default paths use my home path.
- [ ] Use native `json` output from `gfold` (https://github.com/nickgerace/gfold/issues/176)
- [ ] Figure out how to properly define colors. Probably some of the formatting used for lualine should not be part of this repo.

`nvim` plugin for [gfold](https://github.com/nickgerace/gfold) currently providing:
* A picker to change `cwd`.
  This uses `vim.ui.select`.
  To have a nice ui for example [dressing.nvim](https://github.com/stevearc/dressing.nvim) can be used.
* A function to get a summary that can be used in statuslines, eg [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim).

## Pictures

## Install
```lua
use {
  "AckslD/nvim-gfold.lua",
  config = function()
    require('gfold').setup()
  end,
}
```

## Config
Pass a table to `require('gfold').setup()`.
For supported keys and default values see [settings](https://github.com/AckslD/nvim-gfold.lua/tree/main/lua/gfold/settings.lua).

## Usage
### Picker
To pick a repo:
```vim
:lua require('gfold').pick_repo()
```

### Statusline
For example using `lualine`:
```lua
require('lualine').setup({
  ...
  sections = {
    ...
    lualine_x = {
      ...
      require('gfold').get_summary,
      ...
    },
    ...
  },
  ...
})
```
