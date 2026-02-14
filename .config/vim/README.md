# Vim

## Plugins

### LSP

`coc.nvim` is a decent completion engine for `vim`. 

It requires `nodejs` and a manual step of `npm ci` inside of the `coc.nvim`
directory.

```vim
"install an extension
:CocInstall coc-clangd

"see what is available, enabled, and disabled
:CocList extensions
```

- `@yaegassy/coc-pylsp`
- `coc-clangd`
- `coc-go`
- `coc-json`
- `coc-markdownlint`
- `coc-sh`
- `coc-tsserver`

- https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions
- https://github.com/neoclide/coc.nvim/wiki/Language-servers

You can search a marketplace using the following command.

```vim
:CocInstall coc-marketplace
```

- https://github.com/fannheyward/coc-marketplace

### Snippets

To get snippets working, we can use `coc.nvim`. Install the `coc-snippets`
extension for `coc`

```vim
:CocInstall coc-snippets coc-ultisnips
```

- https://github.com/neoclide/coc-snippets
- https://github.com/neoclide/coc.nvim/wiki/Using-snippets
