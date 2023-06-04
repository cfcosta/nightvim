# NightVim

NightVim is a simple plugin manager solution for [Neovim](https://neovim.io),
offering a similar interface to [lazy.nvim](https://github.com/folke/lazy.nvim)
in Nix, and allowing to use flake inputs to manage dependencies, as well as
some simple boilerplate code to simplify configuration.

## Requirements

- Nix

## Testing

Currently there is no documentation because the structures themselves are still
being finalized, but there's an example configuration under
[`examples/full`](./examples/full) which is guiding the design.

You can test how the configuration works via the [`try.sh`](./try.sh) script,
which will build the config, and open a separated neovim instance with it:

```sh
curl https://raw.githubusercontent.com/cfcosta/nightvim/main/try.sh | bash
```

## Project Status

I have migrated my [config](https://github.com/cfcosta/neovim.nix) to it, and
it works really well.

What is missing:

- [ ] Lazy loading
- [ ] Two way serialization of setup options
- [ ] LSP/Tree-sitter modules
