{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  xdg.enable = true;

  home.username = "rafa";
  home.homeDirectory = "/Users/rafa";

  home.stateVersion = "21.11";

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
    (import ./custom-overlays)
  ];

  home.packages = [
    pkgs.stow
    pkgs.git
    pkgs.ag
    pkgs.starship
    pkgs.graphviz
    pkgs.plantuml
    pkgs.nerdfonts
    pkgs.tree-sitter
    pkgs.neovim-nightly
    pkgs.jq
    pkgs.diff-so-fancy

    pkgs.gnupg
    pkgs.pinentry_mac
    pkgs.yubikey-personalization

    pkgs.Firefox
    pkgs.Rectangle
    pkgs.Alfred
    pkgs.iStatMenus
  ];

  programs.zsh = {
    enable = true;
    initExtra = ''
      source ''${HOME}/.nix-profile/etc/profile.d/nix.sh
      export NIX_PATH=$HOME/.nix-defexp/channels''${NIX_PATH:+:}$NIX_PATH

      export GPG_TTY="$(tty)"
      export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
      gpgconf --launch gpg-agent
    '';
    dotDir = ".config/zsh";
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    history = {
      ignoreDups = true;
      path = "${config.xdg.dataHome}/zsh/zsh_history";
    };
    shellAliases = {
      g = "git";
      vi = "nvim";
      ll = "ls -alh";

      gw = "./gradlew";
      uuid = "uuidgen | tr '[:upper:]' '[:lower:]' | pbcopy && pbpaste && echo";
    };

    sessionVariables = {
      EDITOR = "nvim";
      WORDCHARS = "*?_-.[]~=&;!#$%^(){}<>";
      TERM = "xterm-256color";
      PAGER = "less";
      LESS = "--ignore-case --RAW-CONTROL-CHARS -FX";
      CLICOLOR = "1";
      LSCOLORS = "exfxcxdxbxegedabagacad";
      GREP_OPTIONS = "--color=auto";
      GREP_COLOR = "3;33";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.autojump = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.bat.enable = true;

  programs.firefox = {
    enable = true;
    package = pkgs.Firefox;
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      privacy-badger
      decentraleyes
      clearurls
      cookie-autodelete
      https-everywhere
      multi-account-containers
      vimium
    ];
    profiles = 
      let defaultSettings = {
        "browser.startup.homepage" = "about:blank";
        "browser.search.region" = "GB";
        "browser.search.countryCode" = "GB";
        "browser.search.isUS" = false;
        "browser.ctrlTab.recentlyUsedOrder" = false;
        "browser.newtabpage.enabled" = false;
        "browser.bookmarks.showMobileBookmarks" = true;
        "browser.uidensity" = 1;
        "browser.urlbar.update1" = true;
        "distribution.searchplugins.defaultLocale" = "en-GB";
        "general.useragent.locale" = "en-GB";
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "privacy.trackingprotection.socialtracking.annotate.enabled" = true;
        "services.sync.declinedEngines" = "addons,passwords,prefs";
        "services.sync.engine.addons" = false;
        "services.sync.engineStatusChanged.addons" = true;
        "services.sync.engine.passwords" = false;
        "services.sync.engine.prefs" = false;
        "services.sync.engineStatusChanged.prefs" = true;
        "signon.rememberSignons" = false;
      };
      in {
        home = {
          id = 0;
          settings = defaultSettings;
          isDefault = true;
      };
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
