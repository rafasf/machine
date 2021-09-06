# Machine Configuration

The configuration is built using [Nix][nix] and [home-manager][home-manager].

As of now it shares configuration with my original [dotfiles][dotfiles] as I
learn and understand better how the Nix ecosystem works and has.

## Set up

1. [Installing Nix in macOS][install]
2. [Installing home-manager][install-hm]
3. Get the files in this repo to `~/.config/nixpkgs`
4. Run: `home-manager switch`


[nix]: https://nixos.org
[home-manager]: https://github.com/nix-community/home-manager
[dotfiles]: https://github.com/rafasf/dots
[install]: https://nixos.org/manual/nix/stable/#sect-macos-installation
[install-hm]: https://github.com/nix-community/home-manager#installation
