# NightVim

NightVim is a home-manager module to manager plugins for
[Neovim](https://github.io), offering a similar interface to
[lazy.nvim](https://github.com/folke/lazy.nvim) in Nix, and allowing to use
flake inputs to manage dependencies, as well as some simple boilerplate code to
simplify configuration.

## Requirements

- Nix
- Neovim

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

I have been using it exclusively on my
[config](https://github.com/cfcosta/neovim.nix) for more than 3 months without
any problems, but I can not guarantee that it will work the same for you.

If you do find any problem, please create an issue, or send a Pull Request. All
contributions are welcome!

## License

NightVim is licensed under the [MIT License](./LICENSE). If you have an
use-case that is incompatible with this license for any reason, please get in
touch and I can open an exception, or re-license the software with a different
one for anyone else in the same situation.
