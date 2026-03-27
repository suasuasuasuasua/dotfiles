# neovim

Neovim can be found under most package managers.

```sh
dnf install neovim
```

If you need a more recent version, you can compile it manually.


```sh
git clone https://github.com/neovim/neovim
cd neovim && make CMAKE_BUILD_TYPE=Release
make install
```

## Configuration

This configuration has been migrated from the kickstart.nvim project to Neovim's
modern native package manager setup since v0.12.

It takes advantage of the new builtin `vim.pack` to install and manage plugins
from GitHub, rather than using a third party package manager like `lazy.nvim` or
`mini.dependencies`. It is pretty barebones. The API only exposes four
functions: `add`, `update`, `get`, and `delete`. These are all pretty self
explanatory, and it requires either manual `lua` calls or wrapped user commands
that take advantage of these.

I like the `mini.nvim` project, which is a collection of standalone plugins that
improve the QOL of Neovim. These often have syngergies with one another and are
lightweight, so I prefer using these if possible.

The plugins are definitely optional, and general usage should still work fine
without them. The developoment experience may just be less ergonomic and rough
around the edges, particularly with the lack of a fuzzy file finder, pattern
searcher, or LSP.

> Though, Neovim does have native LSP support with `vim.lsp` since v0.11, so on
> this front it's moreso that you need to have acquire the LSPs and setup the
> configurations manually, which `mason.nvim` and `nvim-lspconfig` takes care
> of.
