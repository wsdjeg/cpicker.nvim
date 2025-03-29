# cpicker.nvim

> _cpicker.nvim_ is a Color Converter for neovim.

[![GPLv3 License](https://img.spacevim.org/license-GPLv3-blue.svg)](LICENSE)

![cpicker](./img/cpicker.png)

<!-- vim-markdown-toc GFM -->

* [Install](#install)
* [Commands](#commands)
* [Feedback](#feedback)

<!-- vim-markdown-toc -->
## Install

Use your preferred Neovim plugin manager to install cpicker.nvim.

with [nvim-plug](https://github.com/wsdjeg/nvim-plug)

```lua
require('plug').add({
    { 'wsdjeg/cpicker.nvim' }
})
```

Then use `:PlugInstall cpicker.nvim` to install this plugin.

## Commands

1. `:Cpicker`: open the color converter
2. `:CpickerCursorForeground`: open the color converter with cursor highlight
3. `:CpickerColorMix`: open the color mixer 
4. `:CpickerCursorChangeHighlight`: change the highlight of cursor word
5. `:CpickerClearColorPatch`: clear colorscheme patch

## Feedback

If you encounter any bugs or have suggestions, please file an issue in the [issue tracker](https://github.com/wsdjeg/cpicker.nvim/issues)
