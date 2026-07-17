# cpicker.nvim

[![Run Tests](https://github.com/wsdjeg/cpicker.nvim/actions/workflows/test.yml/badge.svg)](https://github.com/wsdjeg/cpicker.nvim/actions/workflows/test.yml)
[![GitHub License](https://img.shields.io/github/license/wsdjeg/cpicker.nvim)](LICENSE)
[![GitHub Issues or Pull Requests](https://img.shields.io/github/issues/wsdjeg/cpicker.nvim)](https://github.com/wsdjeg/cpicker.nvim/issues)
[![GitHub commit activity](https://img.shields.io/github/commit-activity/m/wsdjeg/cpicker.nvim)](https://github.com/wsdjeg/cpicker.nvim/commits/master/)
[![GitHub Release](https://img.shields.io/github/v/release/wsdjeg/cpicker.nvim)](https://github.com/wsdjeg/cpicker.nvim/releases)
[![luarocks](https://img.shields.io/luarocks/v/wsdjeg/cpicker.nvim)](https://luarocks.org/modules/wsdjeg/cpicker.nvim)

cpicker.nvim is a lightweight color palette plugin for Neovim that supports a wide range of color models,
such as HEX, RGB, HSL, HSV, CMYK, HWB, Lab, Linear RGB, XYZ, and more.
Support for additional color spaces will be added in future releases.

![cpicker](https://github.com/user-attachments/assets/e883747c-5b69-4e1f-9975-32da5acc0242)

<!-- vim-markdown-toc GFM -->

- [📦 Installation](#-installation)
- [⚙️ Basic Usage](#-basic-usage)
- [🪟 Key binding](#-key-binding)
- [💬 Feedback](#-feedback)
- [📄 License](#-license)

<!-- vim-markdown-toc -->

## 📦 Installation

Using [nvim-plug](https://github.com/wsdjeg/nvim-plug)

```lua
require('plug').add({
    {
        'wsdjeg/cpicker.nvim',
        depends = {
            { 'wsdjeg/logger.nvim' },
            { 'wsdjeg/notify.nvim' },
        },
    },
})
```

Then use `:Plug install cpicker.nvim` to install this plugin.

Using [luarocks](https://luarocks.org/)

```
luarocks install cpicker.nvim
```

## ⚙️ Basic Usage

1. open color palette with specific color models.

```
:Cpicker rgb hsl
```

2. open color palette with cursor highlight

```
:CpickerCursorForeground
```

3. open color mixer:

```
:CpickerColorMix #282828 #23EF12
```

4. Change the highlight of cursor position. This command will generate colorscheme patch which will be loaded when using same colorscheme.

```
:CpickerCursorChangeHighlight
```

Use `:CpickerClearColorPatch` command to clear colorscheme patch

## 🪟 Key binding

| key binding      | description |
| ---------------- | ----------- |
| `h` or `<Left>`  | reduce      |
| `l` or `<Right>` | increase    |
| `<Enter>`        | copy        |

## 💬 Feedback

If you encounter any bugs or have suggestions, please file an issue in the [issue tracker](https://github.com/wsdjeg/cpicker.nvim/issues)

## 📄 License

Licensed under GPL-3.0.

